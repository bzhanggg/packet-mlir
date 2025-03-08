#include "src/Packet/PacketDialect.h"

#include "src/Packet/PacketOps.h"
#include "src/Packet/PacketTypes.h"
#include "mlir/IR/Builders.h"
#include "llvm/ADT/TypeSwitch.h"

#include "src/Packet/PacketDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "src/Packet/PacketTypes.cpp.inc"
#define GET_OP_CLASSES
#include "src/Packet/PacketOps.cpp.inc"

namespace mlir{
namespace packet {

void PacketDialect::initialize() {
    addTypes<
#define GET_TYPEDEF_LIST
#include "src/Packet/PacketTypes.cpp.inc"
        >();
    addOperations<
#define GET_OP_LIST
#include "src/Packet/PacketOps.cpp.inc"
        >();
}

} // namespace packet
} // namespace mlir