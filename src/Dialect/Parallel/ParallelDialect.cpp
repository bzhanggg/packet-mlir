#include "src/Dialect/Parallel/ParallelDialect.h"

#include "src/Dialect/Parallel/ParallelOps.h"
#include "src/Dialect/Parallel/ParallelTypes.h"

namespace mlir {
namespace parpack {
namespace parallel {

void ParallelDialect::initialize() {
    addTypes<
#define GET_TYPEDEF_LIST
#include "src/Dialect/Parallel/ParallelTypes.cpp.inc"
    >();
}

} // namespace parallel
} // namespace parpack
} // namespace mlir