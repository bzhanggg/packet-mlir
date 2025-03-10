#include "src/Dialect/Parallel/ParallelOps.h"
#include "mlir/Support/LLVM.h"
#include "src/Dialect/Parallel/ParallelTypes.h"

namespace mlir {
namespace parpack {
namespace parallel {

llvm::LogicalResult IncOp::verify() {
    Type counterType = getCounter().getType();

    // check that the operand is a `!parallel.counter` type
    if (!isa<CounterType>(counterType))
        return emitOpError() << "expected operand to be of type !parallel.counter";
    // check element type of counter
    auto counter = dyn_cast<CounterType>(counterType);
    Type elementType = counter.getElementType();
    if (!elementType.isSignlessInteger() && !elementType.isUnsignedInteger())
        return emitOpError() << "counter element type must be an integer type";
    
    return llvm::success();
}

} // namespace parallel
} // namespace parpack
} // namespace mlir