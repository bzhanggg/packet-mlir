#ifndef SRC_DIALECT_PARALLEL_PARALLELOPS_H_
#define SRC_DIALECT_PARALLEL_PARALLELOPS_H_

#include "src/Dialect/Parallel/ParallelDialect.h"
#include "src/Dialect/Parallel/ParallelTypes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"

#define GET_OP_CLASSES
#include "src/Dialect/Parallel/ParallelOps.h.inc"

#endif // SRC_DIALECT_PARALLEL_PARALLELOPS_H_