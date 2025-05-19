// RUN: parpack-opt %s > %t
// RUN: FileCheck %s < %t

module {
    // CHECK-LABEL: test_loop
    func.func @test_loop(%arg0: !parallel.counter) -> !parallel.counter {
        affine.for %i = 0 to 42 {
            parallel.inc %arg0 : !parallel.counter
        }
        return %arg0 : !parallel.counter
    }

    // CHECK-LABEL: test_unlooped
    func.func @test_unlooped(%arg0: !parallel.counter) -> !parallel.counter {
        parallel.inc %arg0 : !parallel.counter
        return %arg0: !parallel.counter
    }
}