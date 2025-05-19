// RUN: parpack-opt %s -affine-loop-tile="tile-size=512" \
//         -affine-simplify-structures \
//         -canonicalize \
// RUN: | FileCheck %s
// CHECK-LABEL: func.func @test_affine_tile
// CHECK: affine.for %[[OUTER:.*]] = 0 to 1024 step 512
// CHECK-NEXT: affine.for %[[INNER:.*]] = #map(%[[OUTER]]) to #map1(%[[OUTER]])

func.func @test_affine_tile(%ctr: !parallel.counter) {
    affine.for %i = 0 to 1024 {
        parallel.inc %ctr : !parallel.counter
        affine.yield
    }
    func.return
}
