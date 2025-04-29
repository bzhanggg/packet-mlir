#include "src/Dialect/Packet/PacketDialect.h"

#include "src/Dialect/Packet/PacketOps.h"
#include "src/Dialect/Packet/PacketTypes.h"
#include "mlir/IR/Builders.h"
#include "llvm/ADT/TypeSwitch.h"

#include "src/Dialect/Packet/PacketDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "src/Dialect/Packet/PacketTypes.cpp.inc"
#define GET_OP_CLASSES
#include "src/Dialect/Packet/PacketOps.cpp.inc"

namespace mlir {
namespace parpack {
namespace pkt {

void PacketDialect::initialize() {
    addTypes<
#define GET_TYPEDEF_LIST
#include "src/Dialect/Packet/PacketTypes.cpp.inc"
        >();
    addOperations<
#define GET_OP_LIST
#include "src/Dialect/Packet/PacketOps.cpp.inc"
        >();
}

} // namespace pkt
} // namespace parpack
} // namespace mlir