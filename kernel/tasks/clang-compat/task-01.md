# Allow `zig` to act as `clang` and `clang++`

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

In many scenarios it is desirable for `zig cc` to behave as if it were `clang` (or perhaps some other compiler). While `zig cc` is very close to being compatible with these programs, it's not always a drop-in replacement; therefore allowing `zig` to act like `clang` should help compatibility. 

Add the following commands:

- `zig clang`
- `zig clang++`

These will invoke the compiler just like `zig cc` and `zig c++` do, except they will provide some marker or indicator that the desired compiler compatibility mode is `.clang`.

These commands should also be installable via `zig install`.
