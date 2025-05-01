#ifndef DIALECT_PACKET_PACKETTYPES_TD_
#define DIALECT_PACKET_PACKETTYPES_TD_

include "PacketDialect.td"
include "PacketAttrs.td"
include "mlir/IR/BuiltinAttributes.td"

// A base class for all types in this dialect
class Pkt_Type<string name, string typeMnemonic> : TypeDef<Packet_Dialect, name> {
    let mnemonic = typeMnemonic;
}

def Packet_Type : Pkt_Type<"Packet", "packet"> {
    let summary = "A network packet of a given format";
    let parameters = (ins
        ProtocolAttr:$proto              // "ipv4", "ethernet", ...
    );
    let assemblyFormat = "`<` $proto `>`";
}

#endif // DIALECT_PACKET_PACKETTYPES_TD_