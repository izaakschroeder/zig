#!/bin/sh

set -euo pipefail

CWD="$(realpath "$(dirname "$0")")"
ROOT=$(realpath "$CWD/../..")

mkdir -p "$ROOT/zig-out/zig"

podman build \
    --volume "$ROOT/.zig-cache:/tmp/.zig-cache:rw" \
    -f "$CWD/Containerfile.kernel" \
    -t kernel \
    "$ROOT"
