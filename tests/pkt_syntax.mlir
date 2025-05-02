// RUN: parpack-opt %s | FileCheck %s

module {
    // CHECK-LABEL: test_type_syntax
    func.func @test_type_syntax(%arg0: !pkt.packet<"ipv4">) -> !pkt.packet<"ipv4"> {
        // CHECK: pkt.packet
        return %arg0: !pkt.packet<"ipv4">
    }

    // CHECK-LABEL: test_parse_op_syntax
    func.func @test_parse_op_syntax(%buf0: memref<i8>) -> !pkt.packet<"ipv4"> {
        // CHECK: !pkt.packet<"ipv4">
        %pkt0 = "pkt.parse"(%buf0) {format="ipv4"} : (memref<i8>) -> !pkt.packet<"ipv4">
        return %pkt0: !pkt.packet<"ipv4">
    }
}