const types = @import("types.zig");

pub const Batch = struct {
    columns: []const types.Column,
    rows: []const types.Row,
    sequence: u64,
};

/// Un lote y todos sus slices son prestados por la fuente. Solo siguen válidos
/// hasta que `next` vuelva a invocarse o se cierre la fuente. El consumidor debe
/// terminar `writeBatch` antes de pedir el siguiente lote; no puede retenerlo.
pub const BatchContract = struct {
    /// Número de filas en este lote. Todas las filas tienen tantas celdas como
    /// columnas haya en `columns`.
    pub fn rowCount(batch: Batch) usize {
        return batch.rows.len;
    }
};
