#ifndef DIALECT_PARALLEL_PARALLELTYPES_TD_
#define DIALECT_PARALLEL_PARALLELTYPES_TD_

include "ParallelDialect.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/BuiltinTypes.td"

class Parallel_Type<string name, string typeMnemonic> : TypeDef<Parallel_Dialect, name> {
    let mnemonic = typeMnemonic;
}

def Counter : Parallel_Type<"Counter", "counter"> {
    let summary = "A thread-safe counter type"; // TODO: not yet thread-safe
    let description = [{
        A `counter` represents a shared integer value that can be
        safely manipulated by multiple threads. The counter is parameterized
        by an integer element type that specifies the width and signedness 
        of the underlying value.

        Examples:
        ```mlir
        !parallel.counter<i32>    // 32-bit counter
        !parallel.counter<ui64>   // 64-bit unsigned counter
        ```
    }];

    let parameters = (ins AnyInteger:$elementType);
    let assemblyFormat = "`<` $elementType `>`";

    let genVerifyDecl = 1;
}

#endif // DIALECT_PARALLEL_PARALLELTYPES_TD_