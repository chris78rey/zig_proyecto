const std = @import("std");
const oracle = @import("oracle");
const models = @import("models");
const parquet = @import("parquet");
const runner = @import("export").runner;

fn neverCancelled(_: *anyopaque) bool {
    return false;
}
const ProgressContext = struct { enabled: bool };
fn publish(pointer: *anyopaque, event: runner.Event) void {
    const context: *ProgressContext = @ptrCast(@alignCast(pointer));
    if (!context.enabled) return;
    std.debug.print("EXPORT_PROGRESS rows={d} batch={d} state={s}\n", .{ event.rows_processed, event.current_batch, @tagName(event.state) });
}

pub fn main(init: std.process.Init) !void {
    const started = std.Io.Clock.awake.now(init.io);
    const username = init.environ_map.get("ORACLE_USER") orelse return missingCredentials();
    const password = init.environ_map.get("ORACLE_PASSWORD") orelse return missingCredentials();
    const host = init.environ_map.get("ORACLE_HOST") orelse return missingOracleConfig();
    const sid = init.environ_map.get("ORACLE_SID") orelse return missingOracleConfig();
    const directory = init.environ_map.get("PARQUET_OUTPUT_DIR") orelse {
        std.debug.print("Falta PARQUET_OUTPUT_DIR; indica un directorio local de salida.\n", .{});
        return error.MissingOutputDirectory;
    };
    if (username.len == 0 or password.len == 0 or directory.len == 0) return missingCredentials();

    const fetch_size = if (init.environ_map.get("ORACLE_FETCH_ARRAY_SIZE")) |raw|
        std.fmt.parseInt(u32, raw, 10) catch return error.InvalidFetchArraySize
    else
        1_000;
    const max_rows: ?u32 = if (init.environ_map.get("ORACLE_MAX_ROWS")) |raw|
        (if (std.ascii.eqlIgnoreCase(raw, "all")) null else std.fmt.parseInt(u32, raw, 10) catch return error.InvalidRowLimit)
    else
        1_000;
    const port = if (init.environ_map.get("ORACLE_PORT")) |raw|
        std.fmt.parseInt(u16, raw, 10) catch return error.InvalidOraclePort
    else
        1521;
    const config = oracle.config.Config{
        .username = username,
        .password = password,
        .host = host,
        .port = port,
        .endpoint = .{ .sid = sid },
        .fetch_array_size = fetch_size,
        .max_rows = max_rows,
    };
    const connection = oracle.source.OracleSource.connect(init.gpa, config) catch |err| {
        std.debug.print("Falló la conexión Oracle ({s}); no se inició la exportación.\n", .{@errorName(err)});
        return error.OracleConnectionFailed;
    };
    defer connection.destroy();

    var destination = parquet.ParquetDestination.init(init.gpa, .{ .directory = directory, .row_group_rows = 8_192 });
    defer destination.deinit();
    var cancel_context: u8 = 0;
    var observer_context = ProgressContext{ .enabled = std.mem.eql(u8, init.environ_map.get("EXPORT_PROGRESS") orelse "0", "1") };
    const cancellation = models.interfaces.Cancellation{ .context = &cancel_context, .is_cancelled_fn = neverCancelled };
    const observer = runner.Observer{ .context = &observer_context, .publish_fn = publish };
    const table = models.types.TableRef{
        .schema = init.environ_map.get("ORACLE_SCHEMA") orelse "TABLEAU",
        .table = init.environ_map.get("ORACLE_TABLE") orelse "ANALISISLABORATORIO",
    };
    const event = runner.run(connection.asSource(), destination.asDestination(), table, cancellation, .{}, observer) catch |err| {
        const diagnostic = connection.lastDiagnostic();
        if (diagnostic.code) |code| {
            std.debug.print("Falló la exportación ({s}, código Oracle={d}). No se publicaron partes completas.\n", .{ @errorName(err), code });
        } else if (diagnostic.unsupported_oracle_type) |oracle_type| {
            std.debug.print("Tipo Oracle no soportado ({d}); no se publicaron partes completas.\n", .{oracle_type});
        } else {
            std.debug.print("Falló la exportación Oracle → Parquet ({s}). No se publicaron partes completas.\n", .{@errorName(err)});
        }
        return error.OracleParquetExportFailed;
    };
    const elapsed_ns = started.durationTo(std.Io.Clock.awake.now(init.io)).nanoseconds;
    const elapsed_ms = @as(f64, @floatFromInt(elapsed_ns)) / @as(f64, @floatFromInt(std.time.ns_per_ms));
    const limit_label = if (max_rows) |limit| try std.fmt.allocPrint(init.gpa, "{d}", .{limit}) else "todos";
    defer if (max_rows != null) init.gpa.free(limit_label);
    std.debug.print("Exportación real correcta: {s}.{s}, filas={d}, archivo=part-00001.parquet, bytes={d}, limite={s}, tiempo_ejecucion={d:.3} ms. Valores omitidos.\n", .{ table.schema, table.table, event.rows_processed, destination.bytes_written, limit_label, elapsed_ms });
}

fn missingCredentials() error{MissingCredentials} {
    std.debug.print("Faltan ORACLE_USER y ORACLE_PASSWORD en el entorno local.\n", .{});
    return error.MissingCredentials;
}

fn missingOracleConfig() error{MissingOracleConfig} {
    std.debug.print("Faltan ORACLE_HOST y ORACLE_SID en el entorno local.\n", .{});
    return error.MissingOracleConfig;
}
