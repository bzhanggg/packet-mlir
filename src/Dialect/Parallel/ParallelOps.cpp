#include "src/Dialect/Parallel/ParallelOps.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "llvm/Support/Casting.h"

namespace mlir {
namespace parpack {
namespace parallel {

OpFoldResult ConstantOp::fold(ConstantOp::FoldAdaptor adaptor) {
    return adaptor.getValueAttr();
}

OpFoldResult IncOp::fold(IncOp::FoldAdaptor adaptor) {
    auto constAttr = llvm::dyn_cast_or_null<IntegerAttr>(adaptor.getCounter());
    auto newValue = constAttr.getValue().getSExtValue() + 1;
    return IntegerAttr::get(getType(), newValue);
}

}
}
}