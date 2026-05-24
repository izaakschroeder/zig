# Add initial placeholder `strip` command

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Add `zig strip` as a valid command. It should be a `jitCmd` whose implementation lives in its own file `lib/compiler/strip.zig` (see other commands in that folder for examples). The command should just output placeholder text for now.

This command should also be installable via `zig install`.
