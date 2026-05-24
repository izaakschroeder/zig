# Disable `ubsan` by default when acting as `clang`

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

_ONLY_ when the `zig` binary is invoked as any member of the clang family (e.g. `clang`, `clang++`, etc.) disable `ubsan` by default. This can be done in a manner similar to the below code:

```zig
if (mod_opts.sanitize_c == null) {
    mod_opts.sanitize_c = .off;
}
```

Add the appropriate tests that verify this behavior works correctly.
