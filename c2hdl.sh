#!/bin/bash
ARCH=rv32e
MABI=ilp32e
CC=riscv32-linux-gnu-gcc
OBJDUMP=riscv32-linux-gnu-objdump
C_FILES=()
LD_ARGS=()
U_NAMES=()
OUTPUT_NAME="a.out.v"
show_help() {
  echo "Usage: $0 [options] -c <file.c> -u <symbol>"
  echo ""
  echo "Options:"
  echo "  -h, --help       Show this help message"
  echo "  -arch <arch>     RISC-V architecture (default: rv32e)"
  echo "  -mabi <abi>      RISC-V ABI (default: ilp32e)"
  echo "  -cc <compiler>   Compiler path (default: riscv32-linux-gnu-gcc)"
  echo "  -o <file.o>      Output object file name"
  echo "  -c <file.c>      Source file to compile (can be used multiple times)"
  echo "  -u <symbol>      Keep symbol/entry point (can be used multiple times)"
  echo "  -objdump <cmd>   Path to objdump utility"
  echo ""
  echo "Example:"
  echo "  $0 -c example/fibonacci.c -o example/fibonacci.o -u fibonacci"
  exit 0
}
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      ;;
    -arch)
      ARCH="$2"
      shift 2
      ;;
    -mabi)
      MABI="$2"
      shift 2
      ;;
    -cc)
      CC="$2"
      shift 2
      ;;
    -objdump)
      OBJDUMP="$2"
      shift 2
      ;;
    -c)
      C_FILES+=("$2")
      shift 2
      ;;
    -u)
      # We pass -u to the linker via -Wl
      LD_ARGS+=("-Wl,-u,$2")
      U_NAMES+=("$2")
      shift 2
      ;;
    -o)
      OUTPUT_NAME="$2"
      shift 2
      ;;
    *)
      # Any other flags like -L or -T
      LD_ARGS+=("-Wl,$1")
      shift
      ;;
  esac
done
if [ -n "$OUTPUT_NAME" ]; then
    BASE=$(basename "$OUTPUT_NAME" .o)
else
    BASE=$(basename "${C_FILES[0]}" .c)
fi
#GCOBJ="${BASE}.${ARCH}.gc.o"
GCOBJ=$OUTPUT_NAME
DUMP="${GCOBJ}.s"
echo "Processing list: ${C_FILES[*]} -> $GCOBJ"
$CC \
  -I ./ \
  -march=${ARCH} \
  -mabi=${MABI} \
  -g -Os \
  -ffreestanding \
  -fno-stack-protector \
  -fno-common \
  -nostdlib \
  -static \
  -ffunction-sections \
  -fdata-sections \
  -fno-stack-protector \
  -fno-common \
  -fno-omit-frame-pointer \
  -fno-schedule-insns \
  -fno-schedule-insns2 \
  -fno-rename-registers \
  -fno-unroll-loops \
  -fno-tree-vectorize \
  -Wl,--gc-sections \
  -Wl,--no-relax \
  -T mem.ld \
  "${LD_ARGS[@]}" \
  "${C_FILES[@]}" \
  -o "$GCOBJ" || exit 1
$OBJDUMP -S "$GCOBJ" \
  | sed -E 's/([0-9a-f]+) </ 0x\1 </g' \
  | sed -E 's/jal\s+(0x[0-9a-f]+)/jal\tra,\1/g' \
  | tee "$DUMP"
for name in "${U_NAMES[@]}"; do
    echo "Generating Verilog for entry: $name"
    sbcl --script asm2hdl.lisp -g -s "$DUMP" -t "$ARCH" -o "${GCOBJ}.v" -top "$BASE"
done
