module quicksort (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a20, a30, a50, a40, a00, s00, ra0, sp0);
input clk, rstb;
input setb;
output reg idle;
output reg [9:0] pc;
input [9:0] pc0;
output reg [31:0] addr;
output reg [2:0] size;
output reg valid, write;
output reg [31:0] wdata;
input [31:0] rdata;
input ready;
input [31:0] s10, a20, a30, a50, a40, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
reg [31:0] zero, s1, a2, a3, a5, a4, a0, s0, ra, sp;
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
      pc <= (pc0 > 'h390) ? 'h390 + 4 : pc0;
      s1 <= s10;
      a2 <= a20;
      a3 <= a30;
      a5 <= a50;
      a4 <= a40;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h390) ? 'h390 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/quicksort.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <push_a>:
//  volatile int   pr_top
//  volatile int   p, r, q
//} filo_t
//
//void push_a(filo_t* f)
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//  f->A[f->a_top] = f->a
//      10 : lw a4 8 (a0) 
'h00000010 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      14 : slli a4 a4 2 
'h00000014 : begin a4 <= $unsigned(a4) << 2; end
//      18 : lw a5 0 (a0) 
'h00000018 : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      1C : add a5 a5 a4 
'h0000001C : begin a5 <= $signed(a5) + $signed(a4); end
//      20 : lw a4 4 (a0) 
'h00000020 : begin if(!valid) begin addr = 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      24 : sw a4 0 (a5) 
'h00000024 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->a_top++
//      28 : lw a5 8 (a0) 
'h00000028 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      2C : addi a5 a5 1 
'h0000002C : begin a5 <= $signed(a5) + $signed(1); end
//      30 : sw a5 8 (a0) 
'h00000030 : begin if(!valid) begin addr = $signed(8) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//      34 : lw ra 4 (sp) 
'h00000034 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      38 : lw s0 0 (sp) 
'h00000038 : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      3C : addi sp sp 8 
'h0000003C : begin sp <= $signed(sp) + $signed(8); end
//      40 : ret 
'h00000040 : begin pc <= ra; end
//
// 0x00000044 <pop_a>:
//
//void pop_a(filo_t* f)
//{
//      44 : addi sp sp -8 
'h00000044 : begin sp <= $signed(sp) + $signed(-8); end
//      48 : sw ra 4 (sp) 
'h00000048 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      4C : sw s0 0 (sp) 
'h0000004C : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      50 : addi s0 sp 8 
'h00000050 : begin s0 <= $signed(sp) + $signed(8); end
//  f->a_top--
//      54 : lw a5 8 (a0) 
'h00000054 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      58 : addi a5 a5 -1 
'h00000058 : begin a5 <= $signed(a5) + $signed(-1); end
//      5C : sw a5 8 (a0) 
'h0000005C : begin if(!valid) begin addr = $signed(8) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->a = f->A[f->a_top]
//      60 : lw a4 8 (a0) 
'h00000060 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      64 : slli a4 a4 2 
'h00000064 : begin a4 <= $unsigned(a4) << 2; end
//      68 : lw a5 0 (a0) 
'h00000068 : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      6C : add a5 a5 a4 
'h0000006C : begin a5 <= $signed(a5) + $signed(a4); end
//      70 : lw a5 0 (a5) 
'h00000070 : begin if(!valid) begin addr = 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      74 : sw a5 4 (a0) 
'h00000074 : begin if(!valid) begin addr = $signed(4) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//      78 : lw ra 4 (sp) 
'h00000078 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      7C : lw s0 0 (sp) 
'h0000007C : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      80 : addi sp sp 8 
'h00000080 : begin sp <= $signed(sp) + $signed(8); end
//      84 : ret 
'h00000084 : begin pc <= ra; end
//
// 0x00000088 <swap>:
//
//void swap(filo_t* f) 
//{
//      88 : addi sp sp -8 
'h00000088 : begin sp <= $signed(sp) + $signed(-8); end
//      8C : sw ra 4 (sp) 
'h0000008C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      90 : sw s0 0 (sp) 
'h00000090 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      94 : addi s0 sp 8 
'h00000094 : begin s0 <= $signed(sp) + $signed(8); end
//  if(f->A[f->i] == f->A[f->j]) return
//      98 : lw a5 0 (a0) 
'h00000098 : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      9C : lw a4 C (a0) 
'h0000009C : begin if(!valid) begin addr = 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      A0 : slli a4 a4 2 
'h000000A0 : begin a4 <= $unsigned(a4) << 2; end
//      A4 : add a4 a5 a4 
'h000000A4 : begin a4 <= $signed(a5) + $signed(a4); end
//      A8 : lw a3 0 (a4) 
'h000000A8 : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//      AC : lw a4 10 (a0) 
'h000000AC : begin if(!valid) begin addr = 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      B0 : slli a4 a4 2 
'h000000B0 : begin a4 <= $unsigned(a4) << 2; end
//      B4 : add a4 a5 a4 
'h000000B4 : begin a4 <= $signed(a5) + $signed(a4); end
//      B8 : lw a4 0 (a4) 
'h000000B8 : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      BC : beq a3 a4 138 <swap+#xb0> 
'h000000BC : begin if($signed(a3) == $signed(a4)) pc <= 312; end
//  f->A[f->i] ^= f->A[f->j]
//      C0 : lw a4 10 (a0) 
'h000000C0 : begin if(!valid) begin addr = 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      C4 : slli a4 a4 2 
'h000000C4 : begin a4 <= $unsigned(a4) << 2; end
//      C8 : add a4 a5 a4 
'h000000C8 : begin a4 <= $signed(a5) + $signed(a4); end
//      CC : lw a2 0 (a4) 
'h000000CC : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//      D0 : lw a4 C (a0) 
'h000000D0 : begin if(!valid) begin addr = 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      D4 : slli a4 a4 2 
'h000000D4 : begin a4 <= $unsigned(a4) << 2; end
//      D8 : add a4 a5 a4 
'h000000D8 : begin a4 <= $signed(a5) + $signed(a4); end
//      DC : lw a3 0 (a4) 
'h000000DC : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//      E0 : xor a3 a3 a2 
'h000000E0 : begin a3 <= $signed(a3) ^ $signed(a2); end
//      E4 : sw a3 0 (a4) 
'h000000E4 : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->A[f->j] ^= f->A[f->i]
//      E8 : lw a4 C (a0) 
'h000000E8 : begin if(!valid) begin addr = 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      EC : slli a4 a4 2 
'h000000EC : begin a4 <= $unsigned(a4) << 2; end
//      F0 : add a4 a5 a4 
'h000000F0 : begin a4 <= $signed(a5) + $signed(a4); end
//      F4 : lw a2 0 (a4) 
'h000000F4 : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//      F8 : lw a4 10 (a0) 
'h000000F8 : begin if(!valid) begin addr = 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      FC : slli a4 a4 2 
'h000000FC : begin a4 <= $unsigned(a4) << 2; end
//     100 : add a4 a5 a4 
'h00000100 : begin a4 <= $signed(a5) + $signed(a4); end
//     104 : lw a3 0 (a4) 
'h00000104 : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     108 : xor a3 a3 a2 
'h00000108 : begin a3 <= $signed(a3) ^ $signed(a2); end
//     10C : sw a3 0 (a4) 
'h0000010C : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->A[f->i] ^= f->A[f->j]
//     110 : lw a4 10 (a0) 
'h00000110 : begin if(!valid) begin addr = 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     114 : slli a4 a4 2 
'h00000114 : begin a4 <= $unsigned(a4) << 2; end
//     118 : add a4 a5 a4 
'h00000118 : begin a4 <= $signed(a5) + $signed(a4); end
//     11C : lw a3 0 (a4) 
'h0000011C : begin if(!valid) begin addr = 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     120 : lw a4 C (a0) 
'h00000120 : begin if(!valid) begin addr = 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     124 : slli a4 a4 2 
'h00000124 : begin a4 <= $unsigned(a4) << 2; end
//     128 : add a5 a5 a4 
'h00000128 : begin a5 <= $signed(a5) + $signed(a4); end
//     12C : lw a4 0 (a5) 
'h0000012C : begin if(!valid) begin addr = 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     130 : xor a4 a4 a3 
'h00000130 : begin a4 <= $signed(a4) ^ $signed(a3); end
//     134 : sw a4 0 (a5) 
'h00000134 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//     138 : lw ra 4 (sp) 
'h00000138 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     13C : lw s0 0 (sp) 
'h0000013C : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     140 : addi sp sp 8 
'h00000140 : begin sp <= $signed(sp) + $signed(8); end
//     144 : ret 
'h00000144 : begin pc <= ra; end
//
// 0x00000148 <push_pr>:
//
//void push_pr(filo_t* f)
//{
//     148 : addi sp sp -16 
'h00000148 : begin sp <= $signed(sp) + $signed(-16); end
//     14C : sw ra C (sp) 
'h0000014C : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     150 : sw s0 8 (sp) 
'h00000150 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     154 : addi s0 sp 10 
'h00000154 : begin s0 <= $signed(sp) + $signed(16); end
//  pr_t pr
//  pr.p = f->p
//     158 : lw a5 20 (a0) 
'h00000158 : begin if(!valid) begin addr = 32 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     15C : sw a5 -16 (s0) 
'h0000015C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  pr.r = f->r
//     160 : lw a5 24 (a0) 
'h00000160 : begin if(!valid) begin addr = 36 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     164 : sw a5 -12 (s0) 
'h00000164 : begin if(!valid) begin addr = $signed(-12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->pr_top++
//     168 : lw a5 1C (a0) 
'h00000168 : begin if(!valid) begin addr = 28 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     16C : addi a5 a5 1 
'h0000016C : begin a5 <= $signed(a5) + $signed(1); end
//     170 : sw a5 1C (a0) 
'h00000170 : begin if(!valid) begin addr = $signed(28) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->pr[f->pr_top] = pr
//     174 : lw a4 1C (a0) 
'h00000174 : begin if(!valid) begin addr = 28 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     178 : slli a4 a4 3 
'h00000178 : begin a4 <= $unsigned(a4) << 3; end
//     17C : lw a5 18 (a0) 
'h0000017C : begin if(!valid) begin addr = 24 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     180 : add a5 a5 a4 
'h00000180 : begin a5 <= $signed(a5) + $signed(a4); end
//     184 : lw a4 -16 (s0) 
'h00000184 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     188 : sw a4 0 (a5) 
'h00000188 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     18C : lw a4 -12 (s0) 
'h0000018C : begin if(!valid) begin addr = -12 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     190 : sw a4 4 (a5) 
'h00000190 : begin if(!valid) begin addr = $signed(4) + $signed(a5); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//     194 : lw ra C (sp) 
'h00000194 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     198 : lw s0 8 (sp) 
'h00000198 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     19C : addi sp sp 10 
'h0000019C : begin sp <= $signed(sp) + $signed(16); end
//     1A0 : ret 
'h000001A0 : begin pc <= ra; end
//
// 0x000001a4 <pop_pr>:
//
//void pop_pr(filo_t* f)
//{
//     1A4 : addi sp sp -16 
'h000001A4 : begin sp <= $signed(sp) + $signed(-16); end
//     1A8 : sw ra C (sp) 
'h000001A8 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1AC : sw s0 8 (sp) 
'h000001AC : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1B0 : addi s0 sp 10 
'h000001B0 : begin s0 <= $signed(sp) + $signed(16); end
//  pr_t pr
//  pr = f->pr[f->pr_top]
//     1B4 : lw a4 1C (a0) 
'h000001B4 : begin if(!valid) begin addr = 28 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     1B8 : slli a4 a4 3 
'h000001B8 : begin a4 <= $unsigned(a4) << 3; end
//     1BC : lw a5 18 (a0) 
'h000001BC : begin if(!valid) begin addr = 24 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1C0 : add a5 a5 a4 
'h000001C0 : begin a5 <= $signed(a5) + $signed(a4); end
//     1C4 : lw a4 0 (a5) 
'h000001C4 : begin if(!valid) begin addr = 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     1C8 : sw a4 -16 (s0) 
'h000001C8 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1CC : lw a5 4 (a5) 
'h000001CC : begin if(!valid) begin addr = 4 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1D0 : sw a5 -12 (s0) 
'h000001D0 : begin if(!valid) begin addr = $signed(-12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->p = pr.p
//     1D4 : lw a5 -16 (s0) 
'h000001D4 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1D8 : sw a5 20 (a0) 
'h000001D8 : begin if(!valid) begin addr = $signed(32) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->r = pr.r
//     1DC : lw a5 -12 (s0) 
'h000001DC : begin if(!valid) begin addr = -12 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1E0 : sw a5 24 (a0) 
'h000001E0 : begin if(!valid) begin addr = $signed(36) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->pr_top--
//     1E4 : lw a5 1C (a0) 
'h000001E4 : begin if(!valid) begin addr = 28 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1E8 : addi a5 a5 -1 
'h000001E8 : begin a5 <= $signed(a5) + $signed(-1); end
//     1EC : sw a5 1C (a0) 
'h000001EC : begin if(!valid) begin addr = $signed(28) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//     1F0 : lw ra C (sp) 
'h000001F0 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     1F4 : lw s0 8 (sp) 
'h000001F4 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     1F8 : addi sp sp 10 
'h000001F8 : begin sp <= $signed(sp) + $signed(16); end
//     1FC : ret 
'h000001FC : begin pc <= ra; end
//
// 0x00000200 <partition>:
//
//void partition(filo_t* f)
//{
//     200 : addi sp sp -16 
'h00000200 : begin sp <= $signed(sp) + $signed(-16); end
//     204 : sw ra C (sp) 
'h00000204 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     208 : sw s0 8 (sp) 
'h00000208 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     20C : sw s1 4 (sp) 
'h0000020C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     210 : addi s0 sp 10 
'h00000210 : begin s0 <= $signed(sp) + $signed(16); end
//     214 : mv s1 a0 
'h00000214 : begin s1 <= a0; end
//  f->x = f->A[f->r]
//     218 : lw a4 0 (a0) 
'h00000218 : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     21C : lw a5 24 (a0) 
'h0000021C : begin if(!valid) begin addr = 36 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     220 : slli a5 a5 2 
'h00000220 : begin a5 <= $unsigned(a5) << 2; end
//     224 : add a5 a4 a5 
'h00000224 : begin a5 <= $signed(a4) + $signed(a5); end
//     228 : lw a5 0 (a5) 
'h00000228 : begin if(!valid) begin addr = 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     22C : sw a5 14 (a0) 
'h0000022C : begin if(!valid) begin addr = $signed(20) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->i = f->p
//     230 : lw a5 20 (a0) 
'h00000230 : begin if(!valid) begin addr = 32 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     234 : sw a5 C (a0) 
'h00000234 : begin if(!valid) begin addr = $signed(12) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  for(f->j=f->p
//     238 : lw a5 20 (a0) 
'h00000238 : begin if(!valid) begin addr = 32 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     23C : sw a5 10 (a0) 
'h0000023C : begin if(!valid) begin addr = $signed(16) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     240 : lw a3 10 (s1) 
'h00000240 : begin if(!valid) begin addr = 16 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     244 : lw a5 24 (s1) 
'h00000244 : begin if(!valid) begin addr = 36 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     248 : bne a3 a5 274 <partition+#x74> 
'h00000248 : begin if($signed(a3) != $signed(a5)) pc <= 628; end
//    if(f->A[f->j] < f->x) {
//      swap(f)
//      f->i++
//    }
//  }
//  swap(f)
//     24C : mv a0 s1 
'h0000024C : begin a0 <= s1; end
//     250 : auipc ra 0 
'h00000250 : begin ra <= pc + (0 << 12); end
//     254 : jalr -456 (ra) # 88 <swap> 
'h00000254 : begin pc <= $signed(-456) + $signed(ra); ra <= pc + 4; end
//  f->q = f->i
//     258 : lw a5 C (s1) 
'h00000258 : begin if(!valid) begin addr = 12 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     25C : sw a5 28 (s1) 
'h0000025C : begin if(!valid) begin addr = $signed(40) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//     260 : lw ra C (sp) 
'h00000260 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     264 : lw s0 8 (sp) 
'h00000264 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     268 : lw s1 4 (sp) 
'h00000268 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     26C : addi sp sp 10 
'h0000026C : begin sp <= $signed(sp) + $signed(16); end
//     270 : ret 
'h00000270 : begin pc <= ra; end
//    if(f->A[f->j] < f->x) {
//     274 : lw a5 10 (s1) 
'h00000274 : begin if(!valid) begin addr = 16 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     278 : slli a5 a5 2 
'h00000278 : begin a5 <= $unsigned(a5) << 2; end
//     27C : add a5 a4 a5 
'h0000027C : begin a5 <= $signed(a4) + $signed(a5); end
//     280 : lw a3 0 (a5) 
'h00000280 : begin if(!valid) begin addr = 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     284 : lw a5 14 (s1) 
'h00000284 : begin if(!valid) begin addr = 20 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     288 : bge a3 a5 2AC <partition+#xac> 
'h00000288 : begin if($signed(a3) >= $signed(a5)) pc <= 684; end
//     28C : sw a4 -16 (s0) 
'h0000028C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      swap(f)
//     290 : mv a0 s1 
'h00000290 : begin a0 <= s1; end
//     294 : auipc ra 0 
'h00000294 : begin ra <= pc + (0 << 12); end
//     298 : jalr -524 (ra) # 88 <swap> 
'h00000298 : begin pc <= $signed(-524) + $signed(ra); ra <= pc + 4; end
//      f->i++
//     29C : lw a5 C (s1) 
'h0000029C : begin if(!valid) begin addr = 12 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2A0 : addi a5 a5 1 
'h000002A0 : begin a5 <= $signed(a5) + $signed(1); end
//     2A4 : sw a5 C (s1) 
'h000002A4 : begin if(!valid) begin addr = $signed(12) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2A8 : lw a4 -16 (s0) 
'h000002A8 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//  for(f->j=f->p
//     2AC : lw a5 10 (s1) 
'h000002AC : begin if(!valid) begin addr = 16 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2B0 : addi a5 a5 1 
'h000002B0 : begin a5 <= $signed(a5) + $signed(1); end
//     2B4 : sw a5 10 (s1) 
'h000002B4 : begin if(!valid) begin addr = $signed(16) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2B8 : j 240 <partition+#x40> 
'h000002B8 : begin pc <= 576; end
//
// 0x000002bc <quicksort>:
//
//void quicksort(filo_t* f)
//{
//     2BC : addi sp sp -20 
'h000002BC : begin sp <= $signed(sp) + $signed(-20); end
//     2C0 : sw ra 10 (sp) 
'h000002C0 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2C4 : sw s0 C (sp) 
'h000002C4 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2C8 : sw s1 8 (sp) 
'h000002C8 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2CC : addi s0 sp 14 
'h000002CC : begin s0 <= $signed(sp) + $signed(20); end
//     2D0 : mv s1 a0 
'h000002D0 : begin s1 <= a0; end
//  f->pr_top = -1
//     2D4 : li a5 -1 
'h000002D4 : begin a5 <= -1; end
//     2D8 : sw a5 1C (a0) 
'h000002D8 : begin if(!valid) begin addr = $signed(28) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->p = 0
//     2DC : sw zero 20 (a0) 
'h000002DC : begin if(!valid) begin addr = $signed(32) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  f->r = f->a_top -1
//     2E0 : lw a5 8 (a0) 
'h000002E0 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2E4 : addi a5 a5 -1 
'h000002E4 : begin a5 <= $signed(a5) + $signed(-1); end
//     2E8 : sw a5 24 (a0) 
'h000002E8 : begin if(!valid) begin addr = $signed(36) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      f->p =q +1
//      f->r =r
//      if(f->p < f->r) push_pr(f)
//      f->p = p
//      f->r = q-1
//      if(f->p < f->r) push_pr(f)
//     2EC : auipc ra 0 
'h000002EC : begin ra <= pc + (0 << 12); end
//     2F0 : jalr -420 (ra) # 148 <push_pr> 
'h000002F0 : begin pc <= $signed(-420) + $signed(ra); ra <= pc + 4; end
//  while(f->pr_top >= 0) {
//     2F4 : lw a5 1C (s1) 
'h000002F4 : begin if(!valid) begin addr = 28 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2F8 : bgez a5 310 <quicksort+#x54> 
'h000002F8 : begin if($signed(a5) >= 0) pc <= 784; end
//    }
//  }
//}
//     2FC : lw ra 10 (sp) 
'h000002FC : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     300 : lw s0 C (sp) 
'h00000300 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     304 : lw s1 8 (sp) 
'h00000304 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     308 : addi sp sp 14 
'h00000308 : begin sp <= $signed(sp) + $signed(20); end
//     30C : ret 
'h0000030C : begin pc <= ra; end
//    pop_pr(f)
//     310 : mv a0 s1 
'h00000310 : begin a0 <= s1; end
//     314 : auipc ra 0 
'h00000314 : begin ra <= pc + (0 << 12); end
//     318 : jalr -368 (ra) # 1A4 <pop_pr> 
'h00000318 : begin pc <= $signed(-368) + $signed(ra); ra <= pc + 4; end
//    if(f->p < f->r) {
//     31C : lw a4 20 (s1) 
'h0000031C : begin if(!valid) begin addr = 32 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     320 : lw a5 24 (s1) 
'h00000320 : begin if(!valid) begin addr = 36 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     324 : bge a4 a5 2F4 <quicksort+#x38> 
'h00000324 : begin if($signed(a4) >= $signed(a5)) pc <= 756; end
//      partition(f)
//     328 : mv a0 s1 
'h00000328 : begin a0 <= s1; end
//     32C : auipc ra 0 
'h0000032C : begin ra <= pc + (0 << 12); end
//     330 : jalr -300 (ra) # 200 <partition> 
'h00000330 : begin pc <= $signed(-300) + $signed(ra); ra <= pc + 4; end
//      int q = f->q
//     334 : lw a5 28 (s1) 
'h00000334 : begin if(!valid) begin addr = 40 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      int r = f->r
//     338 : lw a3 24 (s1) 
'h00000338 : begin if(!valid) begin addr = 36 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//      int p = f->p
//     33C : lw a4 20 (s1) 
'h0000033C : begin if(!valid) begin addr = 32 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//      f->p =q +1
//     340 : addi a2 a5 1 
'h00000340 : begin a2 <= $signed(a5) + $signed(1); end
//     344 : sw a2 20 (s1) 
'h00000344 : begin if(!valid) begin addr = $signed(32) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      f->r =r
//     348 : sw a3 24 (s1) 
'h00000348 : begin if(!valid) begin addr = $signed(36) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      if(f->p < f->r) push_pr(f)
//     34C : lw a2 20 (s1) 
'h0000034C : begin if(!valid) begin addr = 32 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     350 : lw a3 24 (s1) 
'h00000350 : begin if(!valid) begin addr = 36 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     354 : bge a2 a3 374 <quicksort+#xb8> 
'h00000354 : begin if($signed(a2) >= $signed(a3)) pc <= 884; end
//     358 : sw a4 -20 (s0) 
'h00000358 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     35C : sw a5 -16 (s0) 
'h0000035C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     360 : mv a0 s1 
'h00000360 : begin a0 <= s1; end
//     364 : auipc ra 0 
'h00000364 : begin ra <= pc + (0 << 12); end
//     368 : jalr -540 (ra) # 148 <push_pr> 
'h00000368 : begin pc <= $signed(-540) + $signed(ra); ra <= pc + 4; end
//     36C : lw a4 -20 (s0) 
'h0000036C : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     370 : lw a5 -16 (s0) 
'h00000370 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      f->p = p
//     374 : sw a4 20 (s1) 
'h00000374 : begin if(!valid) begin addr = $signed(32) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      f->r = q-1
//     378 : addi a5 a5 -1 
'h00000378 : begin a5 <= $signed(a5) + $signed(-1); end
//     37C : sw a5 24 (s1) 
'h0000037C : begin if(!valid) begin addr = $signed(36) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      if(f->p < f->r) push_pr(f)
//     380 : lw a4 20 (s1) 
'h00000380 : begin if(!valid) begin addr = 32 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     384 : lw a5 24 (s1) 
'h00000384 : begin if(!valid) begin addr = 36 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     388 : bge a4 a5 2F4 <quicksort+#x38> 
'h00000388 : begin if($signed(a4) >= $signed(a5)) pc <= 756; end
//     38C : mv a0 s1 
'h0000038C : begin a0 <= s1; end
//     390 : j 2EC <quicksort+#x30> 
'h00000390 : begin pc <= 748; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
