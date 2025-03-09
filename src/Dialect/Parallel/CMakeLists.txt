set(LLVM_TARGET_DEFINITIONS ParallelOps.td)

# operations
mlir_tablegen(ParallelOps.h.inc -gen-op-decls)
mlir_tablegen(ParallelOps.cpp.inc -gen-op-defs)
# types
mlir_tablegen(ParallelTypes.h.inc -gen-typedef-decls -typedefs-dialect=Parallel)
mlir_tablegen(ParallelTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=Parallel)
# dialect
mlir_tablegen(ParallelDialect.h.inc -gen-dialect-decls -dialect=Parallel)
mlir_tablegen(ParallelDialect.cpp.inc -gen-dialect-defs -dialect=Parallel)
# tablegen
add_public_tablegen_target(MLIRParallelOpsIncGen)
add_dependencies(mlir-headers MLIRParallelOpsIncGen)

add_mlir_doc(ParallelDialect ParallelDialect Parallel/ -gen-dialect-doc)

add_mlir_dialect_library(MLIRParallel
    ParallelDialect.cpp
    ParallelOps.cpp
    DEPENDS
        MLIRParallelOpsIncGen
    LINK_LIBS PUBLIC
        MLIRIR
        MLIRSupport
)

add_dependencies(MLIRParallel MLIRParallelOpsIncGen mlir-headers)