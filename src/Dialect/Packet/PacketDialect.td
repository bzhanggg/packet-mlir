#ifndef DIALECT_PACKET_PACKETDIALECT_TD_
#define DIALECT_PACKET_PACKETDIALECT_TD_

include "mlir/IR/OpBase.td"
include "mlir/IR/DialectBase.td"

def Packet_Dialect : Dialect {
    let name = "packet";
    let summary = "A dialect for packet processing operations";
    let description = [{
        The Packet dialect defines types and operations for simple packet
        operations to a packet table.
    }];

    let cppNamespace = "::mlir::parpack::packet";

    let useDefaultTypePrinterParser = 1;
    let hasConstantMaterializer = 1;
}

#endif // DIALECT_PACKET_PACKETDIALECT_TD_