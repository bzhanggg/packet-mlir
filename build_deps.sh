#!/bin/bash
set -e

BUILD_SYSTEM=Ninja
BUILD_TAG=Ninja
LLVM_DIR='/Volumes/workplace/llvm-project/'
BUILD_DIR=$LLVM_DIR/build
INSTALL_DIR=$LLVM_DIR/install

mkdir -p $BUILD_DIR
mkdir -p $INSTALL_DIR

pushd $BUILD_DIR

cmake -G Ninja ../llvm \
  -DCMAKE_CXX_COMPILER="$(xcrun --find clang++)" \
  -DCMAKE_C_COMPILER="$(xcrun --find clang)" \
  -DLLVM_ENABLE_PROJECTS=mlir \
  -DLLVM_TARGETS_TO_BUILD='Native' \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
  -DLLVM_PARALLEL_COMPILE_JOBS=7 \
  -DLLVM_PARALLEL_LINK_JOBS=2 \

cmake --build . --target check-mlir

popd
