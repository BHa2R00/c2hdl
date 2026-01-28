module insertsort (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a20, a30, a50, a40, a00, s00, ra0, sp0);
input clk, rstb;
input setb;
output reg idle;
output reg [8:0] pc;
input [8:0] pc0;
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
  end
  else begin
    zero <= 32'd0;
    valid <= 0;
    write <= 0;
    size <= 0;
    if(!setb) begin
      pc <= (pc0 > 'h1F4) ? 'h1F4 + 4 : pc0;
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
      pc <= (pc > 'h1F4) ? 'h1F4 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/insertsort.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <push_a>:
//  volatile int   i, j
//  volatile int   p, r
//} filo_t
//
//void push_a(filo_t* f)
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//  f->A[f->a_top] = f->a
//      10 : lw a4 8 (a0) 
'h00000010 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      14 : slli a4 a4 2 
'h00000014 : begin a4 <= $unsigned(a4) << 2; end
//      18 : lw a5 0 (a0) 
'h00000018 : begin if(!valid && !ready) begin addr <= 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      1C : add a5 a5 a4 
'h0000001C : begin a5 <= $signed(a5) + $signed(a4); end
//      20 : lw a4 4 (a0) 
'h00000020 : begin if(!valid && !ready) begin addr <= 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      24 : sw a4 0 (a5) 
'h00000024 : begin if(!valid && !ready) begin addr <= 0 + a5; valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  f->a_top++
//      28 : lw a5 8 (a0) 
'h00000028 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      2C : addi a5 a5 1 
'h0000002C : begin a5 <= $signed(a5) + $signed(1); end
//      30 : sw a5 8 (a0) 
'h00000030 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//}
//      34 : lw ra 4 (sp) 
'h00000034 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      38 : lw s0 0 (sp) 
'h00000038 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
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
'h00000048 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      4C : sw s0 0 (sp) 
'h0000004C : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      50 : addi s0 sp 8 
'h00000050 : begin s0 <= $signed(sp) + $signed(8); end
//  f->a_top--
//      54 : lw a5 8 (a0) 
'h00000054 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      58 : addi a5 a5 -1 
'h00000058 : begin a5 <= $signed(a5) + $signed(-1); end
//      5C : sw a5 8 (a0) 
'h0000005C : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  f->a = f->A[f->a_top]
//      60 : lw a4 8 (a0) 
'h00000060 : begin if(!valid && !ready) begin addr <= 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      64 : slli a4 a4 2 
'h00000064 : begin a4 <= $unsigned(a4) << 2; end
//      68 : lw a5 0 (a0) 
'h00000068 : begin if(!valid && !ready) begin addr <= 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      6C : add a5 a5 a4 
'h0000006C : begin a5 <= $signed(a5) + $signed(a4); end
//      70 : lw a5 0 (a5) 
'h00000070 : begin if(!valid && !ready) begin addr <= 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      74 : sw a5 4 (a0) 
'h00000074 : begin if(!valid && !ready) begin addr <= 4 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//}
//      78 : lw ra 4 (sp) 
'h00000078 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      7C : lw s0 0 (sp) 
'h0000007C : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
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
'h0000008C : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      90 : sw s0 0 (sp) 
'h00000090 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      94 : addi s0 sp 8 
'h00000094 : begin s0 <= $signed(sp) + $signed(8); end
//  if(f->A[f->i] > f->A[f->j]) {
//      98 : lw a5 0 (a0) 
'h00000098 : begin if(!valid && !ready) begin addr <= 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      9C : lw a4 C (a0) 
'h0000009C : begin if(!valid && !ready) begin addr <= 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      A0 : slli a4 a4 2 
'h000000A0 : begin a4 <= $unsigned(a4) << 2; end
//      A4 : add a4 a5 a4 
'h000000A4 : begin a4 <= $signed(a5) + $signed(a4); end
//      A8 : lw a3 0 (a4) 
'h000000A8 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//      AC : lw a4 10 (a0) 
'h000000AC : begin if(!valid && !ready) begin addr <= 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      B0 : slli a4 a4 2 
'h000000B0 : begin a4 <= $unsigned(a4) << 2; end
//      B4 : add a4 a5 a4 
'h000000B4 : begin a4 <= $signed(a5) + $signed(a4); end
//      B8 : lw a4 0 (a4) 
'h000000B8 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      BC : bge a4 a3 15C <swap+#xd4> 
'h000000BC : begin if($signed(a4) >= $signed(a3)) pc <= 348; end
//    if(f->A[f->i] == f->A[f->j]) return
//      C0 : lw a4 C (a0) 
'h000000C0 : begin if(!valid && !ready) begin addr <= 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      C4 : slli a4 a4 2 
'h000000C4 : begin a4 <= $unsigned(a4) << 2; end
//      C8 : add a4 a5 a4 
'h000000C8 : begin a4 <= $signed(a5) + $signed(a4); end
//      CC : lw a3 0 (a4) 
'h000000CC : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//      D0 : lw a4 10 (a0) 
'h000000D0 : begin if(!valid && !ready) begin addr <= 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      D4 : slli a4 a4 2 
'h000000D4 : begin a4 <= $unsigned(a4) << 2; end
//      D8 : add a4 a5 a4 
'h000000D8 : begin a4 <= $signed(a5) + $signed(a4); end
//      DC : lw a4 0 (a4) 
'h000000DC : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      E0 : beq a3 a4 15C <swap+#xd4> 
'h000000E0 : begin if($signed(a3) == $signed(a4)) pc <= 348; end
//    f->A[f->i] ^= f->A[f->j]
//      E4 : lw a4 10 (a0) 
'h000000E4 : begin if(!valid && !ready) begin addr <= 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      E8 : slli a4 a4 2 
'h000000E8 : begin a4 <= $unsigned(a4) << 2; end
//      EC : add a4 a5 a4 
'h000000EC : begin a4 <= $signed(a5) + $signed(a4); end
//      F0 : lw a2 0 (a4) 
'h000000F0 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//      F4 : lw a4 C (a0) 
'h000000F4 : begin if(!valid && !ready) begin addr <= 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      F8 : slli a4 a4 2 
'h000000F8 : begin a4 <= $unsigned(a4) << 2; end
//      FC : add a4 a5 a4 
'h000000FC : begin a4 <= $signed(a5) + $signed(a4); end
//     100 : lw a3 0 (a4) 
'h00000100 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//     104 : xor a3 a3 a2 
'h00000104 : begin a3 <= $signed(a3) ^ $signed(a2); end
//     108 : sw a3 0 (a4) 
'h00000108 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//    f->A[f->j] ^= f->A[f->i]
//     10C : lw a4 C (a0) 
'h0000010C : begin if(!valid && !ready) begin addr <= 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     110 : slli a4 a4 2 
'h00000110 : begin a4 <= $unsigned(a4) << 2; end
//     114 : add a4 a5 a4 
'h00000114 : begin a4 <= $signed(a5) + $signed(a4); end
//     118 : lw a2 0 (a4) 
'h00000118 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//     11C : lw a4 10 (a0) 
'h0000011C : begin if(!valid && !ready) begin addr <= 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     120 : slli a4 a4 2 
'h00000120 : begin a4 <= $unsigned(a4) << 2; end
//     124 : add a4 a5 a4 
'h00000124 : begin a4 <= $signed(a5) + $signed(a4); end
//     128 : lw a3 0 (a4) 
'h00000128 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//     12C : xor a3 a3 a2 
'h0000012C : begin a3 <= $signed(a3) ^ $signed(a2); end
//     130 : sw a3 0 (a4) 
'h00000130 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//    f->A[f->i] ^= f->A[f->j]
//     134 : lw a4 10 (a0) 
'h00000134 : begin if(!valid && !ready) begin addr <= 16 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     138 : slli a4 a4 2 
'h00000138 : begin a4 <= $unsigned(a4) << 2; end
//     13C : add a4 a5 a4 
'h0000013C : begin a4 <= $signed(a5) + $signed(a4); end
//     140 : lw a3 0 (a4) 
'h00000140 : begin if(!valid && !ready) begin addr <= 0 + a4; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//     144 : lw a4 C (a0) 
'h00000144 : begin if(!valid && !ready) begin addr <= 12 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     148 : slli a4 a4 2 
'h00000148 : begin a4 <= $unsigned(a4) << 2; end
//     14C : add a5 a5 a4 
'h0000014C : begin a5 <= $signed(a5) + $signed(a4); end
//     150 : lw a4 0 (a5) 
'h00000150 : begin if(!valid && !ready) begin addr <= 0 + a5; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     154 : xor a4 a4 a3 
'h00000154 : begin a4 <= $signed(a4) ^ $signed(a3); end
//     158 : sw a4 0 (a5) 
'h00000158 : begin if(!valid && !ready) begin addr <= 0 + a5; valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  }
//}
//     15C : lw ra 4 (sp) 
'h0000015C : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//     160 : lw s0 0 (sp) 
'h00000160 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//     164 : addi sp sp 8 
'h00000164 : begin sp <= $signed(sp) + $signed(8); end
//     168 : ret 
'h00000168 : begin pc <= ra; end
//
// 0x0000016c <insertsort>:
//
//void insertsort (filo_t* f)
//{
//     16C : addi sp sp -12 
'h0000016C : begin sp <= $signed(sp) + $signed(-12); end
//     170 : sw ra 8 (sp) 
'h00000170 : begin if(!valid && !ready) begin addr <= 8 + sp; valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     174 : sw s0 4 (sp) 
'h00000174 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     178 : sw s1 0 (sp) 
'h00000178 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     17C : addi s0 sp C 
'h0000017C : begin s0 <= $signed(sp) + $signed(12); end
//     180 : mv s1 a0 
'h00000180 : begin s1 <= a0; end
//  for(f->p=1
//     184 : li a5 1 
'h00000184 : begin a5 <= 1; end
//     188 : sw a5 14 (a0) 
'h00000188 : begin if(!valid && !ready) begin addr <= 20 + a0; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     18C : lw a4 14 (s1) 
'h0000018C : begin if(!valid && !ready) begin addr <= 20 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//     190 : lw a5 8 (s1) 
'h00000190 : begin if(!valid && !ready) begin addr <= 8 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     194 : blt a4 a5 1AC <insertsort+#x40> 
'h00000194 : begin if($signed(a4) < $signed(a5)) pc <= 428; end
//      f->i = f->r
//      f->j = f->r+1
//      swap(f)
//    }
//  }
//}
//     198 : lw ra 8 (sp) 
'h00000198 : begin if(!valid && !ready) begin addr <= 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//     19C : lw s0 4 (sp) 
'h0000019C : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//     1A0 : lw s1 0 (sp) 
'h000001A0 : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) s1 <= rdata_w; end
//     1A4 : addi sp sp C 
'h000001A4 : begin sp <= $signed(sp) + $signed(12); end
//     1A8 : ret 
'h000001A8 : begin pc <= ra; end
//    for(f->r = f->p-1
//     1AC : lw a5 14 (s1) 
'h000001AC : begin if(!valid && !ready) begin addr <= 20 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1B0 : addi a5 a5 -1 
'h000001B0 : begin a5 <= $signed(a5) + $signed(-1); end
//     1B4 : sw a5 18 (s1) 
'h000001B4 : begin if(!valid && !ready) begin addr <= 24 + s1; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     1B8 : lw a5 18 (s1) 
'h000001B8 : begin if(!valid && !ready) begin addr <= 24 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1BC : bgez a5 1D0 <insertsort+#x64> 
'h000001BC : begin if($signed(a5) >= 0) pc <= 464; end
//  for(f->p=1
//     1C0 : lw a5 14 (s1) 
'h000001C0 : begin if(!valid && !ready) begin addr <= 20 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1C4 : addi a5 a5 1 
'h000001C4 : begin a5 <= $signed(a5) + $signed(1); end
//     1C8 : sw a5 14 (s1) 
'h000001C8 : begin if(!valid && !ready) begin addr <= 20 + s1; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//     1CC : j 18C <insertsort+#x20> 
'h000001CC : begin pc <= 396; end
//      f->i = f->r
//     1D0 : lw a5 18 (s1) 
'h000001D0 : begin if(!valid && !ready) begin addr <= 24 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1D4 : sw a5 C (s1) 
'h000001D4 : begin if(!valid && !ready) begin addr <= 12 + s1; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      f->j = f->r+1
//     1D8 : lw a5 18 (s1) 
'h000001D8 : begin if(!valid && !ready) begin addr <= 24 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1DC : addi a5 a5 1 
'h000001DC : begin a5 <= $signed(a5) + $signed(1); end
//     1E0 : sw a5 10 (s1) 
'h000001E0 : begin if(!valid && !ready) begin addr <= 16 + s1; valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      swap(f)
//     1E4 : mv a0 s1 
'h000001E4 : begin a0 <= s1; end
//     1E8 : auipc ra 0 
'h000001E8 : begin ra <= pc + (0 << 12); end
//     1EC : jalr -352 (ra) # 88 <swap> 
'h000001EC : begin pc <= $signed(-352) + $signed(ra); ra <= pc + 4; end
//    for(f->r = f->p-1
//     1F0 : lw a5 18 (s1) 
'h000001F0 : begin if(!valid && !ready) begin addr <= 24 + s1; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//     1F4 : j 1B0 <insertsort+#x44> 
'h000001F4 : begin pc <= 432; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
