add_mlir_library(SBLPTransforms
    Pipeline.cpp
    StrengthReduction.cpp
    GCDTiling.cpp

    LINK_LIBS PUBLIC
      MLIRIR
      MLIRPass
      MLIRAffineDialect
      MLIRArithDialect
      MLIRLinalgDialect
      MLIRBufferizationDialect
      MLIRFuncDialect
)
message(STATUS "lib/Transformers PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
target_include_directories(SBLPTransforms
    PUBLIC
    ${PROJECT_SOURCE_DIR}/include
)
