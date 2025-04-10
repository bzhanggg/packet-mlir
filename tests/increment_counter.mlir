// RUN: mlir-opt %s -test-lower-to-llvm | \
// RUN: mlir-runner -e main_looped -entry-point-result=i32 > /Volumes/workplace/packet-mlir/tests/output.txt | \
// RUN: FileCheck %s < /Volumes/workplace/packet-mlir/tests/output.txt

llvm.mlir.global internal @counter(0) : i32

// CHECK: 2
func.func @main() -> i32 {
    %res1 = func.call @increment_counter() : () -> i32
    %res2 = func.call @increment_counter() : () -> i32

    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr     // retrieve the pointer to @counter
    %res3 = llvm.load %counterPtr : !llvm.ptr -> i32           // load the pointer into a variable and return it
    return %res3 : i32
}

// CHECK: 42
func.func @main_looped() -> i32 {
    affine.for %i = 0 to 42 {
        %call = func.call @increment_counter() : () -> i32
    }
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
    %res = llvm.load %counterPtr : !llvm.ptr -> i32
    return %res : i32
}

func.func @increment_counter() -> i32 {
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
    %1 = arith.constant 1 : i32
    %inc = llvm.atomicrmw "add" %counterPtr, %1 seq_cst : !llvm.ptr, i32
    func.return %inc : i32
}
