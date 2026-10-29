const std = @import("std");

pub const Endpoint = union(enum) {
    sid: []const u8,
    service_name: []const u8,
};

/// El usuario y la contraseña los aporta la capa de configuración. Este tipo
/// no los imprime ni conserva una copia después de crear la conexión.
pub const Config = struct {
    username: []const u8,
    password: []const u8,
    host: []const u8,
    port: u16 = 1521,
    endpoint: Endpoint = .{ .sid = "prdsgh2" },
    fetch_array_size: u32 = 10_000,
    /// Límite opcional para sondeos seguros; null permite leer la tabla completa.
    max_rows: ?u32 = null,
    oracle_client_lib_dir: ?[]const u8 = null,

    pub fn validate(self: Config) error{InvalidArgument}!void {
        if (self.username.len == 0 or self.password.len == 0 or self.port == 0) {
            return error.InvalidArgument;
        }
        if (self.username.len > std.math.maxInt(u32) or self.password.len > std.math.maxInt(u32)) return error.InvalidArgument;
        if (std.mem.indexOfScalar(u8, self.username, 0) != null or std.mem.indexOfScalar(u8, self.password, 0) != null) return error.InvalidArgument;
        if (self.fetch_array_size == 0 or self.fetch_array_size > 50_000) {
            return error.InvalidArgument;
        }
        if (self.max_rows) |limit| {
            if (limit == 0 or limit > 50_000) return error.InvalidArgument;
        }
        if (!validHost(self.host)) return error.InvalidArgument;
        switch (self.endpoint) {
            .sid => |value| if (!validDescriptorPart(value)) return error.InvalidArgument,
            .service_name => |value| if (!validDescriptorPart(value)) return error.InvalidArgument,
        }
    }

    pub fn connectDescriptor(self: Config, allocator: std.mem.Allocator) (std.mem.Allocator.Error || error{InvalidArgument})![]u8 {
        try self.validate();
        return switch (self.endpoint) {
            .sid => |sid| std.fmt.allocPrint(
                allocator,
                "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={s})(PORT={d}))(CONNECT_DATA=(SERVER=DEDICATED)(SID={s})))",
                .{ self.host, self.port, sid },
            ),
            .service_name => |name| std.fmt.allocPrint(
                allocator,
                "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={s})(PORT={d}))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME={s})))",
                .{ self.host, self.port, name },
            ),
        };
    }
};

fn validHost(value: []const u8) bool {
    if (value.len == 0) return false;
    for (value) |ch| {
        if (!std.ascii.isAlphanumeric(ch) and ch != '.' and ch != '-' and ch != ':') return false;
    }
    return true;
}

fn validDescriptorPart(value: []const u8) bool {
    if (value.len == 0) return false;
    for (value) |ch| {
        if (!std.ascii.isAlphanumeric(ch) and ch != '.' and ch != '-' and ch != '_' and ch != '$' and ch != '#') return false;
    }
    return true;
}
