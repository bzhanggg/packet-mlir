// RUN: parpack-opt %s > %t
// RUN: FileCheck %s < %t

module {
    // CHECK-LABEL: test_type_syntax
    func.func @test_type_syntax(%arg0: !pkt.packet<"ipv4">) -> !pkt.packet<"ipv4"> {
        // CHECK: pkt.packet
        return %arg0: !pkt.packet<"ipv4">
    }
}