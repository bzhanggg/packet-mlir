#ifndef DIALECT_PARALLEL_PARALLELDIALECT_TD_
#define DIALECT_PARALLEL_PARALLELDIALECT_TD_

include "mlir/IR/OpBase.td"
include "mlir/IR/DialectBase.td"

def Parallel_Dialect : Dialect {
    let name = "parallel";
    let summary = "A dialect for parallel and thread-safe data structures";
    let description = [{
        The Parallel dialect defines operations and types for working with
        thread-safe data structures and parallel computation primitives.
    }];

    let cppNamespace = "::mlir::parpack::parallel";

    let useDefaultTypePrinterParser = 1;
    let hasConstantMaterializer = 1;
}

#endif // DIALECT_PARALLEL_PARALLELDIALECT_TD_