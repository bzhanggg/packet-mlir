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
class Parallel_Op<string mnemonic, list<Trait> traits = []> :
    Op<Parallel_Dialect, mnemonic, traits>;

//-------------------------------------------------------------------
// Counter operations
//-------------------------------------------------------------------
def CounterIncOp : Parallel_Op<"counter.inc", [MemoryEffects<[MemWrite]>]> {
    let summary = "Increment a counter";
    let description = [{
        The `parallel.counter.inc` operation increments a counter value by 1.

        Example:
        ```mlir
        %new_counter = parallel.counter.inc %counter : !parallel.counter
        ```
    }];
    let arguments = (ins Counter:$counter);
    let results = (outs Counter:$result);

    let assemblyFormat = "$counter attr-dict `:` type($counter)";
}

#endif // DIALECT_PARALLEL_PARALLELOPS_TD_