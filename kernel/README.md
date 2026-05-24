# Overview

The high-level goal of this effort is to compile the Linux kernel with Zig. Information about this project:

- Use latest `zig` source version in this repository; looking up standard library information can be done in this repository
- Use the new `Io` interface (see `lib/std/Io.zig` for implementation) and _NOT_ the legacy `io` module (note the title-case one is correct, the lowercase one is INCORRECT)
- Re-use or extend existing `zig` structs when possible (e.g. use or extend `lib/std/elf.zig` instead of developing a new `Elf` struct or parser)
- Use `podman` to perform tests and execution of the compiled `zig` compiler binary

When making changes to the `zig` compiler, the new compiler can be built via executing `kernel/test/build.sh`. This generates a local container image named `zig`. This image can then be run via `podman run zig`. 

For example, running a shell script to test the `zig` compiler:

```sh
podman run --rm -i zig /bin/ash <<EOF
zig version
EOF
```

Running specific `zig` build commands:

```sh
podman run --rm -v "./:/src:z" zig zig build test-cli
```
