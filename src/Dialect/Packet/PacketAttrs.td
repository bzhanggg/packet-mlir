#ifndef DIALECT_PACKET_PACKETATTRS_TD_
#define DIALECT_PACKET_PACKETATTRS_TD_

include "PacketDialect.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/EnumAttr.td"

// A base class for all attributes in this dialect
// class Pkt_Attr<string name, string attrMnemonic, list<Trait> traits = []>
//     : AttrDef<Packet_Dialect, name> {
//     let mnemonic = attrMnemonic;
// }

def PacketProtocolEnum : I32EnumAttr<"PacketProtocol", "Supported packet protcols", [
    I32EnumAttrCase<"None",     0, "none">,
    I32EnumAttrCase<"Ethernet", 1, "eth">,
    I32EnumAttrCase<"IPv4",     2, "ipv4">,
    I32EnumAttrCase<"IPv6",     3, "ipv6">,
    I32EnumAttrCase<"TCP",      4, "tcp">,
    I32EnumAttrCase<"UDP",      5, "udp">
    ]> {
    let genSpecializedAttr = 0;
    let cppNamespace = "mlir::parpack::pkt";
}

def ProtocolAttr : EnumAttr<Packet_Dialect, PacketProtocolEnum, "proto">;

#endif // DIALECT_PACKET_PACKETATTRS_TD_