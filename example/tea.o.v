module tea (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, t20, t10, t00, s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0);
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
input [31:0] t20, t10, t00, s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata;
wire [15:0] rdata_h = rdata;
wire [ 7:0] rdata_b = rdata;
reg [31:0] zero, t2, t1, t0, s1, a2, a1, a4, a5, a3, a0, s0, ra, sp;
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
      pc <= (pc0 > 'h27C) ? 'h27C + 4 : pc0;
      t2 <= t20;
      t1 <= t10;
      t0 <= t00;
      s1 <= s10;
      a2 <= a20;
      a1 <= a10;
      a4 <= a40;
      a5 <= a50;
      a3 <= a30;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h27C) ? 'h27C + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/tea.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <swmul>:
//#ifdef SIM
//#inclu 0xde <stdio.h>
//#endif
//
//int swmul(short a, short b) 
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//      10 : mv a3 a0 
'h00000010 : begin a3 <= a0; end
//  int m = 0
//  unsigned short aa = (unsigned short)(short)a
//  unsigned short bb = (unsigned short)(short)b
//  if(aa & (1<<15)) aa = -aa
//      14 : srai a5 a0 F 
'h00000014 : begin a5 <= $signed(a0) >>> 15; end
//      18 : xor a4 a0 a5 
'h00000018 : begin a4 <= $signed(a0) ^ $signed(a5); end
//      1C : sub a4 a4 a5 
'h0000001C : begin a4 <= $signed(a4) - $signed(a5); end
//      20 : slli a4 a4 10 
'h00000020 : begin a4 <= $unsigned(a4) << 16; end
//      24 : srli a4 a4 10 
'h00000024 : begin a4 <= $unsigned(a4) >> 16; end
//  if(bb & (1<<15)) bb = -bb
//      28 : srai a2 a1 F 
'h00000028 : begin a2 <= $signed(a1) >>> 15; end
//      2C : xor a5 a1 a2 
'h0000002C : begin a5 <= $signed(a1) ^ $signed(a2); end
//      30 : sub a5 a5 a2 
'h00000030 : begin a5 <= $signed(a5) - $signed(a2); end
//      34 : slli a5 a5 10 
'h00000034 : begin a5 <= $unsigned(a5) << 16; end
//      38 : srli a5 a5 10 
'h00000038 : begin a5 <= $unsigned(a5) >> 16; end
//      3C : li a0 0 
'h0000003C : begin a0 <= 0; end
//  while(aa) {
//      40 : bnez a4 60 <swmul+#x60> 
'h00000040 : begin if($signed(a4) != 0) pc <= 96; end
//    if(aa & 1) m += bb
//     0xbb <<=1
//    aa >>=1
//  }
//  if((a<0)!=(b<0)) m = -m
//      44 : xor a3 a3 a1 
'h00000044 : begin a3 <= $signed(a3) ^ $signed(a1); end
//      48 : bgez a3 50 <swmul+#x50> 
'h00000048 : begin if($signed(a3) >= 0) pc <= 80; end
//      4C : neg a0 a0 
'h0000004C : begin a0 <= 0-a0; end
//  return m
//}
//      50 : lw ra 4 (sp) 
'h00000050 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      54 : lw s0 0 (sp) 
'h00000054 : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      58 : addi sp sp 8 
'h00000058 : begin sp <= $signed(sp) + $signed(8); end
//      5C : ret 
'h0000005C : begin pc <= ra; end
//    if(aa & 1) m += bb
//      60 : andi a2 a4 1 
'h00000060 : begin a2 <= $signed(a4) & $signed(1); end
//      64 : beqz a2 6C <swmul+#x6c> 
'h00000064 : begin if($signed(a2) == 0) pc <= 108; end
//      68 : add a0 a0 a5 
'h00000068 : begin a0 <= $signed(a0) + $signed(a5); end
//     0xbb <<=1
//      6C : slli a5 a5 1 
'h0000006C : begin a5 <= $unsigned(a5) << 1; end
//      70 : slli a5 a5 10 
'h00000070 : begin a5 <= $unsigned(a5) << 16; end
//      74 : srli a5 a5 10 
'h00000074 : begin a5 <= $unsigned(a5) >> 16; end
//    aa >>=1
//      78 : srli a4 a4 1 
'h00000078 : begin a4 <= $unsigned(a4) >> 1; end
//      7C : j 40 <swmul+#x40> 
'h0000007C : begin pc <= 64; end
//
// 0x00000080 <tinyenc>:
//  volatile unsigned short* dat
//  volatile unsigned short* key
//} tea_t
//
//void tinyenc(tea_t* t)
//{
//      80 : addi sp sp -16 
'h00000080 : begin sp <= $signed(sp) + $signed(-16); end
//      84 : sw ra C (sp) 
'h00000084 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      88 : sw s0 8 (sp) 
'h00000088 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      8C : sw s1 4 (sp) 
'h0000008C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      90 : addi s0 sp 10 
'h00000090 : begin s0 <= $signed(sp) + $signed(16); end
//  unsigned short x = t->dat[0]
//      94 : lw a1 4 (a0) 
'h00000094 : begin if(!valid) begin addr = 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//      98 : lhu a3 0 (a1) 
'h00000098 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{16{1'b0}},rdata_h}; end
//      9C : slli a3 a3 10 
'h0000009C : begin a3 <= $unsigned(a3) << 16; end
//      A0 : srli a3 a3 10 
'h000000A0 : begin a3 <= $unsigned(a3) >> 16; end
//  unsigned short y = t->dat[1]
//      A4 : lhu a4 2 (a1) 
'h000000A4 : begin if(!valid) begin addr = $signed(2) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= {{16{1'b0}},rdata_h}; end
//      A8 : slli a4 a4 10 
'h000000A8 : begin a4 <= $unsigned(a4) << 16; end
//      AC : srli a4 a4 10 
'h000000AC : begin a4 <= $unsigned(a4) >> 16; end
//  unsigned short sum = 0
//  int i
//  for(i=0
//      B0 : li t0 0 
'h000000B0 : begin t0 <= 0; end
//  unsigned short sum = 0
//      B4 : li a2 0 
'h000000B4 : begin a2 <= 0; end
//    sum += DELTA
//      B8 : lui a5 FFFFA 
'h000000B8 : begin a5 <= 1048570 << 12; end
//      BC : addi a5 a5 -457 # FFFF9E37 <tinydec+#xffff9cd3> 
'h000000BC : begin a5 <= $signed(a5) + $signed(-457); end
//      C0 : sw a5 -16 (s0) 
'h000000C0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  for(i=0
//      C4 : lw a5 0 (a0) 
'h000000C4 : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      C8 : blt t0 a5 E8 <tinyenc+#x68> 
'h000000C8 : begin if($signed(t0) < $signed(a5)) pc <= 232; end
//    y += ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3])
//    #ifdef SIM
//    printf("sum = %x\n", sum)
//    #endif
//  }
//  t->dat[0] = x
//      CC : sh a3 0 (a1) 
'h000000CC : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 1; size <= 1; wdata <= a3[15:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  t->dat[1] = y
//      D0 : sh a4 2 (a1) 
'h000000D0 : begin if(!valid) begin addr = $signed(2) + $signed(a1); valid <= 1; write <= 1; size <= 1; wdata <= a4[15:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//      D4 : lw ra C (sp) 
'h000000D4 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      D8 : lw s0 8 (sp) 
'h000000D8 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      DC : lw s1 4 (sp) 
'h000000DC : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//      E0 : addi sp sp 10 
'h000000E0 : begin sp <= $signed(sp) + $signed(16); end
//      E4 : ret 
'h000000E4 : begin pc <= ra; end
//    sum += DELTA
//      E8 : lw a5 -16 (s0) 
'h000000E8 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//      EC : add a2 a2 a5 
'h000000EC : begin a2 <= $signed(a2) + $signed(a5); end
//      F0 : slli a2 a2 10 
'h000000F0 : begin a2 <= $unsigned(a2) << 16; end
//      F4 : srli a2 a2 10 
'h000000F4 : begin a2 <= $unsigned(a2) >> 16; end
//    x += ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1])
//      F8 : lw t1 8 (a0) 
'h000000F8 : begin if(!valid) begin addr = 8 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//      FC : lhu a5 0 (t1) 
'h000000FC : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{16{1'b0}},rdata_h}; end
//     100 : lhu t2 2 (t1) 
'h00000100 : begin if(!valid) begin addr = $signed(2) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t2 <= {{16{1'b0}},rdata_h}; end
//     104 : slli s1 a4 4 
'h00000104 : begin s1 <= $unsigned(a4) << 4; end
//     108 : add a5 s1 a5 
'h00000108 : begin a5 <= $signed(s1) + $signed(a5); end
//     10C : srli s1 a4 5 
'h0000010C : begin s1 <= $unsigned(a4) >> 5; end
//     110 : add s1 s1 t2 
'h00000110 : begin s1 <= $signed(s1) + $signed(t2); end
//     114 : xor a5 a5 s1 
'h00000114 : begin a5 <= $signed(a5) ^ $signed(s1); end
//     118 : add t2 a4 a2 
'h00000118 : begin t2 <= $signed(a4) + $signed(a2); end
//     11C : xor a5 a5 t2 
'h0000011C : begin a5 <= $signed(a5) ^ $signed(t2); end
//     120 : add a5 a3 a5 
'h00000120 : begin a5 <= $signed(a3) + $signed(a5); end
//     124 : slli a3 a5 10 
'h00000124 : begin a3 <= $unsigned(a5) << 16; end
//     128 : srli a3 a3 10 
'h00000128 : begin a3 <= $unsigned(a3) >> 16; end
//    y += ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3])
//     12C : lhu s1 4 (t1) 
'h0000012C : begin if(!valid) begin addr = $signed(4) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{16{1'b0}},rdata_h}; end
//     130 : lhu t2 6 (t1) 
'h00000130 : begin if(!valid) begin addr = $signed(6) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t2 <= {{16{1'b0}},rdata_h}; end
//     134 : slli a5 a3 4 
'h00000134 : begin a5 <= $unsigned(a3) << 4; end
//     138 : add a5 a5 s1 
'h00000138 : begin a5 <= $signed(a5) + $signed(s1); end
//     13C : srli t1 a3 5 
'h0000013C : begin t1 <= $unsigned(a3) >> 5; end
//     140 : add t1 t1 t2 
'h00000140 : begin t1 <= $signed(t1) + $signed(t2); end
//     144 : xor a5 a5 t1 
'h00000144 : begin a5 <= $signed(a5) ^ $signed(t1); end
//     148 : add t1 a2 a3 
'h00000148 : begin t1 <= $signed(a2) + $signed(a3); end
//     14C : xor a5 a5 t1 
'h0000014C : begin a5 <= $signed(a5) ^ $signed(t1); end
//     150 : add a5 a4 a5 
'h00000150 : begin a5 <= $signed(a4) + $signed(a5); end
//     154 : slli a4 a5 10 
'h00000154 : begin a4 <= $unsigned(a5) << 16; end
//     158 : srli a4 a4 10 
'h00000158 : begin a4 <= $unsigned(a4) >> 16; end
//  for(i=0
//     15C : addi t0 t0 1 
'h0000015C : begin t0 <= $signed(t0) + $signed(1); end
//     160 : j C4 <tinyenc+#x44> 
'h00000160 : begin pc <= 196; end
//
// 0x00000164 <tinydec>:
//
//void tinydec (tea_t* t) {
//     164 : addi sp sp -28 
'h00000164 : begin sp <= $signed(sp) + $signed(-28); end
//     168 : sw ra 18 (sp) 
'h00000168 : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     16C : sw s0 14 (sp) 
'h0000016C : begin if(!valid) begin addr = $signed(20) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     170 : sw s1 10 (sp) 
'h00000170 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     174 : addi s0 sp 1C 
'h00000174 : begin s0 <= $signed(sp) + $signed(28); end
//  unsigned short x = t->dat[0]
//     178 : lw t1 4 (a0) 
'h00000178 : begin if(!valid) begin addr = 4 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//     17C : lhu a4 0 (t1) 
'h0000017C : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= {{16{1'b0}},rdata_h}; end
//     180 : slli a4 a4 10 
'h00000180 : begin a4 <= $unsigned(a4) << 16; end
//     184 : srli a4 a4 10 
'h00000184 : begin a4 <= $unsigned(a4) >> 16; end
//     188 : sw a4 -28 (s0) 
'h00000188 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  unsigned short y = t->dat[1]
//     18C : lhu s1 2 (t1) 
'h0000018C : begin if(!valid) begin addr = $signed(2) + $signed(t1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{16{1'b0}},rdata_h}; end
//     190 : sw t1 -24 (s0) 
'h00000190 : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     194 : slli s1 s1 10 
'h00000194 : begin s1 <= $unsigned(s1) << 16; end
//     198 : srli s1 s1 10 
'h00000198 : begin s1 <= $unsigned(s1) >> 16; end
//  unsigned short sum = swmul(DELTA, t->round)
//     19C : lw a1 0 (a0) 
'h0000019C : begin if(!valid) begin addr = 0 + a0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//     1A0 : sw a0 -20 (s0) 
'h000001A0 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1A4 : slli a1 a1 10 
'h000001A4 : begin a1 <= $unsigned(a1) << 16; end
//     1A8 : srai a1 a1 10 
'h000001A8 : begin a1 <= $signed(a1) >>> 16; end
//     1AC : lui a0 FFFFA 
'h000001AC : begin a0 <= 1048570 << 12; end
//     1B0 : addi a0 a0 -457 # FFFF9E37 <tinydec+#xffff9cd3> 
'h000001B0 : begin a0 <= $signed(a0) + $signed(-457); end
//     1B4 : auipc ra 0 
'h000001B4 : begin ra <= pc + (0 << 12); end
//     1B8 : jalr -436 (ra) # 0 <swmul> 
'h000001B8 : begin pc <= $signed(-436) + $signed(ra); ra <= pc + 4; end
//     1BC : slli a3 a0 10 
'h000001BC : begin a3 <= $unsigned(a0) << 16; end
//     1C0 : srli a3 a3 10 
'h000001C0 : begin a3 <= $unsigned(a3) >> 16; end
//  int i
//  for(i=0
//     1C4 : li a0 0 
'h000001C4 : begin a0 <= 0; end
//    y -= ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3])
//    x -= ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1])
//    sum -= DELTA
//     1C8 : lui a5 6 
'h000001C8 : begin a5 <= 6 << 12; end
//     1CC : addi a5 a5 1C9 # 61C9 <tinydec+#x6065> 
'h000001CC : begin a5 <= $signed(a5) + $signed(457); end
//     1D0 : sw a5 -16 (s0) 
'h000001D0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  for(i=0
//     1D4 : lw a2 -20 (s0) 
'h000001D4 : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     1D8 : lw t1 -24 (s0) 
'h000001D8 : begin if(!valid) begin addr = -24 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//     1DC : lw a4 -28 (s0) 
'h000001DC : begin if(!valid) begin addr = -28 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     1E0 : lw a5 0 (a2) 
'h000001E0 : begin if(!valid) begin addr = 0 + a2; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1E4 : blt a0 a5 204 <tinydec+#xa0> 
'h000001E4 : begin if($signed(a0) < $signed(a5)) pc <= 516; end
//    #ifdef SIM
//    printf("sum = %x\n", sum)
//    #endif
//  }
//  t->dat[0] = x
//     1E8 : sh a4 0 (t1) 
'h000001E8 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 1; size <= 1; wdata <= a4[15:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//  t->dat[1] = y
//     1EC : sh s1 2 (t1) 
'h000001EC : begin if(!valid) begin addr = $signed(2) + $signed(t1); valid <= 1; write <= 1; size <= 1; wdata <= s1[15:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//}
//     1F0 : lw ra 18 (sp) 
'h000001F0 : begin if(!valid) begin addr = 24 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     1F4 : lw s0 14 (sp) 
'h000001F4 : begin if(!valid) begin addr = 20 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     1F8 : lw s1 10 (sp) 
'h000001F8 : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     1FC : addi sp sp 1C 
'h000001FC : begin sp <= $signed(sp) + $signed(28); end
//     200 : ret 
'h00000200 : begin pc <= ra; end
//    y -= ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3])
//     204 : lw a1 8 (a2) 
'h00000204 : begin if(!valid) begin addr = 8 + a2; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//     208 : lhu a5 4 (a1) 
'h00000208 : begin if(!valid) begin addr = $signed(4) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{16{1'b0}},rdata_h}; end
//     20C : lhu t0 6 (a1) 
'h0000020C : begin if(!valid) begin addr = $signed(6) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t0 <= {{16{1'b0}},rdata_h}; end
//     210 : slli t2 a4 4 
'h00000210 : begin t2 <= $unsigned(a4) << 4; end
//     214 : add a5 t2 a5 
'h00000214 : begin a5 <= $signed(t2) + $signed(a5); end
//     218 : srli t2 a4 5 
'h00000218 : begin t2 <= $unsigned(a4) >> 5; end
//     21C : add t2 t2 t0 
'h0000021C : begin t2 <= $signed(t2) + $signed(t0); end
//     220 : xor a5 a5 t2 
'h00000220 : begin a5 <= $signed(a5) ^ $signed(t2); end
//     224 : add t0 a4 a3 
'h00000224 : begin t0 <= $signed(a4) + $signed(a3); end
//     228 : xor a5 a5 t0 
'h00000228 : begin a5 <= $signed(a5) ^ $signed(t0); end
//     22C : sub a5 s1 a5 
'h0000022C : begin a5 <= $signed(s1) - $signed(a5); end
//     230 : slli s1 a5 10 
'h00000230 : begin s1 <= $unsigned(a5) << 16; end
//     234 : srli s1 s1 10 
'h00000234 : begin s1 <= $unsigned(s1) >> 16; end
//    x -= ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1])
//     238 : lhu t2 0 (a1) 
'h00000238 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t2 <= {{16{1'b0}},rdata_h}; end
//     23C : lhu t0 2 (a1) 
'h0000023C : begin if(!valid) begin addr = $signed(2) + $signed(a1); valid <= 1; write <= 0; size <= 1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t0 <= {{16{1'b0}},rdata_h}; end
//     240 : slli a5 s1 4 
'h00000240 : begin a5 <= $unsigned(s1) << 4; end
//     244 : add a5 a5 t2 
'h00000244 : begin a5 <= $signed(a5) + $signed(t2); end
//     248 : srli a1 s1 5 
'h00000248 : begin a1 <= $unsigned(s1) >> 5; end
//     24C : add a1 a1 t0 
'h0000024C : begin a1 <= $signed(a1) + $signed(t0); end
//     250 : xor a5 a5 a1 
'h00000250 : begin a5 <= $signed(a5) ^ $signed(a1); end
//     254 : add a1 a3 s1 
'h00000254 : begin a1 <= $signed(a3) + $signed(s1); end
//     258 : xor a5 a5 a1 
'h00000258 : begin a5 <= $signed(a5) ^ $signed(a1); end
//     25C : sub a5 a4 a5 
'h0000025C : begin a5 <= $signed(a4) - $signed(a5); end
//     260 : slli a4 a5 10 
'h00000260 : begin a4 <= $unsigned(a5) << 16; end
//     264 : srli a4 a4 10 
'h00000264 : begin a4 <= $unsigned(a4) >> 16; end
//    sum -= DELTA
//     268 : lw a5 -16 (s0) 
'h00000268 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     26C : add a3 a3 a5 
'h0000026C : begin a3 <= $signed(a3) + $signed(a5); end
//     270 : slli a3 a3 10 
'h00000270 : begin a3 <= $unsigned(a3) << 16; end
//     274 : srli a3 a3 10 
'h00000274 : begin a3 <= $unsigned(a3) >> 16; end
//  for(i=0
//     278 : addi a0 a0 1 
'h00000278 : begin a0 <= $signed(a0) + $signed(1); end
//     27C : j 1E0 <tinydec+#x7c> 
'h0000027C : begin pc <= 480; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
