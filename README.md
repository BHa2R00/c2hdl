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
### binarysearch
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260205111902_639x471_scrot.png)
### helloworld
![format](https://github.com/BHa2R00/c2hdl/raw/main/example/202602081707.gif)
### levenshtein
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260205105458_575x159_scrot.png)
### insertsort
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260205092200_977x160_scrot.png)
### quicksort
![format](https://github.com/BHa2R00/c2hdl/raw/main/example/202602100041.gif)
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260205011808_980x275_scrot.png)
### tea
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260204204710_982x144_scrot.png)
### fibonacci
![format](https://github.com/BHa2R00/c2hdl/blob/main/example/20260204181818_980x171_scrot.png)
