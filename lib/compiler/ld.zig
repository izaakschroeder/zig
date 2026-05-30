const std = @import("std");
const Io = std.Io;
const mem = std.mem;
const fatal = std.process.fatal;

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const all_args = try init.minimal.args.toSlice(arena);
    const io = init.io;

    if (all_args.len < 3) {
        try Io.File.stdout().writeStreamingAll(io, usage);
        return;
    }

    const zig_path = all_args[1];
    const user_args = all_args[2..];

    for (user_args) |arg| {
        if (mem.eql(u8, arg, "-h") or mem.eql(u8, arg, "--help")) {
            return Io.File.stdout().writeStreamingAll(io, usage);
        }
    }

    var new_args: std.ArrayList([]const u8) = .empty;
    try new_args.append(arena, zig_path);
    try new_args.append(arena, "build-exe");

    var output_path: ?[]const u8 = null;
    var i: usize = 0;
    while (i < user_args.len) : (i += 1) {
        const arg = user_args[i];

        if (mem.eql(u8, arg, "-o")) {
            i += 1;
            if (i >= user_args.len) fatal("expected path after '-o'", .{});
            output_path = user_args[i];
        } else if (mem.eql(u8, arg, "-r")) {
            fatal("relocatable output (-r) is not yet supported", .{});
        } else if (mem.eql(u8, arg, "-s") or mem.eql(u8, arg, "-S")) {
            // strip flags - not yet supported
        } else if (mem.eql(u8, arg, "-E")) {
            // export dynamic - not yet supported
        } else if (mem.eql(u8, arg, "-static")) {
            // static link - not yet supported
        } else if (mem.eql(u8, arg, "-shared")) {
            fatal("shared library output (-shared) is not yet supported", .{});
        } else if (mem.eql(u8, arg, "-pie")) {
            try new_args.append(arena, "-fPIE");
        } else if (mem.eql(u8, arg, "-no-pie") or mem.eql(u8, arg, "-nopie")) {
            try new_args.append(arena, "-fno-PIE");
        } else if (mem.eql(u8, arg, "-z")) {
            if (i + 1 < user_args.len) i += 1;
        } else if (mem.startsWith(u8, arg, "-z")) {
            // combined -z flag
        } else if (mem.eql(u8, arg, "--start-group") or mem.eql(u8, arg, "--end-group")) {
            // archive grouping - not needed
        } else if (mem.eql(u8, arg, "--as-needed") or mem.eql(u8, arg, "--no-as-needed")) {
            // default behavior
        } else if (mem.eql(u8, arg, "--whole-archive") or mem.eql(u8, arg, "--no-whole-archive")) {
            // not yet supported
        } else if (mem.eql(u8, arg, "--gc-sections") or mem.eql(u8, arg, "--no-gc-sections")) {
            // not yet supported
        } else if (mem.eql(u8, arg, "--build-id") or mem.eql(u8, arg, "--no-build-id")) {
            // build-id is enabled by default
        } else if (mem.eql(u8, arg, "--no-dynamic-linker")) {
            try new_args.append(arena, arg);
        } else if (mem.startsWith(u8, arg, "--entry=")) {
            try new_args.append(arena, try std.fmt.allocPrint(arena, "-fentry={s}", .{arg["--entry=".len..]}));
        } else if (mem.startsWith(u8, arg, "--dynamic-linker=")) {
            try new_args.append(arena, arg);
        } else if (mem.startsWith(u8, arg, "--dynamic-linker")) {
            i += 1;
            if (i >= user_args.len) fatal("expected path after '--dynamic-linker'", .{});
            try new_args.append(arena, try std.fmt.allocPrint(arena, "--dynamic-linker={s}", .{user_args[i]}));
        } else if (mem.startsWith(u8, arg, "-l") or mem.startsWith(u8, arg, "-L")) {
            try new_args.append(arena, arg);
        } else if (mem.startsWith(u8, arg, "-")) {
            fatal("unrecognized option: {s}", .{arg});
        } else {
            try new_args.append(arena, arg);
        }
    }

    if (output_path) |path| {
        try new_args.append(arena, try std.fmt.allocPrint(arena, "-femit-bin={s}", .{path}));
    }

    const err = std.process.replace(io, .{
        .argv = new_args.items,
        .environ_map = init.environ_map,
    });
    fatal("failed to exec zig: {s}", .{@errorName(err)});
}

const usage =
    \\Usage: zig ld [options] [file...]
    \\
    \\Link object files into an executable using Zig's internal linker.
    \\
    \\Options:
    \\  -o <file>              Write output to <file> (default: a.out)
    \\  -l<name>               Link against system library
    \\  -L<dir>                Add directory to library search path
    \\  -pie                   Build a position-independent executable
    \\  -no-pie                Do not build a position-independent executable
    \\  --entry=<symbol>       Set entry point symbol
    \\  --dynamic-linker=<path> Set dynamic interpreter path
    \\  --no-dynamic-linker    Do not set dynamic interpreter path
    \\  --build-id             Generate build ID note
    \\  --gc-sections          Enable garbage collection of unused sections
    \\  -s                     Strip symbol table
    \\  -S                     Strip debug symbols
    \\  -h, --help             Print this help and exit
    \\
;
