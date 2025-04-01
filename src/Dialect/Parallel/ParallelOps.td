#ifndef DIALECT_PARALLEL_PARALLELOPS_TD_
#define DIALECT_PARALLEL_PARALLELOPS_TD_

include "ParallelDialect.td"
include "ParallelTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//-------------------------------------------------------------------
// Base class for Parallel dialect operations
//-------------------------------------------------------------------
class Parallel_Op<string mnemonic> : Op<Parallel_Dialect, mnemonic>;

//-------------------------------------------------------------------
// Counter operations
//-------------------------------------------------------------------
def Parallel_IncOp : Parallel_Op<"inc"> {
    let summary = "Increment a counter by 1.";
    let arguments = (ins Counter_UI32:$counter);
    let results = (outs Counter_UI32:$result);
    let assemblyFormat = "$counter attr-dict `:` type($counter)";
    let hasFolder = 1;
}

def Parallel_ConstantOp: Op<Parallel_Dialect, "constant", [Pure, ConstantLike]> {
    let summary = "Define a constant counter via an attribute.";
    let arguments = (ins I32Attr:$value);
    let results = (outs Counter_UI32:$result);
    let assemblyFormat = "$value attr-dict `:` type($result)";
    let hasFolder = 1;
}

#endif // DIALECT_PARALLEL_PARALLELOPS_TD_