#!/bin/bash

BUILD_DIR=./build

pushd $BUILD_DIR

ninja check-mlir-parpack

popd