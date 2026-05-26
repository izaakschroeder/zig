# Support passing `--[no]-fatal-warnings` to linker

Currently `zig` does supports neither `-Wl,--fatal-warnings` nor `-Wl,--no-fatal-warnings`. Passing these flags should work correctly – by forwarding or transforming the appropriate arguments to the linker.

Tests should be written to verify the correct behavior of both zig's native linker (`-fno-lld`) and with lld (`-flld`) with `zig` and `zig cc`. Something like the following:

- `zig build-exe -flld -Wl,--fatal-warnings`
- `zig build-exe -flld -Wl,--no-fatal-warnings`
- `zig build-exe -fno-lld -Wl,--fatal-warnings`
- `zig build-exe -fno-lld -Wl,--no-fatal-warnings`
- `zig cc -flld -Wl,--fatal-warnings`
- `zig cc -flld -Wl,--no-fatal-warnings`
- `zig cc -fno-lld -Wl,--fatal-warnings`
- `zig cc -fno-lld -Wl,--no-fatal-warnings`
