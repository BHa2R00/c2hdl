SECTIONS
{
  . = 0x000;
  .text : { *(.text) *(.text.*) } 
  . = 0x1000;
  .rodata : {  *(.rodata) *(.rodata.*) } 
  .data : { *(.data) } 
}
PROVIDE(stdout = 0x3001);
PROVIDE(stdin  = 0x3004);
