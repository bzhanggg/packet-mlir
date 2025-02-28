#ifndef DIALECT_PACKET_PACKETTYPES_TD_
#define DIALECT_PACKET_PACKETTYPES_TD_

include "PacketDialect.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
class Packet_Type<string name, string typeMnemonic> : TypeDef<Packet_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def Packet : Packet_Type<"Header", "packet"> {
  let summary = "The packet header";

  let description = [{
    A type for the packet header metadata
  }];

  let parameters = (ins "int":$degreeBound);
  let assemblyFormat = "`<`$degreeBound`>`";
}

#endif // DIALECT_PACKET_PACKETTYPES_TD_