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
  ./c2hdl.sh -c example/fibonacci.c -o example/fibonacci.o -u fibonacci
</pre>

## example
### levenshtein
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260130132557_998x453_scrot.png)
### insertsort
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260128234450_973x197_scrot.png)
### quicksort
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260128214318_975x276_scrot.png)
### tea
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260128214804_1007x270_scrot.png)
### fibonacci
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260128214832_982x165_scrot.png)
