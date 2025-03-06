# Inling `add_mlir_dialect(Packet packet)` commands so that
# we can custom name `*.inc` generated files.
set(LLVM_TARGET_DEFINITIONS PacketOps.td)

# operations
mlir_tablegen(PacketOps.h.inc -gen-op-decls)
mlir_tablegen(PacketOps.cpp.inc -gen-op-defs)
# types
mlir_tablegen(PacketTypes.h.inc -gen-typedef-decls -typedefs-dialect=packet)
mlir_tablegen(PacketTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=packet)
# dialect
mlir_tablegen(PacketDialect.h.inc -gen-dialect-decls -dialect=packet)
mlir_tablegen(PacketDialect.cpp.inc -gen-dialect-defs -dialect=packet)
# tablegen
add_public_tablegen_target(MLIRPacketOpsIncGen)
add_dependencies(mlir-headers MLIRPacketOpsIncGen)

add_mlir_doc(PacketDialect PacketDialect Packet/ -gen-dialect-doc)

add_mlir_dialect_library(MLIRPacket
    PacketDialect.cpp
    PacketOps.cpp
    DEPENDS
        MLIRPacketOpsIncGen
    LINK_LIBS PUBLIC
        MLIRIR
        MLIRSupport
)

target_include_directories(MLIRPacket PUBLIC
    ${CMAKE_BINARY_DIR}/src
    ${MLIR_INCLUDE_DIRS}
)

add_dependencies(MLIRPacket MLIRPacketOpsIncGen mlir-headers)
