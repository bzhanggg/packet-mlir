#ifndef SRC_DIALECT_PACKET_PACKETOPS_H_
#define SRC_DIALECT_PACKET_PACKETOPS_H_

#include "src/Dialect/Packet/PacketDialect.h"
#include "src/Dialect/Packet/PacketTypes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"

#define GET_OP_CLASSES
#include "src/Dialect/Packet/PacketOps.h.inc"

#endif // SRC_DIALECT_PACKET_PACKETOPS_H_