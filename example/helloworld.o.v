module helloworld (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a00, a30, a40, a10, a20, a50, s00, ra0, sp0);
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
input [31:0] s10, a00, a30, a40, a10, a20, a50, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
reg [31:0] zero, s1, a0, a3, a4, a1, a2, a5, s0, ra, sp;
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
      pc <= (pc0 > 'h278) ? 'h278 + 4 : pc0;
      s1 <= s10;
      a0 <= a00;
      a3 <= a30;
      a4 <= a40;
      a1 <= a10;
      a2 <= a20;
      a5 <= a50;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h278) ? 'h278 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/helloworld.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <memcpy>:
//extern char stdout
//extern char stdin
//#define stdout ((void*)&stdout)
//#define stdin ((void*)&stdin)
//
//void *memcpy(void *dest, const void *src, size_t n) {
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//    char *d = (char *)dest
//    const char *s = (const char *)src
//    while (n--) *d++ = *s++
//      10 : li a5 0 
'h00000010 : begin a5 <= 0; end
//      14 : bne a2 a5 28 <memcpy+#x28> 
'h00000014 : begin if($signed(a2) != $signed(a5)) pc <= 40; end
//    return dest
//}
//      18 : lw ra 4 (sp) 
'h00000018 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      1C : lw s0 0 (sp) 
'h0000001C : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      20 : addi sp sp 8 
'h00000020 : begin sp <= $signed(sp) + $signed(8); end
//      24 : ret 
'h00000024 : begin pc <= ra; end
//    while (n--) *d++ = *s++
//      28 : add a4 a1 a5 
'h00000028 : begin a4 <= $signed(a1) + $signed(a5); end
//      2C : lbu a3 0 (a4) 
'h0000002C : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{24{1'b0}},rdata_b}; end
//      30 : add a4 a0 a5 
'h00000030 : begin a4 <= $signed(a0) + $signed(a5); end
//      34 : sb a3 0 (a4) 
'h00000034 : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 1; size <= 0; wdata <= a3[7:0]<<(8*addr[1:0]); pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      38 : addi a5 a5 1 
'h00000038 : begin a5 <= $signed(a5) + $signed(1); end
//      3C : j 14 <memcpy+#x14> 
'h0000003C : begin pc <= 20; end
//
// 0x00000040 <memset>:
//
//void *memset(void *s, int c, size_t n) {
//      40 : addi sp sp -8 
'h00000040 : begin sp <= $signed(sp) + $signed(-8); end
//      44 : sw ra 4 (sp) 
'h00000044 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      48 : sw s0 0 (sp) 
'h00000048 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      4C : addi s0 sp 8 
'h0000004C : begin s0 <= $signed(sp) + $signed(8); end
//    unsigned char *p = (unsigned char *)s
//    while (n--) {
//      50 : add a2 a0 a2 
'h00000050 : begin a2 <= $signed(a0) + $signed(a2); end
//    unsigned char *p = (unsigned char *)s
//      54 : mv a5 a0 
'h00000054 : begin a5 <= a0; end
//    while (n--) {
//      58 : bne a5 a2 6C <memset+#x2c> 
'h00000058 : begin if($signed(a5) != $signed(a2)) pc <= 108; end
//        *p++ = (unsigned char)c
//    }
//    return s
//}
//      5C : lw ra 4 (sp) 
'h0000005C : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      60 : lw s0 0 (sp) 
'h00000060 : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      64 : addi sp sp 8 
'h00000064 : begin sp <= $signed(sp) + $signed(8); end
//      68 : ret 
'h00000068 : begin pc <= ra; end
//        *p++ = (unsigned char)c
//      6C : addi a5 a5 1 
'h0000006C : begin a5 <= $signed(a5) + $signed(1); end
//      70 : sb a1 -1 (a5) 
'h00000070 : begin if(!valid) begin addr = $signed(-1) + $signed(a5); valid <= 1; write <= 1; size <= 0; wdata <= a1[7:0]<<(8*addr[1:0]); pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      74 : j 58 <memset+#x18> 
'h00000074 : begin pc <= 88; end
//
// 0x00000078 <__mulsi3>:
//
//int __mulsi3(short a, short b) 
//{
//      78 : addi sp sp -8 
'h00000078 : begin sp <= $signed(sp) + $signed(-8); end
//      7C : sw ra 4 (sp) 
'h0000007C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      80 : sw s0 0 (sp) 
'h00000080 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      84 : addi s0 sp 8 
'h00000084 : begin s0 <= $signed(sp) + $signed(8); end
//      88 : mv a3 a0 
'h00000088 : begin a3 <= a0; end
//  int m = 0
//  unsigned short aa = (unsigned short)(short)a
//  unsigned short bb = (unsigned short)(short)b
//  if(aa & (1<<15)) aa = -aa
//      8C : srai a5 a0 F 
'h0000008C : begin a5 <= $signed(a0) >>> 15; end
//      90 : xor a4 a0 a5 
'h00000090 : begin a4 <= $signed(a0) ^ $signed(a5); end
//      94 : sub a4 a4 a5 
'h00000094 : begin a4 <= $signed(a4) - $signed(a5); end
//      98 : slli a4 a4 10 
'h00000098 : begin a4 <= $unsigned(a4) << 16; end
//      9C : srli a4 a4 10 
'h0000009C : begin a4 <= $unsigned(a4) >> 16; end
//  if(bb & (1<<15)) bb = -bb
//      A0 : srai a2 a1 F 
'h000000A0 : begin a2 <= $signed(a1) >>> 15; end
//      A4 : xor a5 a1 a2 
'h000000A4 : begin a5 <= $signed(a1) ^ $signed(a2); end
//      A8 : sub a5 a5 a2 
'h000000A8 : begin a5 <= $signed(a5) - $signed(a2); end
//      AC : slli a5 a5 10 
'h000000AC : begin a5 <= $unsigned(a5) << 16; end
//      B0 : srli a5 a5 10 
'h000000B0 : begin a5 <= $unsigned(a5) >> 16; end
//      B4 : li a0 0 
'h000000B4 : begin a0 <= 0; end
//  while(aa) {
//      B8 : bnez a4 D8 <__mulsi3+#x60> 
'h000000B8 : begin if($signed(a4) != 0) pc <= 216; end
//    if(aa & 1) m += bb
//     0xbb <<=1
//    aa >>=1
//  }
//  if((a<0)!=(b<0)) m = -m
//      BC : xor a3 a3 a1 
'h000000BC : begin a3 <= $signed(a3) ^ $signed(a1); end
//      C0 : bgez a3 C8 <__mulsi3+#x50> 
'h000000C0 : begin if($signed(a3) >= 0) pc <= 200; end
//      C4 : neg a0 a0 
'h000000C4 : begin a0 <= 0-a0; end
//  return m
//}
//      C8 : lw ra 4 (sp) 
'h000000C8 : begin if(!valid) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      CC : lw s0 0 (sp) 
'h000000CC : begin if(!valid) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      D0 : addi sp sp 8 
'h000000D0 : begin sp <= $signed(sp) + $signed(8); end
//      D4 : ret 
'h000000D4 : begin pc <= ra; end
//    if(aa & 1) m += bb
//      D8 : andi a2 a4 1 
'h000000D8 : begin a2 <= $signed(a4) & $signed(1); end
//      DC : beqz a2 E4 <__mulsi3+#x6c> 
'h000000DC : begin if($signed(a2) == 0) pc <= 228; end
//      E0 : add a0 a0 a5 
'h000000E0 : begin a0 <= $signed(a0) + $signed(a5); end
//     0xbb <<=1
//      E4 : slli a5 a5 1 
'h000000E4 : begin a5 <= $unsigned(a5) << 1; end
//      E8 : slli a5 a5 10 
'h000000E8 : begin a5 <= $unsigned(a5) << 16; end
//      EC : srli a5 a5 10 
'h000000EC : begin a5 <= $unsigned(a5) >> 16; end
//    aa >>=1
//      F0 : srli a4 a4 1 
'h000000F0 : begin a4 <= $unsigned(a4) >> 1; end
//      F4 : j B8 <__mulsi3+#x40> 
'h000000F4 : begin pc <= 184; end
//
// 0x000000f8 <fwrite>:
//    int r
//    swdiv(a, b, 0, &r)
//    return r
//}
//
//size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
//      F8 : addi sp sp -20 
'h000000F8 : begin sp <= $signed(sp) + $signed(-20); end
//      FC : sw ra 10 (sp) 
'h000000FC : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     100 : sw s0 C (sp) 
'h00000100 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     104 : sw s1 8 (sp) 
'h00000104 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     108 : addi s0 sp 14 
'h00000108 : begin s0 <= $signed(sp) + $signed(20); end
//     10C : mv s1 a0 
'h0000010C : begin s1 <= a0; end
//     110 : mv a0 a1 
'h00000110 : begin a0 <= a1; end
//     114 : mv a1 a2 
'h00000114 : begin a1 <= a2; end
//     118 : sw a3 -20 (s0) 
'h00000118 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    const char *data = (const char *)ptr
//    volatile char *port = (volatile char *)stream
//    size_t total = size * nmemb
//     11C : sw a2 -16 (s0) 
'h0000011C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     120 : auipc ra 0 
'h00000120 : begin ra <= pc + (0 << 12); end
//     124 : jalr -168 (ra) # 78 <__mulsi3> 
'h00000124 : begin pc <= $signed(-168) + $signed(ra); ra <= pc + 4; end
//    for (size_t i = 0
//     128 : li a5 0 
'h00000128 : begin a5 <= 0; end
//     12C : lw a1 -16 (s0) 
'h0000012C : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//     130 : lw a3 -20 (s0) 
'h00000130 : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     134 : bne a5 a0 150 <fwrite+#x58> 
'h00000134 : begin if($signed(a5) != $signed(a0)) pc <= 336; end
//        *port = data[i]
//    }
//    return nmemb
//}
//     138 : mv a0 a1 
'h00000138 : begin a0 <= a1; end
//     13C : lw ra 10 (sp) 
'h0000013C : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     140 : lw s0 C (sp) 
'h00000140 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     144 : lw s1 8 (sp) 
'h00000144 : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     148 : addi sp sp 14 
'h00000148 : begin sp <= $signed(sp) + $signed(20); end
//     14C : ret 
'h0000014C : begin pc <= ra; end
//        *port = data[i]
//     150 : add a2 s1 a5 
'h00000150 : begin a2 <= $signed(s1) + $signed(a5); end
//     154 : lbu a2 0 (a2) 
'h00000154 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     158 : sb a2 0 (a3) 
'h00000158 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 0; wdata <= a2[7:0]<<(8*addr[1:0]); pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (size_t i = 0
//     15C : addi a5 a5 1 
'h0000015C : begin a5 <= $signed(a5) + $signed(1); end
//     160 : j 134 <fwrite+#x3c> 
'h00000160 : begin pc <= 308; end
//
// 0x00000164 <fread>:
//
//size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
//     164 : addi sp sp -20 
'h00000164 : begin sp <= $signed(sp) + $signed(-20); end
//     168 : sw ra 10 (sp) 
'h00000168 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     16C : sw s0 C (sp) 
'h0000016C : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     170 : sw s1 8 (sp) 
'h00000170 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     174 : addi s0 sp 14 
'h00000174 : begin s0 <= $signed(sp) + $signed(20); end
//     178 : mv s1 a0 
'h00000178 : begin s1 <= a0; end
//     17C : mv a0 a1 
'h0000017C : begin a0 <= a1; end
//     180 : sw a2 -16 (s0) 
'h00000180 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     184 : sw a3 -20 (s0) 
'h00000184 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    char *data = (char *)ptr
//    volatile char *port = (volatile char *)stream
//    size_t total = size * nmemb
//     188 : mv a1 a2 
'h00000188 : begin a1 <= a2; end
//     18C : auipc ra 0 
'h0000018C : begin ra <= pc + (0 << 12); end
//     190 : jalr -276 (ra) # 78 <__mulsi3> 
'h00000190 : begin pc <= $signed(-276) + $signed(ra); ra <= pc + 4; end
//    for (size_t i = 0
//     194 : li a5 0 
'h00000194 : begin a5 <= 0; end
//     198 : lw a3 -20 (s0) 
'h00000198 : begin if(!valid) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     19C : bne a5 a0 1B8 <fread+#x54> 
'h0000019C : begin if($signed(a5) != $signed(a0)) pc <= 440; end
//        data[i] = *port
//    }
//    return nmemb
//}
//     1A0 : lw a0 -16 (s0) 
'h000001A0 : begin if(!valid) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     1A4 : lw ra 10 (sp) 
'h000001A4 : begin if(!valid) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     1A8 : lw s0 C (sp) 
'h000001A8 : begin if(!valid) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     1AC : lw s1 8 (sp) 
'h000001AC : begin if(!valid) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     1B0 : addi sp sp 14 
'h000001B0 : begin sp <= $signed(sp) + $signed(20); end
//     1B4 : ret 
'h000001B4 : begin pc <= ra; end
//        data[i] = *port
//     1B8 : lbu a1 0 (a3) 
'h000001B8 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= {{24{1'b0}},rdata_b}; end
//     1BC : add a2 s1 a5 
'h000001BC : begin a2 <= $signed(s1) + $signed(a5); end
//     1C0 : sb a1 0 (a2) 
'h000001C0 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 1; size <= 0; wdata <= a1[7:0]<<(8*addr[1:0]); pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (size_t i = 0
//     1C4 : addi a5 a5 1 
'h000001C4 : begin a5 <= $signed(a5) + $signed(1); end
//     1C8 : j 19C <fread+#x38> 
'h000001C8 : begin pc <= 412; end
//
// 0x000001cc <main>:
//#else
//#include "stdio.h"
//#endif
//
//int main()
//{
//     1CC : addi sp sp -64 
'h000001CC : begin sp <= $signed(sp) + $signed(-64); end
//     1D0 : sw ra 3C (sp) 
'h000001D0 : begin if(!valid) begin addr = $signed(60) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1D4 : sw s0 38 (sp) 
'h000001D4 : begin if(!valid) begin addr = $signed(56) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1D8 : sw s1 34 (sp) 
'h000001D8 : begin if(!valid) begin addr = $signed(52) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1DC : addi s0 sp 40 
'h000001DC : begin s0 <= $signed(sp) + $signed(64); end
//  char a[50] = "helloworld! echo 50 chars\n> "
//     1E0 : li a2 1D 
'h000001E0 : begin a2 <= 29; end
//     1E4 : auipc a1 1 
'h000001E4 : begin a1 <= pc + (1 << 12); end
//     1E8 : addi a1 a1 -484 # 1000 <main+#xe34> 
'h000001E8 : begin a1 <= $signed(a1) + $signed(-484); end
//     1EC : addi s1 s0 -64 
'h000001EC : begin s1 <= $signed(s0) + $signed(-64); end
//     1F0 : mv a0 s1 
'h000001F0 : begin a0 <= s1; end
//     1F4 : auipc ra 0 
'h000001F4 : begin ra <= pc + (0 << 12); end
//     1F8 : jalr -500 (ra) # 0 <memcpy> 
'h000001F8 : begin pc <= $signed(-500) + $signed(ra); ra <= pc + 4; end
//     1FC : li a2 15 
'h000001FC : begin a2 <= 21; end
//     200 : li a1 0 
'h00000200 : begin a1 <= 0; end
//     204 : addi a0 s0 -35 
'h00000204 : begin a0 <= $signed(s0) + $signed(-35); end
//     208 : auipc ra 0 
'h00000208 : begin ra <= pc + (0 << 12); end
//     20C : jalr -456 (ra) # 40 <memset> 
'h0000020C : begin pc <= $signed(-456) + $signed(ra); ra <= pc + 4; end
//  fwrite(a, 1, sizeof(a), stdout)
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
//     228 : jalr -300 (ra) # F8 <fwrite> 
'h00000228 : begin pc <= $signed(-300) + $signed(ra); ra <= pc + 4; end
//  fread(a, 1, 50, stdin)
//     22C : auipc a3 1 
'h0000022C : begin a3 <= pc + (1 << 12); end
//     230 : lw a3 -496 (a3) # 103C <_GLOBAL_OFFSET_TABLE_+#x8> 
'h00000230 : begin if(!valid) begin addr = -496 + a3; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     234 : li a2 32 
'h00000234 : begin a2 <= 50; end
//     238 : li a1 1 
'h00000238 : begin a1 <= 1; end
//     23C : mv a0 s1 
'h0000023C : begin a0 <= s1; end
//     240 : auipc ra 0 
'h00000240 : begin ra <= pc + (0 << 12); end
//     244 : jalr -220 (ra) # 164 <fread> 
'h00000244 : begin pc <= $signed(-220) + $signed(ra); ra <= pc + 4; end
//  fwrite(a, 1, sizeof(a), stdout)
//     248 : auipc a3 1 
'h00000248 : begin a3 <= pc + (1 << 12); end
//     24C : lw a3 -528 (a3) # 1038 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h0000024C : begin if(!valid) begin addr = -528 + a3; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     250 : li a2 32 
'h00000250 : begin a2 <= 50; end
//     254 : li a1 1 
'h00000254 : begin a1 <= 1; end
//     258 : mv a0 s1 
'h00000258 : begin a0 <= s1; end
//     25C : auipc ra 0 
'h0000025C : begin ra <= pc + (0 << 12); end
//     260 : jalr -356 (ra) # F8 <fwrite> 
'h00000260 : begin pc <= $signed(-356) + $signed(ra); ra <= pc + 4; end
//  return 0
//}
//     264 : li a0 0 
'h00000264 : begin a0 <= 0; end
//     268 : lw ra 3C (sp) 
'h00000268 : begin if(!valid) begin addr = 60 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     26C : lw s0 38 (sp) 
'h0000026C : begin if(!valid) begin addr = 56 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     270 : lw s1 34 (sp) 
'h00000270 : begin if(!valid) begin addr = 52 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     274 : addi sp sp 40 
'h00000274 : begin sp <= $signed(sp) + $signed(64); end
//     278 : ret 
'h00000278 : begin pc <= ra; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
