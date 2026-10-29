//! Orquestación síncrona y de memoria acotada entre Source y Destination.

const std = @import("std");
const models = @import("models");
const interfaces = models.interfaces;
const types = models.types;
const batch_model = models.batch;

pub const Clock = struct {
    context: ?*anyopaque = null,
    now_ms_fn: ?*const fn (?*anyopaque) u64 = null,

    fn nowMs(self: Clock) u64 {
        const now = self.now_ms_fn orelse return 0;
        return now(self.context);
    }
};

pub const Event = struct {
    state: types.ExportState,
    rows_processed: u64 = 0,
    current_batch: u64 = 0,
    elapsed_ms: u64 = 0,
    rows_per_second: f64 = 0,
    error_info: ?types.ErrorInfo = null,
};

pub const Observer = struct {
    context: *anyopaque,
    publish_fn: *const fn (*anyopaque, Event) void,

    fn publish(self: Observer, event: Event) void {
        self.publish_fn(self.context, event);
    }
};

pub fn run(
    source: interfaces.Source,
    destination: interfaces.Destination,
    table: types.TableRef,
    cancellation: interfaces.Cancellation,
    clock: Clock,
    observer: Observer,
) interfaces.ModelError!Event {
    defer source.close();
    errdefer destination.abort();

    var event = Event{ .state = .connecting };
    const started_ms = clock.nowMs();
    observer.publish(event);

    const result = runInner(source, destination, table, cancellation, clock, started_ms, observer, &event) catch |err| {
        event.state = if (err == error.Cancelled) .cancelled else .failed;
        event.error_info = if (err == error.Cancelled) null else errorInfo(err);
        updateTiming(&event, clock, started_ms);
        observer.publish(event);
        return err;
    };
    return result;
}

fn runInner(
    source: interfaces.Source,
    destination: interfaces.Destination,
    table: types.TableRef,
    cancellation: interfaces.Cancellation,
    clock: Clock,
    started_ms: u64,
    observer: Observer,
    event: *Event,
) interfaces.ModelError!Event {
    if (cancellation.isCancelled()) return error.Cancelled;
    const columns = try source.open(table, cancellation);
    if (cancellation.isCancelled()) return error.Cancelled;
    try destination.begin(table, columns, cancellation);

    while (true) {
        if (cancellation.isCancelled()) return error.Cancelled;
        event.state = .reading;
        updateTiming(event, clock, started_ms);
        observer.publish(event.*);

        const maybe_batch = try source.next(cancellation);
        const value: batch_model.Batch = maybe_batch orelse break;
        if (cancellation.isCancelled()) return error.Cancelled;

        event.state = .writing;
        event.current_batch = value.sequence;
        observer.publish(event.*);
        try destination.writeBatch(value, cancellation);
        event.rows_processed = std.math.add(u64, event.rows_processed, @intCast(value.rows.len)) catch return error.Internal;
        updateTiming(event, clock, started_ms);
        observer.publish(event.*);
    }

    if (cancellation.isCancelled()) return error.Cancelled;
    try destination.finish(cancellation);
    event.state = .completed;
    event.error_info = null;
    updateTiming(event, clock, started_ms);
    observer.publish(event.*);
    return event.*;
}

fn updateTiming(event: *Event, clock: Clock, started_ms: u64) void {
    const now = clock.nowMs();
    event.elapsed_ms = if (now >= started_ms) now - started_ms else 0;
    event.rows_per_second = if (event.elapsed_ms == 0)
        0
    else
        @as(f64, @floatFromInt(event.rows_processed)) * 1000.0 / @as(f64, @floatFromInt(event.elapsed_ms));
}

fn errorInfo(err: interfaces.ModelError) types.ErrorInfo {
    const code: types.ErrorCode = switch (err) {
        error.Cancelled => .cancelled,
        error.InvalidArgument => .invalid_argument,
        error.Unavailable => .unavailable,
        error.SourceFailure => .source,
        error.DestinationFailure => .destination,
        error.OutOfMemory => .out_of_memory,
        error.Internal => .internal,
    };
    const message: []const u8 = switch (code) {
        .cancelled => "Exportación cancelada",
        .invalid_argument => "La configuración de exportación no es válida",
        .unavailable => "Una dependencia no está disponible",
        .source => "No se pudo leer la tabla Oracle",
        .destination => "No se pudo escribir el destino Parquet",
        .out_of_memory => "Memoria insuficiente para continuar",
        .internal => "Ocurrió un error interno durante la exportación",
    };
    return .{ .code = code, .message = message, .retryable = err == error.Unavailable };
}
