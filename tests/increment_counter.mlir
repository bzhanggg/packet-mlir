// RUN: mlir-opt %s -test-lower-to-llvm | \
// RUN: mlir-runner -e main -entry-point-result=i32 > /Volumes/workplace/packet-mlir/tests/output.txt | \
// RUN: FileCheck %s < /Volumes/workplace/packet-mlir/tests/output.txt

llvm.mlir.global internal @counter(0) : i32

// CHECK: 2
func.func @main() -> i32 {
    %res1 = func.call @increment_counter() : () -> i32
    %res2 = func.call @increment_counter() : () -> i32    // this second one isn't incrementing?

    %res3 = math.ctlz %res2 : i32      // this outputs 31, so increment_counter is just setting counter = 1...
    return %res3 : i32
}

func.func @increment_counter() -> i32 {
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
    %1 = arith.constant 1 : i32
    %inc = llvm.atomicrmw "add" %counterPtr, %1 monotonic {alignment=4} : !llvm.ptr, i32
    func.return %1 : i32
}