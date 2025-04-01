
module {
    
    func.func @test_loop(%arg0: !parallel.counter) -> !parallel.counter {
        %result = affine.for %i = 0 to 42 iter_args(%arg1 = %arg0) -> (!parallel.counter) {
            %next = parallel.inc %arg1 : !parallel.counter
            affine.yield %next : !parallel.counter
        }
        return %result : !parallel.counter
    }

    func.func @test_unlooped(%arg0: !parallel.counter) -> !parallel.counter {
        %0 = parallel.inc %arg0 : !parallel.counter
        return %0: !parallel.counter
    }
}