#include "src/Dialect/Parallel/ParallelTypes.h"
#include "llvm/Support/LogicalResult.h"

namespace mlir {
namespace parpack {
namespace parallel {

llvm::LogicalResult CounterType::verify(
    ::llvm::function_ref< ::mlir::InFlightDiagnostic ()> emitError,
    ::mlir::IntegerType elementType) {
    if (!elementType)
        return emitError() << "Counter element type must be an integer type";
    return llvm::success();
}

}
}
}
