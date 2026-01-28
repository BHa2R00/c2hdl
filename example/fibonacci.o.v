module fibonacci (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a40, a50, a00, s00, ra0, sp0);
input clk, rstb;
input setb;
output reg idle;
output reg [7:0] pc;
input [7:0] pc0;
output reg [31:0] addr;
output reg [2:0] size;
output reg valid, write;
output reg [31:0] wdata;
input [31:0] rdata;
input ready;
input [31:0] s10, a40, a50, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
reg [31:0] zero, s1, a4, a5, a0, s0, ra, sp;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    zero <= 32'd0;
    idle <= 1;
    valid <= 0;
    write <= 0;
    size <= 0;
  end
  else begin
    zero <= 32'd0;
    valid <= 0;
    write <= 0;
    size <= 0;
    if(!setb) begin
      pc <= (pc0 > 'h88) ? 'h88 + 4 : pc0;
      s1 <= s10;
      a4 <= a40;
      a5 <= a50;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h88) ? 'h88 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/fibonacci.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <fibonacci_step>:
//#endif
//
//typedef struct { volatile int a,b,c, k
//
//void fibonacci_step (counter_t* t) 
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//  t->c = t->a + t->b
//      10 : lw a5 0 (a0) 
'h00000010 : begin if(!valid && !ready) begin addr <= 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      14 : lw a4 4 (a0) 
'h00000014 : begin if(!valid && !ready) begin addr <= 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      18 : add a5 a5 a4 
'h00000018 : begin a5 <= $signed(a5) + $signed(a4); end
//      1C : sw a5 8 (a0) 
'h0000001C : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  t->a = t->b
//      20 : lw a5 4 (a0) 
'h00000020 : begin if(!valid && !ready) begin addr <= 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      24 : sw a5 0 (a0) 
'h00000024 : begin if(!valid && !ready) begin addr <= 0 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  t->b = t->c
//      28 : lw a5 8 (a0) 
'h00000028 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      2C : sw a5 4 (a0) 
'h0000002C : begin if(!valid && !ready) begin addr <= 4 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  #ifdef SIM
//  printf("a=%d, b=%d, c=%d, k=%d\n", t->a, t->b, t->c, t->k)
//  #endif
//}
//      30 : lw ra 4 (sp) 
'h00000030 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      34 : lw s0 0 (sp) 
'h00000034 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//      38 : addi sp sp 8 
'h00000038 : begin sp <= $signed(sp) + $signed(8); end
//      3C : ret 
'h0000003C : begin pc <= ra; end
//
// 0x00000040 <fibonacci>:
//
//void fibonacci (counter_t* t)
//{
//      40 : addi sp sp -12 
'h00000040 : begin sp <= $signed(sp) + $signed(-12); end
//      44 : sw ra 8 (sp) 
'h00000044 : begin if(!valid && !ready) begin addr <= 8 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      48 : sw s0 4 (sp) 
'h00000048 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      4C : sw s1 0 (sp) 
'h0000004C : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      50 : addi s0 sp C 
'h00000050 : begin s0 <= $signed(sp) + $signed(12); end
//      54 : mv s1 a0 
'h00000054 : begin s1 <= a0; end
//  while(--t->k >= 0) fibonacci_step(t)
//      58 : lw a5 C (s1) 
'h00000058 : begin if(!valid && !ready) begin addr <= 12 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      5C : addi a5 a5 -1 
'h0000005C : begin a5 <= $signed(a5) + $signed(-1); end
//      60 : sw a5 C (s1) 
'h00000060 : begin if(!valid && !ready) begin addr <= 12 + s1; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      64 : bgez a5 7C <fibonacci+#x3c> 
'h00000064 : begin if($signed(a5) >= 0) pc <= 124; end
//}
//      68 : lw ra 8 (sp) 
'h00000068 : begin if(!valid && !ready) begin addr <= 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      6C : lw s0 4 (sp) 
'h0000006C : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//      70 : lw s1 0 (sp) 
'h00000070 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s1 <= rdata_w; end
//      74 : addi sp sp C 
'h00000074 : begin sp <= $signed(sp) + $signed(12); end
//      78 : ret 
'h00000078 : begin pc <= ra; end
//  while(--t->k >= 0) fibonacci_step(t)
//      7C : mv a0 s1 
'h0000007C : begin a0 <= s1; end
//      80 : auipc ra 0 
'h00000080 : begin ra <= pc + (0 << 12); end
//      84 : jalr -128 (ra) # 0 <fibonacci_step> 
'h00000084 : begin pc <= $signed(-128) + $signed(ra); ra <= pc + 4; end
//      88 : j 58 <fibonacci+#x18> 
'h00000088 : begin pc <= 88; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
