# Fix `zig cc -S` with `-Wp,-MD,<depfile>`

The following example C program files to produce the correct output when compiled with `zig cc test.c -S -Wp,-MD,add.d -o add.s` – it fails to produce the correct `add.s` file. Additionally if `-Werror` is passed the compilation fails entirely.

```c
int add(int a, int b) {
  return a + b;
}
```

Fixes to `src/Compilation.zig` should be made so that `zig cc` works correctly. The following test cases should be implemented and verified:

- `zig cc test.c -S -Wp,-MD,add.d -o add.s`
- `zig cc test.c -S -Werror -Wp,-MD,add.d -o add.s`

Identify and fix any other code paths that may be affected by this bug.
