// RUN: parpack-opt %s > %t
// RUN FileCheck %s < %t

module {
    // CHECK-LABEL: test_type_syntax
    func.func @test_type_syntax(%arg0: !parallel.counter) -> !parallel.counter {
        // CHECK: parallel.counter
        return %arg0 : !parallel.counter
    }

    // CHECK-LABEL: test_increment_syntax
    func.func @test_increment_syntax(%arg0: !parallel.counter) -> !parallel.counter {
        // CHECK: parallel.constant
        %0 = parallel.constant 42 : !parallel.counter

        // CHECK: %[[RES:.*]] = parallel.inc %arg0 : !parallel.counter
        %1 = parallel.inc %0 : !parallel.counter

        return %1: !parallel.counter
    }

    // CHECK-LABEL: test_multiple_increments
    func.func @test_multiple_increments(%arg0: !parallel.counter) -> !parallel.counter {
        // CHECK: %[[RES1:.*]] = parallel.counter.inc %arg0 : !parallel.counter
        %0 = parallel.inc %arg0 : !parallel.counter
        // CHECK: %[[RES2:.*]] = parallel.counter.inc %[[RES1]] : !parallel.counter
        %1 = parallel.inc %0 : !parallel.counter
        return %1 : !parallel.counter<ui32>
    }
}