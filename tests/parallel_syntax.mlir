// RUN: parpack-opt %s

module {
    // CHECK-LABEL: test_type_syntax
    func.func @test_type_syntax(%arg0: !parallel.counter<ui32>) -> !parallel.counter<ui32> {
        // CHECK: parallel.counter
        return %arg0 : !parallel.counter<ui32>
    }

    // CHECK-LABEL: test_increment_syntax
    func.func @test_increment_syntax(%arg0: !parallel.counter<ui32>) -> !parallel.counter<ui32> {
        // CHECK: %[[RES:.*]] = parallel.counter.inc %arg0 : !parallel.counter<ui32> -> !parallel.counter<ui32>
        %0 = parallel.counter.inc %arg0 : !parallel.counter<ui32> -> !parallel.counter<ui32>
        return %0: !parallel.counter<ui32>
    }

    // CHECK-LABEL: test_multiple_increments
    func.func @test_multiple_increments(%arg0: !parallel.counter) -> !parallel.counter {
        // CHECK: %[[RES1:.*]] = parallel.counter.inc %arg0 : !parallel.counter
        %0 = parallel.counter.inc %arg0 : !parallel.counter<ui32> -> !parallel.counter<ui32>
        // CHECK: %[[RES2:.*]] = parallel.counter.inc %[[RES1]] : !parallel.counter
        %1 = parallel.counter.inc %0 : !parallel.counter<ui32> -> !parallel.counter<ui32>
        return %1 : !parallel.counter<ui32>
    }
}