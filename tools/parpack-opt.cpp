#include "mlir/IR/MLIRContext.h"
#include "src/Dialect/Packet/PacketDialect.h"
#include "src/Dialect/Parallel/ParallelDialect.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"

int main(int argc, char **argv) {
    mlir::DialectRegistry registry;
    // registry.insert<mlir::parpack::packet::PacketDialect>();
    registry.insert<mlir::parpack::parallel::ParallelDialect>();
    mlir::registerAllDialects(registry);
    // mlir::registerAllPasses();

    mlir::MLIRContext context;
    context.appendDialectRegistry(registry);
    context.loadDialect<mlir::parpack::parallel::ParallelDialect>();

    return mlir::asMainReturnCode(
        mlir::MlirOptMain(argc, argv, "Parpack Pass Driver", registry)
    );
}