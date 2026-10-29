//! Mapeo contractual de tipos compartidos al esquema Parquet.
//!
//! Este módulo no abre archivos: el backend Parquet queda pendiente de una
//! biblioteca que compile con la versión Zig del proyecto.

const types = @import("models").types;

pub const PhysicalType = enum {
    boolean,
    int64,
    double,
    byte_array,
    int32,
};

pub const Annotation = enum {
    none,
    string,
    decimal,
    date,
    timestamp_nanos_utc,
};

pub const Field = struct {
    physical: PhysicalType,
    annotation: Annotation,
    nullable: bool,
    precision: ?u16 = null,
    scale: ?i16 = null,
};

pub const MappingError = error{
    InvalidDecimalMetadata,
    UnsupportedLogicalType,
};

/// Oracle NUMBER se representa como UTF8 decimal para preservar exactamente el
/// texto que entrega ODPI-C, incluso si no hay precision/scale Parquet válidos.
pub fn field(column: types.Column) MappingError!Field {
    return switch (column.logical_type) {
        .boolean => .{ .physical = .boolean, .annotation = .none, .nullable = column.nullable },
        .int64 => .{ .physical = .int64, .annotation = .none, .nullable = column.nullable },
        .float64 => .{ .physical = .double, .annotation = .none, .nullable = column.nullable },
        .utf8 => .{ .physical = .byte_array, .annotation = .string, .nullable = column.nullable },
        .binary => .{ .physical = .byte_array, .annotation = .none, .nullable = column.nullable },
        .date => .{ .physical = .int32, .annotation = .date, .nullable = column.nullable },
        .timestamp => .{ .physical = .int64, .annotation = .timestamp_nanos_utc, .nullable = column.nullable },
        .timestamp_with_timezone => .{ .physical = .int64, .annotation = .timestamp_nanos_utc, .nullable = column.nullable },
        .decimal => .{ .physical = .byte_array, .annotation = .string, .nullable = column.nullable },
    };
}
