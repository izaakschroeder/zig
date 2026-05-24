# Add a `zig install` command

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

A new command should be introduced `zig install --tools=$TOOLS --prefix=$PREFIX` which installs the given `$TOOLS` (e.g. `objcopy`, `ar`, etc.) by symlinking them inside of `$PREFIX/bin` (e.g. `/usr/bin/objcopy`, `/usr/bin/ar`) that point to the current `zig` executable. A special value `all` for `$TOOLS` means to install all available tools.

This command should be a `jitCmd` whose implementation lives in its own file `lib/compiler/install.zig` (see commands in `lib/compiler` for examples).

For testing, make a temporary directory (stored in a `$TMPDIR` variable) and then:

```sh
$ZIG install --tools=all --prefix=$TMPDIR
```

And verify invoking each of the linked programs correctly invoke `zig`.
