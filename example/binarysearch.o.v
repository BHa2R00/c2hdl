module binarysearch (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, a30, a40, a50, a00, a20, a10, s00, ra0, sp0);
input clk, rstb;
input setb;
output reg idle;
output reg [6:0] pc;
input [6:0] pc0;
output reg [31:0] addr;
output reg [2:0] size;
output reg valid, write;
output reg [31:0] wdata;
input [31:0] rdata;
input ready;
input [31:0] a30, a40, a50, a00, a20, a10, s00, ra0, sp0;
wire [31:0] rdata_w = rdata;
wire [15:0] rdata_h = rdata;
wire [ 7:0] rdata_b = rdata;
reg [31:0] zero, a3, a4, a5, a0, a2, a1, s0, ra, sp;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    zero <= 32'd0;
    idle <= 1;
    valid <= 0;
    write <= 0;
    size <= 0;
    addr <= 0;
  end
  else begin
    zero <= 32'd0;
    if(!setb) begin
      pc <= (pc0 > 'h50) ? 'h50 + 4 : pc0;
      a3 <= a30;
      a4 <= a40;
      a5 <= a50;
      a0 <= a00;
      a2 <= a20;
      a1 <= a10;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h50) ? 'h50 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/binarysearch.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <binarysearch>:
//#else 
//#include "stdio.h"
//#endif
//
//int binarysearch(int* A, int l, int r, int t)
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//  int L=l, R=r
//  while(L<R) {
//      10 : blt a1 a2 28 <binarysearch+#x28> 
'h00000010 : begin if($signed(a1) < $signed(a2)) pc <= 40; end
//    int m = L+((R-L)>>1)
//    if(A[m]>t) R=m
//    else L=m+1
//  }
//  return R-1
//}
//      14 : addi a0 a2 -1 
'h00000014 : begin a0 <= $signed(a2) + $signed(-1); end
//      18 : lw ra 4 (sp) 
'h00000018 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      1C : lw s0 0 (sp) 
'h0000001C : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      20 : addi sp sp 8 
'h00000020 : begin sp <= $signed(sp) + $signed(8); end
//      24 : ret 
'h00000024 : begin pc <= ra; end
//    int m = L+((R-L)>>1)
//      28 : sub a5 a2 a1 
'h00000028 : begin a5 <= $signed(a2) - $signed(a1); end
//      2C : srai a5 a5 1 
'h0000002C : begin a5 <= $signed(a5) >>> 1; end
//      30 : add a5 a5 a1 
'h00000030 : begin a5 <= $signed(a5) + $signed(a1); end
//    if(A[m]>t) R=m
//      34 : slli a4 a5 2 
'h00000034 : begin a4 <= $unsigned(a5) << 2; end
//      38 : add a4 a0 a4 
'h00000038 : begin a4 <= $signed(a0) + $signed(a4); end
//      3C : lw a4 0 (a4) 
'h0000003C : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      40 : blt a3 a4 4C <binarysearch+#x4c> 
'h00000040 : begin if($signed(a3) < $signed(a4)) pc <= 76; end
//    else L=m+1
//      44 : addi a1 a5 1 
'h00000044 : begin a1 <= $signed(a5) + $signed(1); end
//      48 : j 10 <binarysearch+#x10> 
'h00000048 : begin pc <= 16; end
//    if(A[m]>t) R=m
//      4C : mv a2 a5 
'h0000004C : begin a2 <= a5; end
//      50 : j 10 <binarysearch+#x10> 
'h00000050 : begin pc <= 16; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
