const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "3dsxtool",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    exe.linkLibC();
    exe.linkLibCpp();
    exe.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{ "romfs.cpp", "3dsxtool.cpp" },
    });
    exe.addIncludePath(b.path("src"));
    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}
