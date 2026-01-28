SECTIONS
{
  . = 0x0;
  .text : ALIGN(4) {
    *(.text)
    *(.text.*)
  }
  .rodata : ALIGN(4) {
    *(.rodata)
    *(.rodata.*)
  }
  .data : ALIGN(4) {
    *(.data)
  }
}
