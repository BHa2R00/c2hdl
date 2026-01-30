SECTIONS
{
  . = 0x000;
  .text : ALIGN(4) {
    *(.text)
    *(.text.*)
  } 
  . = 0x1000;
  .rodata : ALIGN(4) {
    *(.rodata)
    *(.rodata.*)
  } 
  .data : ALIGN(4) {
    *(.data)
  } 
}
