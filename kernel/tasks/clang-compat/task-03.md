# Add support for `-m16`,`-m32`,`-m64` when acting as `clang`

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

The generated binary (or other machine) should respect the given bit width passed in the args, even if there is an architecture specified that has a higher bit width. For example:

```sh
zig clang -target=aarch64-linux-musl -m32 ...
```

Should result in an effective change of: 

```sh
zig clang -target=aarch64-linux-musl ...
```

The same effect should occur even if an explicit target is not specified. For example, if the host is a 64-bit machine, then:

```sh
zig clang -m32 ...
```

Should result in the target matching the host _EXCEPT_ the 32-bit version of that architecture. If the architecture doesn't support the given bit width or mode (for example, `-m16` is meaningless for ARM) raise an error.

Add the appropriate options to `src/clang_options_data.zig` and `tools/update_clang_options.zig` each for:

- `-m16`
- `-m32`
- `-m64`

Inside of `createModule` modify the `target_query` between `parseTargetQueryOrReportFatalError` and `resolveTargetQueryOrFatal` to remap the architecture based on the target bit width. For cleanliness, the core remapping logic should be done in a separate function.

Write tests to verify the remapping functionality. The tests should include both unit tests that verify the remapping function and changes to the resultant target, as well as integration tests that use the `file` command to verify the compiled output matches the appropriate architecture.
