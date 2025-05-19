// RUN: parpack-opt %s > %t
// RUN FileCheck %s < %t

module {
    // CHECK-LABEL: test_type_syntax
    func.func @test_type_syntax(%arg0: !parallel.counter) -> !parallel.counter {
        // CHECK: parallel.counter
        return %arg0 : !parallel.counter
    }

    // CHECK-LABEL: test_increment_syntax
    func.func @test_increment_syntax(%arg0: !parallel.counter) -> i32 {
        %c42 = arith.constant 42 : i32

        parallel.set %arg0, %c42 : (!parallel.counter, i32)
        parallel.inc %arg0 : !parallel.counter
        
        %c43 = parallel.get %arg0 : !parallel.counter -> i32

        return %c43: i32
    }
}