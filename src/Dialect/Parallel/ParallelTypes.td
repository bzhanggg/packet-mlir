#ifndef DIALECT_PARALLEL_PARALLELTYPES_TD_
#define DIALECT_PARALLEL_PARALLELTYPES_TD_

include "ParallelDialect.td"
include "mlir/IR/AttrTypeBase.td"

class Parallel_Type<string name, string typeMnemonic> : TypeDef<Parallel_Dialect, name> {
    let mnemonic = typeMnemonic;
}

def Counter_UI32 : Parallel_Type<"CounterUI32", "counter"> {
    let summary = "A thread-safe 32-bit integer counter type"; // TODO: not yet thread-safe
    let description = [{
        A `counter` represents a shared 32-bit unsigned integer value that can be
        safely manipulated by multiple threads.
    }];
}

#endif // DIALECT_PARALLEL_PARALLELTYPES_TD_