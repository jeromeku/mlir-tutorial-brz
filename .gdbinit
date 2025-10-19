# -----------------------------
# Basic quality-of-life toggles
# -----------------------------

set pagination off
# Stop GDB from pausing output every screenful. Useful when lots of IR dumps fly by.

set confirm off
# Don't ask "are you sure?" for commands like quit or delete.

set print pretty on
# Pretty-print complex C++ types on multiple lines.

set print elements 0
# Show all elements of containers (0 means "no limit"). Prevents truncation.

set breakpoint pending on
# Allow setting breakpoints on functions that aren't loaded yet (e.g., due to lazy loading).
# Without this, "break Foo::bar" might fail until the binary is actually run.

set disassemble-next-line on
# After stepping, auto-disassemble the next line. Handy in heavily inlined code.

handle SIGPIPE pass nostop noprint
# If the program gets SIGPIPE, let it flow to the program (pass), don't stop the debugger,
# and don't print a message. Helps when tools write to pipes that may close.

# -------------------------------------------
# Tell GDB where your source trees live
# (so backtraces open the right file quickly)
# -------------------------------------------

directory /home/jeromeku/llvm-project/mlir-tutorial-brz
directory /home/jeromeku/llvm-project/llvm
directory /home/jeromeku/llvm-project/mlir
# 'directory' = add source search paths. Order matters; top paths are searched first.

# ----------------------------------------------------------
# LLVM & MLIR Python pretty-printers (make data structures
# readable: StringRef, SmallVector, APInt, mlir::Value, etc.)
# ----------------------------------------------------------

python
import sys
# Prepend the directories that ship the pretty-printer scripts.
sys.path.insert(0, '/home/jeromeku/llvm-project/llvm/utils/gdb-scripts')
sys.path.insert(0, '/home/jeromeku/llvm-project/mlir/utils/gdb-scripts')

try:
    import prettyprinters as llvm_pp
    llvm_pp.register_pretty_printers(gdb)
    # Registers LLVM-specific printers (StringRef, SmallVector, DenseMap, APInt, …)
except Exception as e:
    print("LLVM pretty-printers not loaded:", e)

try:
    import mlir_prettyprinters as mlir_pp
    mlir_pp.register_pretty_printers(gdb)
    # Registers MLIR-specific printers (Operation, Value, Attribute, Type, …)
except Exception as e:
    print("MLIR pretty-printers not loaded:", e)
end
