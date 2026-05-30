# Implement basic `zig ld` command

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Expose basic linking capabilities from zig to the outside work. This should use zig's internal linker. The implementation should live in `lib/compiler/ld.zig` and replace any existing placeholder code.

The following example C file:

```c
int main() { return 0; }
```

Should be able to be compiled and linked with `zig cc` and `zig ld`:

```sh
zig cc -c test.c -o test.o
zig ld -o test test.o -lc
./test # OK
```
