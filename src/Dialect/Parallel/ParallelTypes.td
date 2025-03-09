#ifndef DIALECT_PARALLEL_PARALLELTYPES_TD_
#define DIALECT_PARALLEL_PARALLELTYPES_TD_

include "ParallelDialect.td"

class Parallel_Type<string name, string typeMnemonic> : TypeDef<Parallel_Dialect, name> {
    let mnemonic = typeMnemonic;
}

def Counter : Parallel_Type<"Counter", "counter"> {
    let summary = "A thread-safe counter type"; // TODO: not yet thread-safe
    let description = [{
        A `counter` represents a shared unsigned integer alue that can be
        safely manipulated by multiple threads.
    }];
}

#endif // DIALECT_PARALLEL_PARALLELTYPES_TD_