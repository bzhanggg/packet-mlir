// RUN: mlir-opt %s -test-lower-to-llvm | \
// RUN: mlir-runner -e main -entry-point-result=i32 > %t |
// RUN: FileCheck %s < %t

llvm.mlir.global internal @counter(0) : i32

// CHECK: 1
func.func @main() -> i32 {
    func.call @increment_counter() : () -> ()
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr     // retrieve the pointer to @counter
    %res = llvm.load %counterPtr : !llvm.ptr -> i32           // load the pointer into a variable and return it
    return %res : i32
}

// CHECK: 42
func.func @main_looped() -> i32 {
    affine.for %i = 0 to 42 {
        func.call @increment_counter() : () -> ()
    }
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
    %res = llvm.load %counterPtr : !llvm.ptr -> i32
    return %res : i32
}

func.func @main_2() -> i32 {
    %const42 = arith.constant 42 : i32
    func.call @set_counter(%const42) : (i32) -> ()          // 42
    
    func.call @increment_counter() : () -> ()               // 43

    %const2 = arith.constant 2 : i32
    func.call @multiply_counter_by(%const2) : (i32) -> ()   // 86

    func.call @add_input_to_counter(%const2) : (i32) -> ()  // 88

    %const88 = func.call @get_counter() : () -> i32
    
    %res = func.call @compare_counter_to(%const88) : (i32) -> i32
    return %res : i32
}

func.func @increment_counter() -> () {
    %counterPtr = llvm.mlir.addressof @counter : !llvm.ptr
    %1 = arith.constant 1 : i32
    %inc = llvm.atomicrmw "add" %counterPtr, %1 seq_cst : !llvm.ptr, i32
    return
}

func.func @set_counter(%val: i32) -> () {
    %state_ptr = llvm.mlir.addressof @counter : !llvm.ptr
    llvm.store %val, %state_ptr : i32, !llvm.ptr
    return
}

func.func @get_counter() -> i32 {
    %state_ptr = llvm.mlir.addressof @counter : !llvm.ptr
    %val = llvm.load %state_ptr : !llvm.ptr -> i32
    return %val : i32
}

func.func @multiply_counter_by(%factor: i32) -> () {
    %state_ptr = llvm.mlir.addressof @counter : !llvm.ptr
    %state = llvm.load %state_ptr : !llvm.ptr -> i32
    %result = arith.muli %state, %factor : i32
    llvm.store %result, %state_ptr : i32, !llvm.ptr
    return
}

func.func @add_input_to_counter(%input: i32) -> () {
    %state_ptr = llvm.mlir.addressof @counter : !llvm.ptr
    %state = llvm.load %state_ptr : !llvm.ptr -> i32
    %sum = arith.addi %state, %input : i32
    llvm.store %sum, %state_ptr : i32, !llvm.ptr
    return
}

func.func @compare_counter_to(%val: i32) -> i32 {
    %state = func.call @get_counter() : () -> i32
    %cmp = arith.cmpi sge, %state, %val : i32
    %res = arith.extui %cmp: i1 to i32
    return %res : i32
}

func.func @reset_counter() -> () {
    %zero = arith.constant 0 : i32
    %state_ptr = llvm.mlir.addressof @counter : !llvm.ptr
    llvm.store %zero, %state_ptr : i32, !llvm.ptr
    return
}
