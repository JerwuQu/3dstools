const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "3dsxtool",
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibC();
    exe.linkLibCpp();
    exe.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{ "romfs.cpp", "3dsxtool.cpp" },
    });
    exe.addIncludePath(b.path("src"));
    b.installArtifact(exe);
}
