// RUN: mlir-opt %s -test-lower-to-llvm | \
// RUN: mlir-runner -e entry  | \
// RUN: FileCheck %s
// CHECK: 1

module {
    llvm.mlir.global internal @counter(0) : i32

    func.func @increment_counter() -> i32 {
        %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
        %1 = arith.constant 1 : i32
        %old = llvm.atomicrmw "add" %counterPtr, %1 monotonic {alignment=4} : !llvm.ptr, i32
        return %old : i32
    }

    %2 = func.call @increment_counter() : () -> i32
}