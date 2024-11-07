FROM debian:bookworm AS builder
RUN apt-get --yes update && apt-get install --yes --no-install-recommends \
  build-essential cmake && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY cmake /source/cmake
COPY src /source/src
COPY schemas /source/schemas
COPY vendor /source/vendor
COPY CMakeLists.txt /source/CMakeLists.txt

# For testing
COPY Makefile /source/Makefile
COPY test/cli /source/test/cli

RUN	cmake -S /source -B ./build \
  -DCMAKE_BUILD_TYPE:STRING=Release \
  -DREGISTRY_INDEX:BOOL=ON \
  -DREGISTRY_SERVER:BOOL=ON \
  -DREGISTRY_DEVELOPMENT:BOOL=OFF \
  -DBUILD_SHARED_LIBS:BOOL=OFF

RUN cmake --build /build --config Release --parallel 2
RUN cmake --install ./build --prefix /usr --verbose \
  --config Release --component sourcemeta_registry

RUN make -C /source test PREFIX=/usr

FROM debian:bookworm-slim
RUN apt-get --yes update && apt-get install --yes --no-install-recommends \
  ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/bin/sourcemeta-registry-index \
  /usr/bin/sourcemeta-registry-index
COPY --from=builder /usr/bin/sourcemeta-registry-server \
  /usr/bin/sourcemeta-registry-server
