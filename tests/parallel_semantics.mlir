// RUN: parpack-opt --canonicalize %s | FileCheck %s

// CHECK-LABEL: test_increment_execution
func.func @test_increment_execution() -> !parallel.counter {
    %c42 = "parallel.set"(%counter, 42)
    %c43 = parallel.inc %c42 : !parallel.counter
    // CHECK: parallel.constant 43
    return %c43 : !parallel.counter
}

//for i = 0 to N:
//    increment_counter
//
//-->
//
//for i = 0 to N/k:
//    for j = 0 to k:
//        increment_counter

// ** search up loop tiling/blocking/interchange

// summarize: 
//  -- how to reproduce this project
//  -- technical work
//  -- retrospective/reflection
//  -- transfer ownership to research github