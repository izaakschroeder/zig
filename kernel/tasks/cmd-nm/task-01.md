# Add initial placeholder `nm` command

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Add `zig nm` as a valid command. It should be a `jitCmd` whose implementation lives in its own file `lib/compiler/nm.zig` (see other commands in that folder for examples). The command should accept the `--help`/`-h` argument for now, and otherwise just output placeholder text; actual implementation will be done in the future.

This command should be installable via `zig install` and tests should be updated to verify this works.
