configure_lit_site_cfg(
    ${CMAKE_CURRENT_SOURCE_DIR}/lit.cmake.site.cfg.py.in
    ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
    MAIN_CONFIG
    ${CMAKE_CURRENT_SOURCE_DIR}/lit.cmake.cfg.py
)

set (MLIR_PARPACK_TEST_DEPENDS
    FileCheck count not
    mlir-opt
    mlir-runner
    # parpack-opt
)

add_lit_testsuite(check-mlir-parpack "Running the Parpack regression tests"
    ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${MLIR_PARPACK_TEST_DEPENDS}
)