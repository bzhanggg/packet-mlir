# Inling `add_mlir_dialect(Packet packet)` commands so that
# we can custom name `*.inc` generated files.
set(LLVM_TARGET_DEFINITIONS PacketOps.td)

# operations
mlir_tablegen(PacketOps.h.inc -gen-op-decls)
mlir_tablegen(PacketOps.cpp.inc -gen-op-defs)
# types
mlir_tablegen(PacketTypes.h.inc -gen-typedef-decls -typedefs-dialect=pkt)
mlir_tablegen(PacketTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=pkt)
# enums
mlir_tablegen(PacketEnums.h.inc -gen-enum-decls)
mlir_tablegen(PacketEnums.cpp.inc -gen-enum-defs)
add_public_tablegen_target(MLIRPacketEnumsIncGen)
add_dependencies(mlir-headers MLIRPacketEnumsIncGen)

# attributes
mlir_tablegen(PacketAttrDefs.h.inc -gen-enum-decls -gen-attrdef-decls -attrdefs-dialect=pkt)
mlir_tablegen(PacketAttrDefs.cpp.inc -gen-enum-defs -gen-attrdef-defs -attrdefs-dialect=pkt)
add_public_tablegen_target(MLIRPacketAttrDefsIncGen)
add_dependencies(mlir-headers MLIRPacketAttrDefsIncGen)

# dialect
mlir_tablegen(PacketDialect.h.inc -gen-dialect-decls -dialect=pkt)
mlir_tablegen(PacketDialect.cpp.inc -gen-dialect-defs -dialect=pkt)
# tablegen
add_public_tablegen_target(MLIRPacketOpsIncGen)
add_dependencies(mlir-headers MLIRPacketOpsIncGen)

add_mlir_doc(PacketDialect PacketDialect Packet/ -gen-dialect-doc)

add_mlir_dialect_library(MLIRPacket
    PacketDialect.cpp
    PacketOps.cpp
    DEPENDS
        MLIRPacketOpsIncGen
        MLIRPacketAttrDefsIncGen
        MLIRPacketEnumsIncGen
    LINK_LIBS PUBLIC
        MLIRIR
        MLIRSupport
)

add_dependencies(MLIRPacket
    MLIRPacketOpsIncGen
    MLIRPacketAttrDefsIncGen
    MLIRPacketEnumsIncGen
    mlir-headers)
