FROM alpine:latest as build

RUN apk add curl tar xz

ENV TARGET=aarch64-linux-musl

RUN mkdir -p /opt/devkit
RUN curl -fLo- "https://ziglang.org/deps/zig+llvm+lld+clang-$TARGET-0.17.0-dev.203+073889523.tar.xz" \
    | tar --strip-components=1 -xJf- -C /opt/devkit

RUN mkdir -p /dist/opt/zig
RUN mkdir -p /tmp/.zig-cache
RUN mkdir -p /src/zig

ENV ZIG_GLOBAL_CACHE_DIR=/tmp/.zig-cache
ENV ZIG_LOCAL_CACHE_DIR=/tmp/.zig-cache

WORKDIR /src/zig
RUN --mount=type=bind,source=./,destination=/src/zig \
    /opt/devkit/bin/zig build \
    -p /dist/opt/zig \
    --search-prefix /opt/devkit \
    --zig-lib-dir lib \
    -Dstatic-llvm \
    -Duse-zig-libcxx

FROM alpine:latest
COPY --from=build /dist /
RUN ln -s /opt/zig/bin/zig /usr/bin/zig
RUN mkdir -p /src
WORKDIR /src

CMD ["/usr/bin/zig"]
