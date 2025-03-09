#include "src/Packet/PacketDialect.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"

int main(int argc, char **argv) {
    mlir::DialectRegistry registry;
    registry.insert<mlir::parpack::packet::PacketDialect>();
    mlir::registerAllDialects(registry);
    mlir::registerAllPasses();

    return mlir::asMainReturnCode(
        mlir::MlirOptMain(argc, argv, "Pass Driver", registry)
    );
}