#ifndef DIALECT_PACKET_PACKTTYPES_H_
#define DIALECT_PACKET_PACKTTYPES_H_

// Required because the .h.inc file refers to MLIR classes and does not itself
// have any includes.
#include "mlir/IR/DialectImplementation.h"

#define GET_TYPEDEF_CLASSES
#include "src/Dialect/Packet/PacketTypes.h.inc"

#endif  // DIALECT_PACKET_PACKTTYPES_H_