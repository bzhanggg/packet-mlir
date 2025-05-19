// RUN: parpack-opt %s > %t
// RUN FileCheck %s < %t

// CHECK-LABEL: test_increment_execution
func.func @test_increment_execution(%ctr: !parallel.counter) -> i32 {
    %c42 = arith.constant 42 : i32

    parallel.set %ctr, %c42 : (!parallel.counter, i32)
    parallel.inc %ctr : !parallel.counter

    %c43 = parallel.get %ctr : !parallel.counter -> i32
    // CHECK: parallel.constant 43
    return %c43 : i32
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