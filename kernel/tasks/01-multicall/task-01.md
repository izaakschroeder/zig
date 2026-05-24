# Allow `zig` to act as multi-call binary

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Using zig's tooling as a drop-in replacement for certain tools is often achieved via environment variable replacement (e.g. `AR=zig ar`) but this is both cumbersome and inefficient. It would be much better if `zig` KNEW it was being called as `ar` and act accordingly.

Within `./src/main.zig` use something like:

```zig
const MULTI_CALL_COMMANDS = .{
    "ar",
    "cc",
    // ... etc.
};

// args here is the CLI args
inline for (MULTI_CALL_COMMANDS) |cmd| {
    if (mem.eql(u8, args[0], cmd)) {
        // here, shift "zig" to the front of the args array
        // if args = ["ar", "--help"] then
        // result should be args = ['zig', "ar", "--help"]
        break;
    }
}
```

The list of multi-call tools provided by `zig` is:

- ar
- cc
- c++
- dlltool
- lib
- objcopy
- objdump
- ranlib
- rc

Any additional commands added by this project should also be included after those commands have been implemented.

An integration test should be created to verify the multi-call behavior works as expected.
