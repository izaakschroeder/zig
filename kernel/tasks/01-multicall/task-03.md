# Have `zig install` also symlink `zig` itself

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

The `zig install` command should also symlink the `zig` command itself in addition to the other tools (e.g. `ar`, `objdump`, etc.)

For testing, make a temporary directory (stored in a `$TMPDIR` variable) and then:

```sh
$ZIG install --tools=all --prefix=$TMPDIR
```

And verify invoking `zig` from the installed directory works correctly and acts as `zig` and not some other command.
