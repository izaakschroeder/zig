const builtin = @import("builtin");

const std = @import("std");
const Io = std.Io;
const mem = std.mem;
const fs = std.fs;
const Allocator = std.mem.Allocator;
const fatal = std.process.fatal;

const all_tools = .{
    "ar",
    "cc",
    "c++",
    "clang",
    "clang++",
    "dlltool",
    "ld",
    "lib",
    "objcopy",
    "objdump",
    "ranlib",
    "rc",
    "zig",
};

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(arena);
    const zig_exe = args[1];
    return cmdInstall(arena, io, zig_exe, args[2..]);
}

fn cmdInstall(arena: Allocator, io: Io, zig_exe: []const u8, args: []const []const u8) !void {
    var opt_tools: ?[]const u8 = null;
    var opt_prefix: ?[]const u8 = null;

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (mem.startsWith(u8, arg, "--tools=")) {
            opt_tools = arg["--tools=".len..];
        } else if (mem.startsWith(u8, arg, "--prefix=")) {
            opt_prefix = arg["--prefix=".len..];
        } else if (mem.eql(u8, arg, "--help") or mem.eql(u8, arg, "-h")) {
            return Io.File.stdout().writeStreamingAll(io, usage);
        } else {
            fatal("unrecognized argument: '{s}'", .{arg});
        }
    }

    const tools_str = opt_tools orelse fatal("expected --tools argument", .{});
    const prefix = opt_prefix orelse fatal("expected --prefix argument", .{});

    const install_all = mem.eql(u8, tools_str, "all");

    if (!install_all) {
        var found = false;
        inline for (all_tools) |tool| {
            if (mem.eql(u8, tools_str, @as([]const u8, tool))) {
                found = true;
            }
        }
        if (!found) fatal("unknown tool: '{s}'", .{tools_str});
    }

    const bin_dir = try fs.path.join(arena, &.{ prefix, "bin" });
    Io.Dir.cwd().createDirPath(io, bin_dir) catch |err| {
        fatal("failed to create directory '{s}': {t}", .{ bin_dir, err });
    };

    inline for (all_tools) |tool| {
        if (install_all or mem.eql(u8, tools_str, @as([]const u8, tool))) {
            const symlink_path = try fs.path.join(arena, &.{ bin_dir, tool });
            Io.Dir.cwd().symLinkAtomic(io, zig_exe, symlink_path, .{}) catch |err| {
                fatal("failed to create symlink '{s}' -> '{s}': {t}", .{ symlink_path, zig_exe, err });
            };
        }
    }
}

const usage =
    \\Usage: zig install --tools=<tool> --prefix=<prefix>
    \\
    \\Installs the given zig tool(s) by creating a symlink in <prefix>/bin
    \\that points to the zig executable. Use "all" to install all available tools.
    \\
    \\Options:
    \\  --tools=<tool>  Tool to install (e.g. objcopy, ar) or "all"
    \\  --prefix=<path> Installation prefix directory
    \\  -h, --help      Print this help and exit
    \\
;
