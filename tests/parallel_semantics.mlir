// RUN: parpack-opt --canonicalize %s | FileCheck %s

// CHECK-LABEL: test_increment_execution
func.func @test_increment_execution() -> !parallel.counter {
    %c42 = "parallel.constant"() 42 : !parallel.counter
    %c43 = parallel.inc %c42 : !parallel.counter
    // CHECK: parallel.constant 43
    return %c43 : !parallel.counter
}
