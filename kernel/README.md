# Overview

The high-level goal of this effort is to compile the Linux kernel with Zig. Information about this project:

- Use latest `zig` source version in this repository; looking up standard library information can be done in this repository
- Use the new `Io` interface (see `lib/std/Io.zig` for implementation) and _NOT_ the legacy `io` module (note the title-case one is correct, the lowercase one is INCORRECT)
- Re-use or extend existing `zig` structs when possible (e.g. use or extend `lib/std/elf.zig` instead of developing a new `Elf` struct or parser)

When making changes to the `zig` compiler, the new compiler can be built via executing `kernel/build.sh`. This generates a `zig` binary located at `build/zig/$ARCH/bin/zig` and then symlinks it to `/usr/bin/zig`.

Example of getting the version:

```sh
zig version
```

Example of running a specific `zig` build command:

```sh
zig build test-cli
```
