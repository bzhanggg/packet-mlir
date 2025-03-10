#ifndef DIALECT_PARALLEL_PARALLELOPS_TD_
#define DIALECT_PARALLEL_PARALLELOPS_TD_

include "ParallelDialect.td"
include "ParallelTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/BuiltinTypes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//-------------------------------------------------------------------
// Base class for Parallel dialect operations
//-------------------------------------------------------------------
class Parallel_Op<string mnemonic> : Op<Parallel_Dialect, mnemonic>;

//-------------------------------------------------------------------
// Counter operations
//-------------------------------------------------------------------
def Counter_IncOp : Parallel_Op<"counter.inc"> {
    let summary = "Increment a counter";
    let description = [{
        The `parallel.counter.inc` operation increments a counter value by 1.

        Example:
        ```mlir
        %new_counter = parallel.counter.inc %counter : !parallel.counter<i32>
        ```
    }];

    let arguments = (ins AnyInteger:$counter);
    let results = (outs AnyInteger:$results);
    let assemblyFormat = "$counter attr-dict `:` type($counter) `->` type($results)";

    let hasVerifier = 1;
}

#endif // DIALECT_PARALLEL_PARALLELOPS_TD_