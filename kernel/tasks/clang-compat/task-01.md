# Allow `zig` to act as `clang` and `clang++`

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

In many scenarios it is desirable for `zig cc` to behave as if it were `clang` (or perhaps some other compiler). While `zig cc` is very close to being compatible with these programs, it's not always a drop-in replacement; therefore allowing `zig` to act like `clang` should help compatibility. 

Add the following commands:

- `zig clang`
- `zig clang++`

These will invoke the compiler just like `zig cc` and `zig c++` do, except they will provide some marker or indicator that the desired compiler compatibility mode is `.clang`.

If `-v` or `--version` is passed while acting as clang, a clang-compatible version string should be printed. The version should be set to the result of `LLVMGetVersion` which represents the version of `clang` zig intended to be compatible with; the target value should represent a converted version of the current zig target, and the installation directory should be set to something like `parentDir(selfExeDirPathAlloc())` (the actually installed path of `zig`).

```
zig clang version 22.1.5
Target: $ZIG_TARGET
Thread model: posix
InstalledDir: $ZIG_DIR
```

If no input files are provided the following clang-like error should be printed:

```
clang: no input files
```

If the `-h` or `--help` command is given, the equivalent `zig cc --help` or `zig c++ --help` should be printed.

These commands should be installable via `zig install`. Test each requirement to ensure correct functionality. Test cases should include:

- `zig install --tools=clang --prefix=$TMPDIR && $TMPDIR/clang` – Prints "no input files"
- `zig install --tools=clang --prefix=$TMPDIR && $TMPDIR/clang --help` – Prints the help
- `zig install --tools=clang --prefix=$TMPDIR && $TMPDIR/clang ./test.c -o test` – Compiles the given `c` file correctly and executing `./test` runs correctly 
- `zig install --tools=clang --prefix=$TMPDIR && $TMPDIR/clang --version` – Prints clang-formatted version information with correct target (matches system) and installation directory (does NOT end in `bin`)
