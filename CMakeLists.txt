cmake_minimum_required(VERSION 3.20.0)

project(packet-mlir LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_DEPS ON)

set(CMAKE_PREFIX_PATH
    "${PROJECT_SOURCE_DIR}/external/llvm-project/build/lib/cmake/mlir;${PROJECT_SOURCE_DIR}/external/llvm-project/build/lib/cmake/llvm"
    CACHE STRING
    "Prefix paths for dependencies"
    )

find_package(MLIR REQUIRED CONFIG PATHS "${PROJECT_SOURCE_DIR}/external/llvm-project/build/lib/cmake/mlir")
set(MLIR_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/external/llvm-project/mlir/include")
# find_package(LLVM REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "Using MLIR_INCLUDE_DIRS in: ${MLIR_INCLUDE_DIRS}")

set(MLIR_BINARY_DIR "${CMAKE_BINARY_DIR}")

include(AddLLVM)
include(TableGen)

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddMLIR)
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR}/external/llvm-project/llvm/include)
include_directories(${PROJECT_SOURCE_DIR}/external/llvm-project/mlir/include)

message(STATUS "Using project source in: ${PROJECT_SOURCE_DIR}")
message(STATUS "Using project binaries in: ${PROJECT_BINARY_DIR}")

add_subdirectory(src)
add_subdirectory(tests)