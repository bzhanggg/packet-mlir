// RUN: parpack-opt %s

module {
    func.func @main(%arg0: !parallel.counter) -> !parallel.counter {
        return %arg0 : !parallel.counter
    }
}