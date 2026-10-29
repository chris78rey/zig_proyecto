const types = @import("types.zig");
const batch = @import("batch.zig");

pub const ModelError = error{
    Cancelled,
    InvalidArgument,
    Unavailable,
    SourceFailure,
    DestinationFailure,
    OutOfMemory,
    Internal,
};

/// Token compartido entre orquestador y adaptadores. La implementación debe
/// consultar la cancelación entre lotes y antes de operaciones bloqueantes.
pub const Cancellation = struct {
    context: *anyopaque,
    is_cancelled_fn: *const fn (*anyopaque) bool,

    pub fn isCancelled(self: Cancellation) bool {
        return self.is_cancelled_fn(self.context);
    }
};

pub const Source = struct {
    context: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        /// Las cadenas retornadas siguen válidas hasta la próxima operación de
        /// catálogo o `close` de esta fuente.
        list_schemas: *const fn (*anyopaque, Cancellation) ModelError![][]const u8,
        list_tables: *const fn (*anyopaque, types.Identifier, Cancellation) ModelError![]types.TableRef,
        /// Las columnas siguen válidas mientras la fuente esté abierta.
        open: *const fn (*anyopaque, types.TableRef, Cancellation) ModelError![]const types.Column,
        next: *const fn (*anyopaque, Cancellation) ModelError!?batch.Batch,
        close: *const fn (*anyopaque) void,
    };

    pub fn listSchemas(self: Source, cancellation: Cancellation) ModelError![][]const u8 {
        return self.vtable.list_schemas(self.context, cancellation);
    }

    pub fn listTables(self: Source, schema: types.Identifier, cancellation: Cancellation) ModelError![]types.TableRef {
        return self.vtable.list_tables(self.context, schema, cancellation);
    }

    pub fn open(self: Source, table: types.TableRef, cancellation: Cancellation) ModelError![]const types.Column {
        return self.vtable.open(self.context, table, cancellation);
    }

    pub fn next(self: Source, cancellation: Cancellation) ModelError!?batch.Batch {
        return self.vtable.next(self.context, cancellation);
    }

    pub fn close(self: Source) void {
        self.vtable.close(self.context);
    }
};

pub const Destination = struct {
    context: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        begin: *const fn (*anyopaque, types.TableRef, []const types.Column, Cancellation) ModelError!void,
        write_batch: *const fn (*anyopaque, batch.Batch, Cancellation) ModelError!void,
        finish: *const fn (*anyopaque, Cancellation) ModelError!void,
        abort: *const fn (*anyopaque) void,
    };

    pub fn begin(self: Destination, table: types.TableRef, columns: []const types.Column, cancellation: Cancellation) ModelError!void {
        return self.vtable.begin(self.context, table, columns, cancellation);
    }

    pub fn writeBatch(self: Destination, value: batch.Batch, cancellation: Cancellation) ModelError!void {
        return self.vtable.write_batch(self.context, value, cancellation);
    }

    pub fn finish(self: Destination, cancellation: Cancellation) ModelError!void {
        return self.vtable.finish(self.context, cancellation);
    }

    /// Debe retirar/invalidar salidas parciales para que no parezcan completas.
    pub fn abort(self: Destination) void {
        self.vtable.abort(self.context);
    }
};
