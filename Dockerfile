# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /cgltf
WORKDIR /cgltf

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN cd fuzz && rm -rf build && mkdir build && cd build/ && CC=clang CXX=clang++ cmake .. && make

# Package Stage
FROM ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /cgltf/fuzz/build/cgltf_parse /
