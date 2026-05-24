# Implement `zig nm` functionality

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Implement the actual functionality for `zig nm`. 

The following is a list of parameters:

```
nm  [-A|-o|--print-file-name]
    [-a|--debug-syms]
    [-B|--format=bsd]
    [-C|--demangle[=style]]
    [-D|--dynamic]
    [-fformat|--format=format]
    [-g|--extern-only]
    [-h|--help]
    [--ifunc-chars=CHARS]
    [-j|--format=just-symbols]
    [-l|--line-numbers] [--inlines]
    [-n|-v|--numeric-sort]
    [-P|--portability]
    [-p|--no-sort]
    [-r|--reverse-sort]
    [-S|--print-size]
    [-s|--print-armap]
    [-t radix|--radix=radix]
    [-u|--undefined-only]
    [-U|--defined-only]
    [-V|--version]
    [-W|--no-weak]
    [-X 32_64]
    [--no-demangle]
    [--no-recurse-limit|--recurse-limit]]
    [--plugin name]
    [--size-sort]
    [--special-syms]
    [--synthetic]
    [--target=bfdname]
    [--unicode=method]
    [--with-symbol-versions]
    [--without-symbol-versions]
    [objfile...]
```

`zig nm` lists the symbols from object files `objfile...`.  If no object files are listed as arguments, `zig nm` assumes the file `a.out`.

Search the internet for "nm man page" to see details on how all of the parameters behave and what their expected output is.

A sample implementation is available in C here: https://raw.githubusercontent.com/falcosecurity/elftoolchain/refs/heads/main/nm/nm.c
