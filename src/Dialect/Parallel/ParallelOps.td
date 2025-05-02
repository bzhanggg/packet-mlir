#ifndef DIALECT_PARALLEL_PARALLELOPS_TD_
#define DIALECT_PARALLEL_PARALLELOPS_TD_

include "ParallelDialect.td"
include "ParallelTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/IR/BuiltinTypes.td"

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
    let assemblyFormat = "$counter attr-dict `:` type($counter)";
}

def Parallel_SetOp : Parallel_Op<"set"> {
    let summary = "Set a counter to a value.";
    let arguments = (ins Counter_UI32:$counter, "unsigned int":$value);
    let assemblyFormat = "$counter `,` $value attr-dict `:` `(` type($counter) `,` type($value) `)`";
}

def Parallel_GetOp : Parallel_Op<"get"> {
    let summary = "Retrieve value of a counter.";
    let arguments = (ins Counter_UI32:$counter);
    let results = (outs "unsigned int":$value);
    let assemblyFormat = "$counter attr-dict `:` type($counter) `->` type($value)";
}

#endif // DIALECT_PARALLEL_PARALLELOPS_TD_