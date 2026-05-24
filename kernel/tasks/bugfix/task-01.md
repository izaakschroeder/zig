# Accept `-fno-pic` on `linux-gnu` targets

**IMPORTANT**: First, see project details and requirements in `kernel/README.md`.

Update `requiresPIC` to remove the `linking_libc` parameter which will allow `-fno-pic` correctly. Update any code that depends on `requiresPIC` to no longer pass that second parameter.
