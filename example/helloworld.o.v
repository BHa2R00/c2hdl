module helloworld (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0);
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
input [31:0] s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata;
wire [15:0] rdata_h = rdata;
wire [ 7:0] rdata_b = rdata;
reg [31:0] zero, s1, a2, a1, a4, a5, a3, a0, s0, ra, sp;
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
      pc <= (pc0 > 'h22C) ? 'h22C + 4 : pc0;
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
      pc <= (pc > 'h22C) ? 'h22C + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/helloworld.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <__mulsi3>:
//extern char stdin
//#define stdout ((void*)&stdout)
//#define stdin ((void*)&stdin)
//
//int __mulsi3(short a, short b) 
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
//      40 : bnez a4 60 <__mulsi3+#x60> 
'h00000040 : begin if($signed(a4) != 0) pc <= 96; end
//    if(aa & 1) m += bb
//     0xbb <<=1
//    aa >>=1
//  }
//  if((a<0)!=(b<0)) m = -m
//      44 : xor a3 a3 a1 
'h00000044 : begin a3 <= $signed(a3) ^ $signed(a1); end
//      48 : bgez a3 50 <__mulsi3+#x50> 
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
//      64 : beqz a2 6C <__mulsi3+#x6c> 
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
//      7C : j 40 <__mulsi3+#x40> 
'h0000007C : begin pc <= 64; end
//
// 0x00000080 <fwrite>:
//    int r
//    swdiv(a, b, 0, &r)
//    return r
//}
//
//size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
//      80 : addi sp sp -20 
'h00000080 : begin sp <= $signed(sp) + $signed(-20); end
//      84 : sw ra 10 (sp) 
'h00000084 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      88 : sw s0 C (sp) 
'h00000088 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      8C : sw s1 8 (sp) 
'h0000008C : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      90 : addi s0 sp 14 
'h00000090 : begin s0 <= $signed(sp) + $signed(20); end
//      94 : mv s1 a0 
'h00000094 : begin s1 <= a0; end
//      98 : mv a0 a1 
'h00000098 : begin a0 <= a1; end
//      9C : mv a1 a2 
'h0000009C : begin a1 <= a2; end
//      A0 : sw a3 -20 (s0) 
'h000000A0 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    const char *data = (const char *)ptr
//    volatile char *port = (volatile char *)stream
//    size_t total = size * nmemb
//      A4 : sw a2 -16 (s0) 
'h000000A4 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      A8 : auipc ra 0 
'h000000A8 : begin ra <= pc + (0 << 12); end
//      AC : jalr -168 (ra) # 0 <__mulsi3> 
'h000000AC : begin pc <= $signed(-168) + $signed(ra); ra <= pc + 4; end
//    for (size_t i = 0
//      B0 : li a5 0 
'h000000B0 : begin a5 <= 0; end
//      B4 : lw a1 -16 (s0) 
'h000000B4 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//      B8 : lw a3 -20 (s0) 
'h000000B8 : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//      BC : bne a5 a0 D8 <fwrite+#x58> 
'h000000BC : begin if($signed(a5) != $signed(a0)) pc <= 216; end
//        *port = data[i]
//    }
//    return nmemb
//}
//      C0 : mv a0 a1 
'h000000C0 : begin a0 <= a1; end
//      C4 : lw ra 10 (sp) 
'h000000C4 : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      C8 : lw s0 C (sp) 
'h000000C8 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      CC : lw s1 8 (sp) 
'h000000CC : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//      D0 : addi sp sp 14 
'h000000D0 : begin sp <= $signed(sp) + $signed(20); end
//      D4 : ret 
'h000000D4 : begin pc <= ra; end
//        *port = data[i]
//      D8 : add a2 s1 a5 
'h000000D8 : begin a2 <= $signed(s1) + $signed(a5); end
//      DC : lbu a2 0 (a2) 
'h000000DC : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//      E0 : sb a2 0 (a3) 
'h000000E0 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 0; wdata <= a2[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (size_t i = 0
//      E4 : addi a5 a5 1 
'h000000E4 : begin a5 <= $signed(a5) + $signed(1); end
//      E8 : j BC <fwrite+#x3c> 
'h000000E8 : begin pc <= 188; end
//
// 0x000000ec <fread>:
//
//size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
//      EC : addi sp sp -20 
'h000000EC : begin sp <= $signed(sp) + $signed(-20); end
//      F0 : sw ra 10 (sp) 
'h000000F0 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      F4 : sw s0 C (sp) 
'h000000F4 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      F8 : sw s1 8 (sp) 
'h000000F8 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      FC : addi s0 sp 14 
'h000000FC : begin s0 <= $signed(sp) + $signed(20); end
//     100 : mv s1 a0 
'h00000100 : begin s1 <= a0; end
//     104 : mv a0 a1 
'h00000104 : begin a0 <= a1; end
//     108 : sw a2 -16 (s0) 
'h00000108 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     10C : sw a3 -20 (s0) 
'h0000010C : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    char *data = (char *)ptr
//    volatile char *port = (volatile char *)stream
//    size_t total = size * nmemb
//     110 : mv a1 a2 
'h00000110 : begin a1 <= a2; end
//     114 : auipc ra 0 
'h00000114 : begin ra <= pc + (0 << 12); end
//     118 : jalr -276 (ra) # 0 <__mulsi3> 
'h00000118 : begin pc <= $signed(-276) + $signed(ra); ra <= pc + 4; end
//    for (size_t i = 0
//     11C : li a5 0 
'h0000011C : begin a5 <= 0; end
//     120 : lw a3 -20 (s0) 
'h00000120 : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     124 : bne a5 a0 140 <fread+#x54> 
'h00000124 : begin if($signed(a5) != $signed(a0)) pc <= 320; end
//        data[i] = *port
//    }
//    return nmemb
//}
//     128 : lw a0 -16 (s0) 
'h00000128 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     12C : lw ra 10 (sp) 
'h0000012C : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     130 : lw s0 C (sp) 
'h00000130 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     134 : lw s1 8 (sp) 
'h00000134 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     138 : addi sp sp 14 
'h00000138 : begin sp <= $signed(sp) + $signed(20); end
//     13C : ret 
'h0000013C : begin pc <= ra; end
//        data[i] = *port
//     140 : lbu a1 0 (a3) 
'h00000140 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= {{24{1'b0}},rdata_b}; end
//     144 : add a2 s1 a5 
'h00000144 : begin a2 <= $signed(s1) + $signed(a5); end
//     148 : sb a1 0 (a2) 
'h00000148 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 1; size <= 0; wdata <= a1[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (size_t i = 0
//     14C : addi a5 a5 1 
'h0000014C : begin a5 <= $signed(a5) + $signed(1); end
//     150 : j 124 <fread+#x38> 
'h00000150 : begin pc <= 292; end
//
// 0x00000154 <memcpy>:
//
//void *memcpy(void *dest, const void *src, size_t n) {
//     154 : addi sp sp -8 
'h00000154 : begin sp <= $signed(sp) + $signed(-8); end
//     158 : sw ra 4 (sp) 
'h00000158 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     15C : sw s0 0 (sp) 
'h0000015C : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     160 : addi s0 sp 8 
'h00000160 : begin s0 <= $signed(sp) + $signed(8); end
//    char *d = (char *)dest
//    const char *s = (const char *)src
//    while (n--) *d++ = *s++
//     164 : li a5 0 
'h00000164 : begin a5 <= 0; end
//     168 : bne a2 a5 17C <memcpy+#x28> 
'h00000168 : begin if($signed(a2) != $signed(a5)) pc <= 380; end
//    return dest
//}
//     16C : lw ra 4 (sp) 
'h0000016C : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     170 : lw s0 0 (sp) 
'h00000170 : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     174 : addi sp sp 8 
'h00000174 : begin sp <= $signed(sp) + $signed(8); end
//     178 : ret 
'h00000178 : begin pc <= ra; end
//    while (n--) *d++ = *s++
//     17C : add a4 a1 a5 
'h0000017C : begin a4 <= $signed(a1) + $signed(a5); end
//     180 : lbu a3 0 (a4) 
'h00000180 : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{24{1'b0}},rdata_b}; end
//     184 : add a4 a0 a5 
'h00000184 : begin a4 <= $signed(a0) + $signed(a5); end
//     188 : sb a3 0 (a4) 
'h00000188 : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 1; size <= 0; wdata <= a3[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     18C : addi a5 a5 1 
'h0000018C : begin a5 <= $signed(a5) + $signed(1); end
//     190 : j 168 <memcpy+#x14> 
'h00000190 : begin pc <= 360; end
//
// 0x00000194 <main>:
//#include "stdio.h"
//#include "string.h"
//#endif
//
//int main()
//{
//     194 : addi sp sp -64 
'h00000194 : begin sp <= $signed(sp) + $signed(-64); end
//     198 : sw ra 3C (sp) 
'h00000198 : begin if(!valid) begin addr = $signed(60) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     19C : sw s0 38 (sp) 
'h0000019C : begin if(!valid) begin addr = $signed(56) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1A0 : sw s1 34 (sp) 
'h000001A0 : begin if(!valid) begin addr = $signed(52) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1A4 : addi s0 sp 40 
'h000001A4 : begin s0 <= $signed(sp) + $signed(64); end
//  while(1) {
//    char a[50] = "\n\rhelloworld! echo 50 chars\n\r> "
//     1A8 : li a2 20 
'h000001A8 : begin a2 <= 32; end
//     1AC : auipc a1 1 
'h000001AC : begin a1 <= pc + (1 << 12); end
//     1B0 : addi a1 a1 -428 # 1000 <main+#xe6c> 
'h000001B0 : begin a1 <= $signed(a1) + $signed(-428); end
//     1B4 : addi s1 s0 -64 
'h000001B4 : begin s1 <= $signed(s0) + $signed(-64); end
//     1B8 : mv a0 s1 
'h000001B8 : begin a0 <= s1; end
//     1BC : auipc ra 0 
'h000001BC : begin ra <= pc + (0 << 12); end
//     1C0 : jalr -104 (ra) # 154 <memcpy> 
'h000001C0 : begin pc <= $signed(-104) + $signed(ra); ra <= pc + 4; end
//     1C4 : sw zero -32 (s0) 
'h000001C4 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1C8 : sw zero -28 (s0) 
'h000001C8 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1CC : sw zero -24 (s0) 
'h000001CC : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1D0 : sw zero -20 (s0) 
'h000001D0 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1D4 : sh zero -16 (s0) 
'h000001D4 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 1; wdata <= zero[15:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    fwrite(a, 1, sizeof(a), stdout)
//     1D8 : auipc a3 1 
'h000001D8 : begin a3 <= pc + (1 << 12); end
//     1DC : lw a3 -416 (a3) # 1038 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h000001DC : begin if(!valid) begin addr = -416 + a3; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     1E0 : li a2 32 
'h000001E0 : begin a2 <= 50; end
//     1E4 : li a1 1 
'h000001E4 : begin a1 <= 1; end
//     1E8 : mv a0 s1 
'h000001E8 : begin a0 <= s1; end
//     1EC : auipc ra 0 
'h000001EC : begin ra <= pc + (0 << 12); end
//     1F0 : jalr -364 (ra) # 80 <fwrite> 
'h000001F0 : begin pc <= $signed(-364) + $signed(ra); ra <= pc + 4; end
//    fread(a, 1, 50, stdin)
//     1F4 : auipc a3 1 
'h000001F4 : begin a3 <= pc + (1 << 12); end
//     1F8 : lw a3 -440 (a3) # 103C <_GLOBAL_OFFSET_TABLE_+#x8> 
'h000001F8 : begin if(!valid) begin addr = -440 + a3; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     1FC : li a2 32 
'h000001FC : begin a2 <= 50; end
//     200 : li a1 1 
'h00000200 : begin a1 <= 1; end
//     204 : mv a0 s1 
'h00000204 : begin a0 <= s1; end
//     208 : auipc ra 0 
'h00000208 : begin ra <= pc + (0 << 12); end
//     20C : jalr -284 (ra) # EC <fread> 
'h0000020C : begin pc <= $signed(-284) + $signed(ra); ra <= pc + 4; end
//    fwrite(a, 1, sizeof(a), stdout)
//     210 : auipc a3 1 
'h00000210 : begin a3 <= pc + (1 << 12); end
//     214 : lw a3 -472 (a3) # 1038 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000214 : begin if(!valid) begin addr = -472 + a3; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     218 : li a2 32 
'h00000218 : begin a2 <= 50; end
//     21C : li a1 1 
'h0000021C : begin a1 <= 1; end
//     220 : mv a0 s1 
'h00000220 : begin a0 <= s1; end
//     224 : auipc ra 0 
'h00000224 : begin ra <= pc + (0 << 12); end
//     228 : jalr -420 (ra) # 80 <fwrite> 
'h00000228 : begin pc <= $signed(-420) + $signed(ra); ra <= pc + 4; end
//  while(1) {
//     22C : j 1A8 <main+#x14> 
'h0000022C : begin pc <= 424; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
