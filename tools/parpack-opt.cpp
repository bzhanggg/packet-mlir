#include "mlir/IR/MLIRContext.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/Passes.h"
#include "src/Dialect/Packet/PacketDialect.h"
#include "src/Dialect/Parallel/ParallelDialect.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"

int main(int argc, char **argv) {
    mlir::DialectRegistry registry;
    registry.insert<mlir::parpack::pkt::PacketDialect>();
    // registry.insert<mlir::parpack::parallel::ParallelDialect>();
    mlir::registerAllDialects(registry);

    // mlir::MLIRContext context(registry);

    // mlir::registerCanonicalizerPass();
    // mlir::registerPassManagerCLOptions();

    return mlir::asMainReturnCode(
        mlir::MlirOptMain(argc, argv, "Parpack Pass Driver", registry)
    );
}