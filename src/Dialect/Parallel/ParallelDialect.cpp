#include "src/Dialect/Parallel/ParallelDialect.h"

#include "mlir/IR/BuiltinAttributes.h"
#include "src/Dialect/Parallel/ParallelOps.h"
#include "src/Dialect/Parallel/ParallelTypes.h"
#include "llvm/ADT/TypeSwitch.h"
#include "llvm/Support/Casting.h"
#include "mlir/IR/Builders.h"

#include "src/Dialect/Parallel/ParallelDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "src/Dialect/Parallel/ParallelTypes.cpp.inc"
#define GET_OP_CLASSES
#include "src/Dialect/Parallel/ParallelOps.cpp.inc"

namespace mlir {
namespace parpack {
namespace parallel {

void ParallelDialect::initialize() {
    addTypes<
#define GET_TYPEDEF_LIST
#include "src/Dialect/Parallel/ParallelTypes.cpp.inc"
    >();
    addOperations<
#define GET_OP_LIST
#include "src/Dialect/Parallel/ParallelOps.cpp.inc"
    >();
}

} // namespace parallel
} // namespace parpack
} // namespace mlir