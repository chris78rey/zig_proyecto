const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const models = b.createModule(.{
        .root_source_file = b.path("src/models/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const oracle = b.createModule(.{
        .root_source_file = b.path("src/oracle/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    oracle.addImport("models", models);

    const app = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .link_libcpp = false,
    });
    app.addImport("oracle", oracle);
    app.addImport("models", models);
    const export_module = b.createModule(.{
        .root_source_file = b.path("src/export/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    export_module.addImport("models", models);
    app.addImport("export", export_module);
    const parquet = b.createModule(.{
        .root_source_file = b.path("src/parquet/destination.zig"),
        .target = target,
        .optimize = optimize,
    });
    parquet.addImport("models", models);
    app.addImport("parquet", parquet);
    const stdcpp_lib = b.graph.environ_map.get("STDCXX_LIB") orelse "/usr/lib/x86_64-linux-gnu/libstdc++.so.6";
    const gcc_s_lib = b.graph.environ_map.get("GCC_S_LIB") orelse "/lib/x86_64-linux-gnu/libgcc_s.so.1";
    app.addObjectFile(.{ .cwd_relative = stdcpp_lib });
    app.addObjectFile(.{ .cwd_relative = gcc_s_lib });
    app.addIncludePath(b.path("src/parquet"));
    app.addIncludePath(b.path("src/oracle/vendor/odpi-c/include"));
    const pyarrow_dir = b.graph.environ_map.get("PYARROW_DIR") orelse @panic("PyArrow C++ requerido: instala pyarrow y define PYARROW_DIR al compilar");
    const arrow_lib = b.graph.environ_map.get("PYARROW_ARROW_LIB") orelse @panic("Define PYARROW_ARROW_LIB apuntando al libarrow.so incluido en PyArrow");
    const parquet_lib = b.graph.environ_map.get("PYARROW_PARQUET_LIB") orelse @panic("Define PYARROW_PARQUET_LIB apuntando al libparquet.so incluido en PyArrow");
    app.addIncludePath(.{ .cwd_relative = b.fmt("{s}/include", .{pyarrow_dir}) });
    app.addLibraryPath(.{ .cwd_relative = pyarrow_dir });
    app.addRPath(.{ .cwd_relative = pyarrow_dir });
    app.addObjectFile(.{ .cwd_relative = parquet_lib });
    app.addObjectFile(.{ .cwd_relative = arrow_lib });
    app.addCSourceFiles(.{
        .root = b.path("src/oracle/vendor/odpi-c/src"),
        .files = &.{
            "dpiConn.c",           "dpiContext.c",    "dpiData.c",       "dpiDebug.c",
            "dpiDeqOptions.c",     "dpiEnqOptions.c", "dpiEnv.c",        "dpiError.c",
            "dpiGen.c",            "dpiGlobal.c",     "dpiHandleList.c", "dpiHandlePool.c",
            "dpiJson.c",           "dpiLob.c",        "dpiMsgProps.c",   "dpiObject.c",
            "dpiObjectAttr.c",     "dpiObjectType.c", "dpiOci.c",        "dpiOracleType.c",
            "dpiPool.c",           "dpiQueue.c",      "dpiRowid.c",      "dpiSodaColl.c",
            "dpiSodaCollCursor.c", "dpiSodaDb.c",     "dpiSodaDoc.c",    "dpiSodaDocCursor.c",
            "dpiStmt.c",           "dpiStringList.c", "dpiSubscr.c",     "dpiUtils.c",
            "dpiVar.c",            "dpiVector.c",
        },
        .flags = &.{"-std=c99"},
    });
    app.linkSystemLibrary("dl", .{ .use_pkg_config = .no });

    const exe = b.addExecutable(.{
        .name = "oracle-parquet-export",
        .root_module = app,
    });
    const compile_arrow = b.addSystemCommand(&.{
        "bash", "scripts/build-arrow-shim.sh", pyarrow_dir,
    });
    exe.root_module.addObjectFile(b.path("zig-out/lib/arrow_shim.o"));
    exe.step.dependOn(&compile_arrow.step);
    b.installArtifact(exe);

    const run = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the capped Oracle to Parquet export probe");
    run_step.dependOn(&run.step);
}
