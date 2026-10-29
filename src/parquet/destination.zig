//! Escritor Parquet Arrow con lotes síncronos y publicación por rename.
const std = @import("std");
const models = @import("models");
const types = models.types;
const interfaces = models.interfaces;
const CColumn = extern struct { type: i32, nullable: i32, precision: i32, scale: i32, name: [*]const u8, name_len: u64 };
const CCell = extern struct {
    is_null: i32 = 0,
    boolean_value: i32 = 0,
    integer_value: i64 = 0,
    float_value: f64 = 0,
    bytes: ?[*]const u8 = null,
    bytes_len: u64 = 0,
    year: i32 = 0,
    month: i32 = 0,
    day: i32 = 0,
    hour: i32 = 0,
    minute: i32 = 0,
    second: i32 = 0,
    nanosecond: u32 = 0,
    offset_minutes: i32 = 0,
};
extern "c" fn pq_writer_create([*]const u8, u64, [*]const CColumn, u64, u64, [*]u8, u64) ?*anyopaque;
extern "c" fn pq_writer_write(?*anyopaque, [*]const CCell, u64, [*]u8, u64) c_int;
extern "c" fn pq_writer_finish(?*anyopaque, *u64, *u64, [*]u8, u64) c_int;
extern "c" fn pq_writer_abort(?*anyopaque) void;
extern "c" fn pq_writer_destroy(?*anyopaque) void;

pub const Config = struct {
    directory: []const u8,
    row_group_rows: u64 = 8192,
};

pub const ParquetDestination = struct {
    allocator: std.mem.Allocator,
    config: Config,
    writer: ?*anyopaque = null,
    columns: []const types.Column = &.{},
    error_buffer: [512]u8 = @splat(0),
    rows_written: u64 = 0,
    bytes_written: u64 = 0,

    pub fn init(allocator: std.mem.Allocator, config: Config) ParquetDestination {
        return .{ .allocator = allocator, .config = config };
    }

    pub fn asDestination(self: *ParquetDestination) interfaces.Destination {
        return .{ .context = self, .vtable = &vtable };
    }

    pub fn deinit(self: *ParquetDestination) void {
        if (self.writer) |writer| {
            pq_writer_abort(writer);
            pq_writer_destroy(writer);
            self.writer = null;
        }
    }

    fn begin(self: *ParquetDestination, columns: []const types.Column, cancellation: interfaces.Cancellation) interfaces.ModelError!void {
        if (cancellation.isCancelled()) return error.Cancelled;
        if (self.writer != null or columns.len == 0 or self.config.row_group_rows == 0) return error.InvalidArgument;
        const path = self.allocator.dupe(u8, self.config.directory) catch return error.OutOfMemory;
        defer self.allocator.free(path);
        const specs = self.allocator.alloc(CColumn, columns.len) catch return error.OutOfMemory;
        defer self.allocator.free(specs);
        for (columns, 0..) |col, i| {
            specs[i] = .{
                .type = switch (col.logical_type) {
                    .boolean => 0,
                    .int64 => 1,
                    .float64 => 2,
                    .decimal => 3,
                    .utf8 => 4,
                    .binary => 5,
                    .date => 6,
                    .timestamp => 7,
                    .timestamp_with_timezone => 8,
                },
                .nullable = @intFromBool(col.nullable),
                .precision = col.precision orelse 0,
                .scale = col.scale orelse 0,
                .name = col.name.ptr,
                .name_len = col.name.len,
            };
        }
        const writer = pq_writer_create(path.ptr, self.config.directory.len, specs.ptr, specs.len, self.config.row_group_rows, &self.error_buffer, self.error_buffer.len) orelse return error.DestinationFailure;
        self.writer = writer;
        self.columns = columns;
        self.rows_written = 0;
    }

    fn writeBatch(self: *ParquetDestination, value: models.batch.Batch, cancellation: interfaces.Cancellation) interfaces.ModelError!void {
        const writer = self.writer orelse return error.DestinationFailure;
        if (cancellation.isCancelled()) return error.Cancelled;
        if (value.columns.len != self.columns.len) return error.InvalidArgument;
        const ncols = self.columns.len;
        const ncell = std.math.mul(usize, value.rows.len, ncols) catch return error.OutOfMemory;
        const cells = self.allocator.alloc(CCell, ncell) catch return error.OutOfMemory;
        defer self.allocator.free(cells);
        for (value.rows, 0..) |row, ri| {
            if (row.len != ncols) return error.InvalidArgument;
            for (row, 0..) |maybe, ci| {
                var cell = std.mem.zeroes(CCell);
                if (maybe) |v| {
                    switch (v) {
                        .boolean => |x| cell.boolean_value = @intFromBool(x),
                        .int64 => |x| cell.integer_value = x,
                        .float64 => |x| cell.float_value = x,
                        .decimal => |x| {
                            cell.bytes = x.ptr;
                            cell.bytes_len = x.len;
                        },
                        .utf8 => |x| {
                            cell.bytes = x.ptr;
                            cell.bytes_len = x.len;
                        },
                        .binary => |x| {
                            cell.bytes = x.ptr;
                            cell.bytes_len = x.len;
                        },
                        .date => |x| {
                            cell.year = x.year;
                            cell.month = x.month;
                            cell.day = x.day;
                        },
                        .timestamp => |x| fillTimestamp(&cell, x),
                        .timestamp_with_timezone => |x| {
                            fillTimestamp(&cell, x.timestamp);
                            cell.offset_minutes = x.offset_minutes;
                        },
                    }
                } else {
                    if (!self.columns[ci].nullable) return error.DestinationFailure;
                    cell.is_null = 1;
                }
                cells[ri * ncols + ci] = cell;
            }
        }
        if (pq_writer_write(writer, cells.ptr, value.rows.len, &self.error_buffer, self.error_buffer.len) != 0) return error.DestinationFailure;
        self.rows_written += value.rows.len;
    }

    fn finish(self: *ParquetDestination, cancellation: interfaces.Cancellation) interfaces.ModelError!void {
        if (cancellation.isCancelled()) return error.Cancelled;
        const writer = self.writer orelse return error.DestinationFailure;
        if (pq_writer_finish(writer, &self.rows_written, &self.bytes_written, &self.error_buffer, self.error_buffer.len) != 0) return error.DestinationFailure;
        pq_writer_destroy(writer);
        self.writer = null;
    }

    fn abort(self: *ParquetDestination) void {
        self.deinit();
    }
};

fn fillTimestamp(cell: *CCell, value: types.Timestamp) void {
    cell.year = value.year;
    cell.month = value.month;
    cell.day = value.day;
    cell.hour = value.hour;
    cell.minute = value.minute;
    cell.second = value.second;
    cell.nanosecond = value.nanosecond;
    cell.offset_minutes = -2147483648;
}

fn fromOpaque(pointer: *anyopaque) *ParquetDestination {
    return @ptrCast(@alignCast(pointer));
}
fn vBegin(pointer: *anyopaque, _: types.TableRef, columns: []const types.Column, cancel: interfaces.Cancellation) interfaces.ModelError!void {
    return fromOpaque(pointer).begin(columns, cancel);
}
fn vWrite(pointer: *anyopaque, batch: models.batch.Batch, cancel: interfaces.Cancellation) interfaces.ModelError!void {
    return fromOpaque(pointer).writeBatch(batch, cancel);
}
fn vFinish(pointer: *anyopaque, cancel: interfaces.Cancellation) interfaces.ModelError!void {
    return fromOpaque(pointer).finish(cancel);
}
fn vAbort(pointer: *anyopaque) void {
    fromOpaque(pointer).abort();
}
const vtable = interfaces.Destination.VTable{ .begin = vBegin, .write_batch = vWrite, .finish = vFinish, .abort = vAbort };
