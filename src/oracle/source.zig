const std = @import("std");
const api = @import("odpi_api.zig").c;
const models = @import("models");
const Config = @import("config.zig").Config;
const sql = @import("sql.zig");

const types = models.types;
const batch_model = models.batch;
const interfaces = models.interfaces;

pub const OracleDiagnostic = struct {
    /// Código ODPI-C/Oracle de la última operación fallida, si el cliente lo dio.
    code: ?i32 = null,
    /// Tipo numérico Oracle sin mapeo en el modelo compartido, si corresponde.
    unsupported_oracle_type: ?u32 = null,
};

pub const OracleSource = struct {
    allocator: std.mem.Allocator,
    context: *api.dpiContext,
    connection: *api.dpiConn,
    statement: ?*api.dpiStmt = null,
    columns: []const types.Column = &.{},
    fetch_array_size: u32,
    max_rows: ?u32,
    sequence: u64 = 0,
    closed: bool = false,
    diagnostic: OracleDiagnostic = .{},
    batch_arena: std.heap.ArenaAllocator,
    catalog_arena: std.heap.ArenaAllocator,
    metadata_arena: std.heap.ArenaAllocator,
    sql_arena: std.heap.ArenaAllocator,

    pub fn connect(allocator: std.mem.Allocator, cfg: Config) (interfaces.ModelError || std.mem.Allocator.Error)!*OracleSource {
        cfg.validate() catch return error.InvalidArgument;
        const self = try allocator.create(OracleSource);
        self.* = .{
            .allocator = allocator,
            .context = undefined,
            .connection = undefined,
            .fetch_array_size = cfg.fetch_array_size,
            .max_rows = cfg.max_rows,
            .batch_arena = std.heap.ArenaAllocator.init(allocator),
            .catalog_arena = std.heap.ArenaAllocator.init(allocator),
            .metadata_arena = std.heap.ArenaAllocator.init(allocator),
            .sql_arena = std.heap.ArenaAllocator.init(allocator),
        };

        var context_params = std.mem.zeroes(api.dpiContextCreateParams);
        var client_lib_dir_z: ?[:0]u8 = null;
        if (cfg.oracle_client_lib_dir) |path| {
            client_lib_dir_z = try allocator.dupeSentinel(u8, path, 0);
            context_params.oracleClientLibDir = client_lib_dir_z.?.ptr;
        }
        defer if (client_lib_dir_z) |path| allocator.free(path);

        var context: ?*api.dpiContext = null;
        var context_error: api.dpiErrorInfo = undefined;
        const context_params_ptr: ?*api.dpiContextCreateParams = if (cfg.oracle_client_lib_dir != null) &context_params else null;
        if (api.dpiContext_createWithParams(api.DPI_MAJOR_VERSION, api.DPI_MINOR_VERSION, context_params_ptr, &context, &context_error) < 0) {
            self.deinitStorage();
            allocator.destroy(self);
            return error.Unavailable;
        }
        self.context = context orelse {
            self.deinitStorage();
            allocator.destroy(self);
            return error.Unavailable;
        };

        const descriptor = cfg.connectDescriptor(allocator) catch |err| {
            self.releaseContext();
            self.deinitStorage();
            allocator.destroy(self);
            return err;
        };
        defer allocator.free(descriptor);

        var connection: ?*api.dpiConn = null;
        if (api.dpiConn_create(
            self.context,
            cfg.username.ptr,
            @intCast(cfg.username.len),
            cfg.password.ptr,
            @intCast(cfg.password.len),
            descriptor.ptr,
            @intCast(descriptor.len),
            null,
            null,
            &connection,
        ) < 0) {
            self.captureError();
            self.releaseContext();
            self.deinitStorage();
            allocator.destroy(self);
            return error.Unavailable;
        }
        self.connection = connection orelse {
            self.releaseContext();
            self.deinitStorage();
            allocator.destroy(self);
            return error.Unavailable;
        };
        return self;
    }

    /// El puntero permanece válido hasta `destroy`. El llamador debe evitar
    /// mover `OracleSource` (se devuelve asignada en heap).
    pub fn asSource(self: *OracleSource) interfaces.Source {
        return .{ .context = self, .vtable = &source_vtable };
    }

    pub fn lastDiagnostic(self: *const OracleSource) OracleDiagnostic {
        return self.diagnostic;
    }

    pub fn destroy(self: *OracleSource) void {
        self.close();
        self.deinitStorage();
        self.allocator.destroy(self);
    }

    fn listSchemas(self: *OracleSource, cancellation: interfaces.Cancellation) interfaces.ModelError![][]const u8 {
        if (self.closed) return error.SourceFailure;
        if (cancellation.isCancelled()) return error.Cancelled;
        self.diagnostic = .{};
        self.resetArena(&self.catalog_arena);
        return self.fetchCatalogStrings("SELECT DISTINCT owner FROM all_tables ORDER BY owner", 1, cancellation);
    }

    fn listTables(self: *OracleSource, schema: types.Identifier, cancellation: interfaces.Cancellation) interfaces.ModelError![]types.TableRef {
        if (self.closed) return error.SourceFailure;
        if (cancellation.isCancelled()) return error.Cancelled;
        self.diagnostic = .{};
        self.resetArena(&self.catalog_arena);
        const arena = self.catalog_arena.allocator();
        const owner = sql.quoteLiteral(arena, schema) catch return error.InvalidArgument;
        const query = std.fmt.allocPrint(arena, "SELECT owner, table_name FROM all_tables WHERE owner = {s} ORDER BY table_name", .{owner}) catch return error.OutOfMemory;
        return self.fetchCatalogTables(query, cancellation);
    }

    fn open(self: *OracleSource, table: types.TableRef, cancellation: interfaces.Cancellation) interfaces.ModelError![]const types.Column {
        if (self.closed) return error.SourceFailure;
        if (cancellation.isCancelled()) return error.Cancelled;
        self.closeStatement();
        self.resetArena(&self.metadata_arena);
        self.resetArena(&self.sql_arena);
        self.diagnostic = .{};

        const arena = self.sql_arena.allocator();
        const schema = sql.quoteIdentifier(arena, table.schema) catch return error.InvalidArgument;
        const table_name = sql.quoteIdentifier(arena, table.table) catch return error.InvalidArgument;
        const query = if (self.max_rows) |limit|
            std.fmt.allocPrint(arena, "SELECT * FROM {s}.{s} WHERE ROWNUM <= {d}", .{ schema, table_name, limit }) catch return error.OutOfMemory
        else
            std.fmt.allocPrint(arena, "SELECT * FROM {s}.{s}", .{ schema, table_name }) catch return error.OutOfMemory;
        const statement = try self.prepare(query);
        errdefer self.releaseStatement(statement);
        if (api.dpiStmt_setFetchArraySize(statement, self.fetch_array_size) < 0) return self.failSource();
        var column_count: u32 = 0;
        if (api.dpiStmt_execute(statement, api.DPI_MODE_EXEC_DEFAULT, &column_count) < 0) return self.failSource();

        const columns = self.metadata_arena.allocator().alloc(types.Column, column_count) catch return error.OutOfMemory;
        for (columns, 0..) |*column, index| {
            var info: api.dpiQueryInfo = undefined;
            if (api.dpiStmt_getQueryInfo(statement, @intCast(index + 1), &info) < 0) return self.failSource();
            const logical_type = mapOracleType(info.typeInfo.oracleTypeNum) orelse {
                self.diagnostic.unsupported_oracle_type = info.typeInfo.oracleTypeNum;
                return error.SourceFailure;
            };
            column.* = .{
                .name = self.metadata_arena.allocator().dupe(u8, info.name[0..info.nameLength]) catch return error.OutOfMemory,
                .logical_type = logical_type,
                .nullable = info.nullOk != 0,
                .precision = if (info.typeInfo.precision > 0) @intCast(info.typeInfo.precision) else null,
                .scale = if (logical_type == .decimal) @as(i16, info.typeInfo.scale) else null,
                .byte_length = if (info.typeInfo.clientSizeInBytes > 0) info.typeInfo.clientSizeInBytes else null,
            };
            if (api.dpiStmt_defineValue(
                statement,
                @intCast(index + 1),
                info.typeInfo.oracleTypeNum,
                nativeTypeFor(logical_type),
                info.typeInfo.clientSizeInBytes,
                1,
                null,
            ) < 0) return self.failSource();
        }
        self.statement = statement;
        self.columns = columns;
        self.sequence = 0;
        return self.columns;
    }

    fn next(self: *OracleSource, cancellation: interfaces.Cancellation) interfaces.ModelError!?batch_model.Batch {
        if (self.closed) return error.SourceFailure;
        const statement = self.statement orelse return error.SourceFailure;
        if (cancellation.isCancelled()) return error.Cancelled;
        self.resetArena(&self.batch_arena);
        const arena = self.batch_arena.allocator();
        const max_rows: usize = self.fetch_array_size;
        const column_count = self.columns.len;
        const rows = arena.alloc(types.Row, max_rows) catch return error.OutOfMemory;
        const cell_count = std.math.mul(usize, max_rows, column_count) catch return error.OutOfMemory;
        const cells = arena.alloc(types.Cell, cell_count) catch return error.OutOfMemory;

        var count: usize = 0;
        while (count < max_rows) {
            if (cancellation.isCancelled()) return error.Cancelled;
            var found: c_int = 0;
            var buffer_row_index: u32 = 0;
            if (api.dpiStmt_fetch(statement, &found, &buffer_row_index) < 0) return self.failSource();
            if (found == 0) break;
            const row_cells = cells[count * column_count ..][0..column_count];
            rows[count] = row_cells;
            for (self.columns, 0..) |column, column_index| {
                var native_type: api.dpiNativeTypeNum = 0;
                var data: ?*api.dpiData = null;
                if (api.dpiStmt_getQueryValue(statement, @intCast(column_index + 1), &native_type, &data) < 0) return self.failSource();
                row_cells[column_index] = self.copyValue(arena, column.logical_type, data orelse return error.SourceFailure) catch |err| return err;
            }
            count += 1;
        }
        if (count == 0) return null;
        self.sequence += 1;
        return .{ .columns = self.columns, .rows = rows[0..count], .sequence = self.sequence };
    }

    fn close(self: *OracleSource) void {
        if (self.closed) return;
        self.closeHandles();
        self.closed = true;
    }

    fn fetchCatalogStrings(self: *OracleSource, query: []const u8, column_pos: u32, cancellation: interfaces.Cancellation) interfaces.ModelError![][]const u8 {
        const statement = try self.prepare(query);
        defer self.releaseStatement(statement);
        if (api.dpiStmt_setFetchArraySize(statement, 256) < 0) return self.failSource();
        var column_count: u32 = 0;
        if (api.dpiStmt_execute(statement, api.DPI_MODE_EXEC_DEFAULT, &column_count) < 0) return self.failSource();

        const arena = self.catalog_arena.allocator();
        var items: [][]const u8 = &.{};
        var length: usize = 0;
        var capacity: usize = 0;
        while (true) {
            if (cancellation.isCancelled()) return error.Cancelled;
            var found: c_int = 0;
            var row_index: u32 = 0;
            if (api.dpiStmt_fetch(statement, &found, &row_index) < 0) return self.failSource();
            if (found == 0) break;
            var native_type: api.dpiNativeTypeNum = 0;
            var data: ?*api.dpiData = null;
            if (api.dpiStmt_getQueryValue(statement, column_pos, &native_type, &data) < 0) return self.failSource();
            const value = data orelse return error.SourceFailure;
            if (api.dpiData_getIsNull(value) != 0) continue;
            const bytes = try getBytes(value);
            const text = arena.dupe(u8, bytes) catch return error.OutOfMemory;
            try appendItem([]const u8, arena, &items, &length, &capacity, text);
        }
        return items[0..length];
    }

    fn fetchCatalogTables(self: *OracleSource, query: []const u8, cancellation: interfaces.Cancellation) interfaces.ModelError![]types.TableRef {
        const statement = try self.prepare(query);
        defer self.releaseStatement(statement);
        if (api.dpiStmt_setFetchArraySize(statement, 256) < 0) return self.failSource();
        var column_count: u32 = 0;
        if (api.dpiStmt_execute(statement, api.DPI_MODE_EXEC_DEFAULT, &column_count) < 0) return self.failSource();
        if (column_count < 2) return error.SourceFailure;

        const arena = self.catalog_arena.allocator();
        var items: []types.TableRef = &.{};
        var length: usize = 0;
        var capacity: usize = 0;
        while (true) {
            if (cancellation.isCancelled()) return error.Cancelled;
            var found: c_int = 0;
            var row_index: u32 = 0;
            if (api.dpiStmt_fetch(statement, &found, &row_index) < 0) return self.failSource();
            if (found == 0) break;
            var schema_data: ?*api.dpiData = null;
            var table_data: ?*api.dpiData = null;
            var native_type: api.dpiNativeTypeNum = 0;
            if (api.dpiStmt_getQueryValue(statement, 1, &native_type, &schema_data) < 0) return self.failSource();
            if (api.dpiStmt_getQueryValue(statement, 2, &native_type, &table_data) < 0) return self.failSource();
            const schema_bytes = try getBytes(schema_data orelse return error.SourceFailure);
            const table_bytes = try getBytes(table_data orelse return error.SourceFailure);
            const item = types.TableRef{
                .schema = arena.dupe(u8, schema_bytes) catch return error.OutOfMemory,
                .table = arena.dupe(u8, table_bytes) catch return error.OutOfMemory,
            };
            try appendItem(types.TableRef, arena, &items, &length, &capacity, item);
        }
        return items[0..length];
    }

    fn copyValue(self: *OracleSource, allocator: std.mem.Allocator, logical_type: types.LogicalType, data: *api.dpiData) interfaces.ModelError!types.Cell {
        _ = self;
        if (api.dpiData_getIsNull(data) != 0) return null;
        return switch (logical_type) {
            .boolean => .{ .boolean = api.dpiData_getBool(data) != 0 },
            .int64 => .{ .int64 = api.dpiData_getInt64(data) },
            .float64 => .{ .float64 = api.dpiData_getDouble(data) },
            .decimal, .utf8, .binary => blk: {
                const slice = try getBytes(data);
                const copied = allocator.dupe(u8, slice) catch return error.OutOfMemory;
                if (logical_type == .utf8 and !std.unicode.utf8ValidateSlice(copied)) return error.SourceFailure;
                if (logical_type == .decimal) break :blk .{ .decimal = copied };
                if (logical_type == .binary) break :blk .{ .binary = copied };
                break :blk .{ .utf8 = copied };
            },
            .date => error.SourceFailure,
            .timestamp, .timestamp_with_timezone => blk: {
                const value_ptr = api.dpiData_getTimestamp(data);
                if (value_ptr == null) return error.SourceFailure;
                const value = value_ptr[0];
                const timestamp = types.Timestamp{
                    .year = value.year,
                    .month = value.month,
                    .day = value.day,
                    .hour = value.hour,
                    .minute = value.minute,
                    .second = value.second,
                    .nanosecond = value.fsecond,
                };
                if (logical_type == .timestamp) break :blk .{ .timestamp = timestamp };
                const offset = @as(i16, value.tzHourOffset) * 60 + @as(i16, value.tzMinuteOffset);
                break :blk .{ .timestamp_with_timezone = .{ .timestamp = timestamp, .offset_minutes = offset } };
            },
        };
    }

    fn prepare(self: *OracleSource, query: []const u8) interfaces.ModelError!*api.dpiStmt {
        var statement: ?*api.dpiStmt = null;
        if (api.dpiConn_prepareStmt(self.connection, 0, query.ptr, @intCast(query.len), null, 0, &statement) < 0) return self.failSource();
        return statement orelse error.SourceFailure;
    }

    fn failSource(self: *OracleSource) interfaces.ModelError {
        self.captureError();
        return error.SourceFailure;
    }

    fn captureError(self: *OracleSource) void {
        var info: api.dpiErrorInfo = undefined;
        api.dpiContext_getError(self.context, &info);
        self.diagnostic.code = info.code;
    }

    fn releaseStatement(self: *OracleSource, statement: *api.dpiStmt) void {
        _ = self;
        _ = api.dpiStmt_release(statement);
    }

    fn closeStatement(self: *OracleSource) void {
        if (self.statement) |statement| self.releaseStatement(statement);
        self.statement = null;
        self.columns = &.{};
    }

    fn closeHandles(self: *OracleSource) void {
        self.closeStatement();
        _ = api.dpiConn_release(self.connection);
        _ = api.dpiContext_destroy(self.context);
    }

    fn releaseContext(self: *OracleSource) void {
        _ = api.dpiContext_destroy(self.context);
    }

    fn deinitStorage(self: *OracleSource) void {
        self.batch_arena.deinit();
        self.catalog_arena.deinit();
        self.metadata_arena.deinit();
        self.sql_arena.deinit();
    }

    fn resetArena(self: *OracleSource, arena: *std.heap.ArenaAllocator) void {
        arena.deinit();
        arena.* = std.heap.ArenaAllocator.init(self.allocator);
    }
};

fn getBytes(data: *api.dpiData) interfaces.ModelError![]const u8 {
    const bytes_ptr = api.dpiData_getBytes(data);
    if (bytes_ptr == null) return error.SourceFailure;
    const bytes = bytes_ptr[0];
    if (bytes.ptr == null) return error.SourceFailure;
    return bytes.ptr[0..bytes.length];
}

fn appendItem(comptime T: type, allocator: std.mem.Allocator, items: *[]T, length: *usize, capacity: *usize, item: T) interfaces.ModelError!void {
    if (length.* == capacity.*) {
        const next_capacity = if (capacity.* == 0) @as(usize, 16) else capacity.* * 2;
        items.* = allocator.realloc(items.*, next_capacity) catch return error.OutOfMemory;
        capacity.* = next_capacity;
    }
    items.*[length.*] = item;
    length.* += 1;
}

fn mapOracleType(oracle_type: api.dpiOracleTypeNum) ?types.LogicalType {
    return switch (oracle_type) {
        api.DPI_ORACLE_TYPE_NUMBER => .decimal,
        api.DPI_ORACLE_TYPE_NATIVE_FLOAT, api.DPI_ORACLE_TYPE_NATIVE_DOUBLE => .float64,
        api.DPI_ORACLE_TYPE_VARCHAR, api.DPI_ORACLE_TYPE_NVARCHAR, api.DPI_ORACLE_TYPE_CHAR, api.DPI_ORACLE_TYPE_NCHAR, api.DPI_ORACLE_TYPE_LONG_VARCHAR, api.DPI_ORACLE_TYPE_LONG_NVARCHAR => .utf8,
        api.DPI_ORACLE_TYPE_RAW, api.DPI_ORACLE_TYPE_LONG_RAW => .binary,
        api.DPI_ORACLE_TYPE_DATE, api.DPI_ORACLE_TYPE_TIMESTAMP => .timestamp,
        api.DPI_ORACLE_TYPE_TIMESTAMP_TZ, api.DPI_ORACLE_TYPE_TIMESTAMP_LTZ => .timestamp_with_timezone,
        api.DPI_ORACLE_TYPE_BOOLEAN => .boolean,
        else => null,
    };
}

fn nativeTypeFor(logical_type: types.LogicalType) api.dpiNativeTypeNum {
    return switch (logical_type) {
        .decimal, .utf8, .binary => api.DPI_NATIVE_TYPE_BYTES,
        .boolean => api.DPI_NATIVE_TYPE_BOOLEAN,
        .int64 => api.DPI_NATIVE_TYPE_INT64,
        .float64 => api.DPI_NATIVE_TYPE_DOUBLE,
        .date, .timestamp, .timestamp_with_timezone => api.DPI_NATIVE_TYPE_TIMESTAMP,
    };
}

fn fromOpaque(pointer: *anyopaque) *OracleSource {
    return @ptrCast(@alignCast(pointer));
}

fn vListSchemas(pointer: *anyopaque, cancel: interfaces.Cancellation) interfaces.ModelError![][]const u8 {
    return fromOpaque(pointer).listSchemas(cancel);
}
fn vListTables(pointer: *anyopaque, schema: types.Identifier, cancel: interfaces.Cancellation) interfaces.ModelError![]types.TableRef {
    return fromOpaque(pointer).listTables(schema, cancel);
}
fn vOpen(pointer: *anyopaque, table: types.TableRef, cancel: interfaces.Cancellation) interfaces.ModelError![]const types.Column {
    return fromOpaque(pointer).open(table, cancel);
}
fn vNext(pointer: *anyopaque, cancel: interfaces.Cancellation) interfaces.ModelError!?batch_model.Batch {
    return fromOpaque(pointer).next(cancel);
}
fn vClose(pointer: *anyopaque) void {
    fromOpaque(pointer).close();
}

const source_vtable = interfaces.Source.VTable{
    .list_schemas = vListSchemas,
    .list_tables = vListTables,
    .open = vOpen,
    .next = vNext,
    .close = vClose,
};
