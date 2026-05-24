# Add support for `--strip-debug`

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Split out `--strip-debug`/`-S` separately from `--strip-all`/`-s`. We need to track the level of debugging symbols present in addition to their desired output format.

Logic is as follows:

- `-S` should assert `.debug = .strip`, but
