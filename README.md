# c2hdl
convert c to hdl

<pre>
Usage: ./c2hdl.sh [options] -c <file.c> -u <symbol>

Options:
  -h, --help       Show this help message
  -arch <arch>     RISC-V architecture (default: rv32e)
  -mabi <abi>      RISC-V ABI (default: ilp32e)
  -cc <compiler>   Compiler path (default: riscv32-linux-gnu-gcc)
  -o <file.o>      Output object file name
  -c <file.c>      Source file to compile (can be used multiple times)
  -u <symbol>      Keep symbol/entry point (can be used multiple times)
  -objdump <cmd>   Path to objdump utility

Example:
  ./c2hdl.sh -c tea.c -o tea.o -u tinyenc -u tinydec
</pre>
