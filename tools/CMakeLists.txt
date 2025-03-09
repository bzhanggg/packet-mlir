get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

set(LIBS
    ${dialect_libs}
    ${conversion_libs}
    MLIROptLib
    MLIRPass
    MLIRPacket
    MLIRParallel
)

add_llvm_executable(parpack-opt parpack-opt.cpp)

llvm_update_compile_flags(parpack-opt)
target_link_libraries(parpack-opt PRIVATE ${LIBS})

mlir_check_all_link_libraries(parpack-opt)