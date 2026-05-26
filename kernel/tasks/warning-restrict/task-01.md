# Support `-Wrestrict`

Allow passing `-Wrestrict` to `zig cc` and `zig c++` which is then forwarded correctly to LLVM.

The GCC documentation specifies: "Warn when an object referenced by a restrict-qualified parameter (or, in C++, a __restrict-qualified parameter) is aliased by another argument, or when copies between such objects overlap. For example, the call to the strcpy function below attempts to truncate the string by replacing its initial characters with the last four. However, because the call writes the terminating NUL into `a`, the copies overlap and the call is diagnosed."

With the example:

```c
void foo (void)
{
  char a[] = "abcd1234";
  strcpy (a, a + 4);
  // ...
}
```

Write tests that verify this behavior.
