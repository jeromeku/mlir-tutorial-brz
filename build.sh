#!/bin/bash
set -euo pipefail
LLVM_ROOT=$(dirname `realpath -L .`)
echo $LLVM_ROOT
LLVM_BUILD_DIR=${LLVM_ROOT}/build

CC=/usr/bin/clang-22
CXX=/usr/bin/clang++-22
BUILD_DIR="build"

cmake -S . -B $BUILD_DIR -G "Ninja"               \
    -DLLVM_DIR=${LLVM_BUILD_DIR}/lib/cmake/llvm   \
    -DMLIR_DIR=${LLVM_BUILD_DIR}/lib/cmake/mlir   \
    -DCMAKE_C_COMPILER=$CC                        \
    -DCMAKE_CXX_COMPILER=$CXX                     \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON            \
    --debug-output 2>&1 | tee _cmake.config.log

ninja -C build -d explain -v check-sblp 2>&1 | tee _cmake.build.log