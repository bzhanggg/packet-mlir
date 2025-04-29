#ifndef DIALECT_PACKET_PACKETTYPES_TD_
#define DIALECT_PACKET_PACKETTYPES_TD_

include "PacketDialect.td"
include "mlir/IR/BuiltinAttributes.td"

// A base class for all types in this dialect
class Packet_Type<string name, string typeMnemonic> : TypeDef<Packet_Dialect, name> {
    let mnemonic = typeMnemonic;
}

def Packet_HeaderType : Packet_Type<"Header", "packet"> {
    let summary = "A network packet of a given format";
    let parameters = (ins
        Builtin_StringAttr:$format              // "ipv4", "ethernet", ...
    );
    let assemblyFormat = "`<` $format `>`";
}

#endif // DIALECT_PACKET_PACKETTYPES_TD_