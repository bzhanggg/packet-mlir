#ifndef DIALECT_PACKET_PACKETTYPES_TD_
#define DIALECT_PACKET_PACKETTYPES_TD_

include "PacketDialect.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
class Packet_Type<string name, string typeMnemonic> : TypeDef<Packet_Dialect, name> {
  let mnemonic = typeMnemonic;
}

#endif // DIALECT_PACKET_PACKETTYPES_TD_