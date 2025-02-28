# Inling `add_mlir_dialect(Packet packet)` commands so that
# we can custom name `*.inc` generated files.
set(LLVM_TARGET_DEFINITIONS PacketOps.td)

# operations
mlir_tablegen(PacketOps.h.inc -gen-op-decls)
mlir_tablegen(PacketOps.cpp.inc -gen-op-defs)
# types
mlir_tablegen(PacketTypes.h.inc -gen-typedef-decls -typedefs-dialect=packet)
mlir_tablegen(PacketTypes.cpp.inc -gen-typedef-decls -typedefs-dialect=packet)
# dialect
mlir_tablegen(PacketDialect.h.inc -gen-op-decls -dialect=packet)
mlir_tablegen(PacketDialect.cpp.inc -gen-op-decls -dialect=packet)
# tablegen
add_public_tablegen_target(MLIRPacketOpsIncGen)
add_dependencies(mlir-headers MLIRPacketOpsIncGen)

add_mlir_doc(PacketDialect PacketDialect Packet/ -gen-dialect-doc)

add_mlir_dialect_library(MLIRPacket
    PacketDialect.cpp
    PacketOps.cpp

    ADDITIONAL_HEADER_DIRS
    ${CMAKE_BINARY_DIR}/src

    LINK_LIBS PUBLIC
    )


target_include_directories(MLIRPacket PRIVATE
    ${CMAKE_BINARY_DIR}/src
    ${MLIR_INCLUDE_DIRS}
    /Volumes/workplace/llvm-project/mlir/include
)

add_dependencies(MLIRPacket MLIRPacketOpsIncGen)
add_dependencies(MLIRPacket mlir-headers)