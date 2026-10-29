const std = @import("std");

pub const SqlError = error{InvalidIdentifier};

/// Cita un identificador Oracle como identificador SQL, duplicando las comillas.
/// Rechaza vacío, NUL y nombres sobre 30 bytes para mantener compatibilidad 11gR2.
pub fn quoteIdentifier(allocator: std.mem.Allocator, value: []const u8) (SqlError || std.mem.Allocator.Error)![]u8 {
    if (value.len == 0 or value.len > 30 or std.mem.indexOfScalar(u8, value, 0) != null) {
        return error.InvalidIdentifier;
    }

    const quote_count = std.mem.count(u8, value, "\"");
    const result = try allocator.alloc(u8, value.len + quote_count + 2);
    result[0] = '"';
    var out: usize = 1;
    for (value) |ch| {
        if (ch == '"') {
            result[out] = '"';
            out += 1;
        }
        result[out] = ch;
        out += 1;
    }
    result[out] = '"';
    return result;
}

/// Cita un literal SQL; se usa solo para el filtro de catálogo ALL_TABLES.
pub fn quoteLiteral(allocator: std.mem.Allocator, value: []const u8) (SqlError || std.mem.Allocator.Error)![]u8 {
    if (std.mem.indexOfScalar(u8, value, 0) != null) return error.InvalidIdentifier;
    const quote_count = std.mem.count(u8, value, "'");
    const result = try allocator.alloc(u8, value.len + quote_count + 2);
    result[0] = '\'';
    var out: usize = 1;
    for (value) |ch| {
        if (ch == '\'') {
            result[out] = '\'';
            out += 1;
        }
        result[out] = ch;
        out += 1;
    }
    result[out] = '\'';
    return result;
}
