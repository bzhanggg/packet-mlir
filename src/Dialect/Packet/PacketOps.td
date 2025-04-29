#ifndef DIALECT_PACKET_PACKETOPS_TD_
#define DIALECT_PACKET_PACKETOPS_TD_

include "PacketDialect.td"
include "PacketTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/BuiltinTypes.td"
include "mlir/IR/OpBase.td"

class Packet_Op<string mnemonic> : Op<Packet_Dialect, mnemonic>;

def Packet_ParseOp : Packet_Op<"parse"> {
    let summary = "Parse a raw byte buffer into a packet header.";
    let description = [{
        Parses an unranked memref of i8 (raw bytes) and returns a
        Packet_HeaderType whose format parameter comes from the op's
        `format` string attribute.
    }];
    let arguments = (ins
        Builtin_MemRef:$buf,                             // type: raw bytes
        Builtin_StringAttr:$format                       // attribute: "ipv4", "ethernet", etc.
    );
    let results = (outs Packet_HeaderType:$packet);         // parsed packet

    let assemblyFormat = " $buf attr-dict `:` `(` type($buf) `)` `->` type($packet) ";
}

#endif // DIALECT_PACKET_PACKETOPS_TD_