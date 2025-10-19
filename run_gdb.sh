# Project-local init:
TEST_IR=/home/jeromeku/llvm-project/mlir-tutorial-brz/test/Transforms/strength-reduction.mlir
gdb -x .gdbinit --args ./build/bin/sblp-opt \
  --mlir-disable-threading \
  --pass-pipeline='builtin.module(strength-reduction)' \
  ${TEST_IR} -o /dev/null

# break sblp::StrengthReductionPass::runOnOperation
# break sblp::SimplifyPowerOp::matchAndRewrite
# run

# # Home init (~/.gdbinit) loads automatically:
# gdb --args ./bin/sblp-opt --mlir-disable-threading --pass-pipeline='builtin.module(strength-reduction)' input.mlir -o /dev/null
