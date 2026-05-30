#!/bin/sh

set -euo pipefail

CWD="$(realpath "$(dirname "$0")")"
ROOT=$(realpath "$CWD/..")

DEVKIT=/opt/zig-devkit
ARCH="$(uname -m)"
TARGET="$ARCH-linux-musl"

if [ ! -d "$DEVKIT" ]; then
    curl -fLo- "https://ziglang.org/deps/zig+llvm+lld+clang-$TARGET-0.17.0-dev.203+073889523.tar.xz" \
        | tar --strip-components=1 -xJf- -C "$DEVKIT"
fi

BUILD="$ROOT/build"
BUILD_ZIG="$BUILD/zig/$TARGET"
mkdir -p "$BUILD_ZIG"

cd "$ROOT"
$DEVKIT/bin/zig build \
    -p "$BUILD_ZIG" \
    --search-prefix "$DEVKIT" \
    --zig-lib-dir lib \
    -Dstatic-llvm \
    -Duse-zig-libcxx

$BUILD_ZIG/bin/zig install --tools=all --prefix=/usr

# podman build \
#     --volume "$ROOT/.zig-cache:/tmp/.zig-cache:rw" \
#     -f "$CWD/Containerfile.zig" \
#     -t zig \
#     "$ROOT"
