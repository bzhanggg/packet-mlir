#!/bin/bash

BUILD_DIR=./build

cmake --build $BUILD_DIR --target check-mlir-parpack

popd