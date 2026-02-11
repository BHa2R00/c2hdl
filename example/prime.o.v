module prime (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, t00, t20, s10, a20, t10, a50, a40, a10, a30, a00, s00, ra0, sp0);
input clk, rstb;
input setb;
output reg idle;
output reg [10:0] pc;
input [10:0] pc0;
output reg [31:0] addr;
output reg [2:0] size;
output reg valid, write;
output reg [31:0] wdata;
input [31:0] rdata;
input ready;
input [31:0] t00, t20, s10, a20, t10, a50, a40, a10, a30, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata;
wire [15:0] rdata_h = rdata;
wire [ 7:0] rdata_b = rdata;
reg [31:0] zero, t0, t2, s1, a2, t1, a5, a4, a1, a3, a0, s0, ra, sp;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    zero <= 32'd0;
    idle <= 1;
    valid <= 0;
    write <= 0;
    size <= 0;
    addr = 0;
  end
  else begin
    zero <= 32'd0;
    if(!setb) begin
      pc <= (pc0 > 'h744) ? 'h744 + 4 : pc0;
      t0 <= t00;
      t2 <= t20;
      s1 <= s10;
      a2 <= a20;
      t1 <= t10;
      a5 <= a50;
      a4 <= a40;
      a1 <= a10;
      a3 <= a30;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h744) ? 'h744 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/prime.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <__udivsi3_umodsi3>:
//        u_b >>= 1
//    }
//    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res
//}
//
//static unsigned int __udivsi3_umodsi3(unsigned int n, unsigned int d, unsigned int *mod) {
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
//      14 : mv a0 a1 
'h00000014 : begin a0 <= a1; end
//    if (d == 0) return 0
//      18 : beqz a1 5C <__udivsi3_umodsi3+#x5c> 
'h00000018 : begin if($signed(a1) == 0) pc <= 92; end
//      1C : li a1 20 
'h0000001C : begin a1 <= 32; end
//    unsigned int q = 0
//      20 : li a4 0 
'h00000020 : begin a4 <= 0; end
//    unsigned int r = 0
//      24 : li a5 0 
'h00000024 : begin a5 <= 0; end
//    for (int i = 0
//        r = (r << 1) | (n >> 31)
//      28 : slli a5 a5 1 
'h00000028 : begin a5 <= $unsigned(a5) << 1; end
//      2C : srli t1 a3 1F 
'h0000002C : begin t1 <= $unsigned(a3) >> 31; end
//      30 : or a5 t1 a5 
'h00000030 : begin a5 <= $unsigned(t1) | $unsigned(a5); end
//        n <<= 1
//      34 : slli a3 a3 1 
'h00000034 : begin a3 <= $unsigned(a3) << 1; end
//        if (r >= d) {
//            r -= d
//            q = (q << 1) | 1
//      38 : slli a4 a4 1 
'h00000038 : begin a4 <= $unsigned(a4) << 1; end
//        if (r >= d) {
//      3C : bltu a5 a0 48 <__udivsi3_umodsi3+#x48> 
'h0000003C : begin if($unsigned(a5) < $unsigned(a0)) pc <= 72; end
//            r -= d
//      40 : sub a5 a5 a0 
'h00000040 : begin a5 <= $unsigned(a5) - $unsigned(a0); end
//            q = (q << 1) | 1
//      44 : ori a4 a4 1 
'h00000044 : begin a4 <= $signed(a4) | $signed(1); end
//    for (int i = 0
//      48 : addi a1 a1 -1 
'h00000048 : begin a1 <= $signed(a1) + $signed(-1); end
//      4C : bnez a1 28 <__udivsi3_umodsi3+#x28> 
'h0000004C : begin if($signed(a1) != 0) pc <= 40; end
//        } else {
//            q <<= 1
//        }
//    }
//    if (mod) *mod = r
//      50 : beqz a2 58 <__udivsi3_umodsi3+#x58> 
'h00000050 : begin if($signed(a2) == 0) pc <= 88; end
//      54 : sw a5 0 (a2) 
'h00000054 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    unsigned int r = 0
//      58 : mv a0 a4 
'h00000058 : begin a0 <= a4; end
//    return q
//}
//      5C : lw ra 4 (sp) 
'h0000005C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      60 : lw s0 0 (sp) 
'h00000060 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      64 : addi sp sp 8 
'h00000064 : begin sp <= $signed(sp) + $signed(8); end
//      68 : ret 
'h00000068 : begin pc <= ra; end
//
// 0x0000006c <_fmt_base>:
//    return (int)(*(volatile unsigned int *)lfsr)
//}
//
//// printf scanf
//
//static void _fmt_base(void *stream, unsigned int uval, int base, int *count) {
//      6C : addi sp sp -40 
'h0000006C : begin sp <= $signed(sp) + $signed(-40); end
//      70 : sw ra 24 (sp) 
'h00000070 : begin if(!valid) begin addr = $signed(36) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      74 : sw s0 20 (sp) 
'h00000074 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      78 : sw s1 1C (sp) 
'h00000078 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      7C : addi s0 sp 28 
'h0000007C : begin s0 <= $signed(sp) + $signed(40); end
//      80 : mv s1 a0 
'h00000080 : begin s1 <= a0; end
//      84 : mv a0 a1 
'h00000084 : begin a0 <= a1; end
//      88 : sw a2 -32 (s0) 
'h00000088 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    char tmp[12]
//    int i = 11
//    tmp[i] = '\0'
//      8C : sb zero -13 (s0) 
'h0000008C : begin if(!valid) begin addr = $signed(-13) + $signed(s0); valid <= 1; write <= 1; size <= 0; wdata <= zero[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    int i = 11
//      90 : li t1 B 
'h00000090 : begin t1 <= 11; end
//      94 : sw a3 -40 (s0) 
'h00000094 : begin if(!valid) begin addr = $signed(-40) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      98 : sw t1 -36 (s0) 
'h00000098 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    
//    do {
//        unsigned int rem
//        // Reuses your Booth-style or hardware divider logic
//        uval = __udivsi3_umodsi3(uval, base, &rem)
//      9C : addi a2 s0 -28 
'h0000009C : begin a2 <= $signed(s0) + $signed(-28); end
//      A0 : lw a1 -32 (s0) 
'h000000A0 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//      A4 : auipc ra 0 
'h000000A4 : begin ra <= pc + (0 << 12); end
//      A8 : jalr -164 (ra) # 0 <__udivsi3_umodsi3> 
'h000000A8 : begin pc <= $signed(-164) + $signed(ra); ra <= pc + 4; end
//        tmp[--i] = (rem < 10) ? (char)(rem + '0') : (char)(rem - 10 + 'a')
//      AC : lw a2 -28 (s0) 
'h000000AC : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//      B0 : zext.b a5 a2 
'h000000B0 : begin a5 <= 32'hff & a2; end
//      B4 : li a1 9 
'h000000B4 : begin a1 <= 9; end
//      B8 : lw t1 -36 (s0) 
'h000000B8 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//      BC : lw a3 -40 (s0) 
'h000000BC : begin if(!valid) begin addr = $signed(-40) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//      C0 : bltu a1 a2 FC <_fmt_base+#x90> 
'h000000C0 : begin if($unsigned(a1) < $unsigned(a2)) pc <= 252; end
//      C4 : addi a5 a5 30 
'h000000C4 : begin a5 <= $signed(a5) + $signed(48); end
//      C8 : zext.b a5 a5 
'h000000C8 : begin a5 <= 32'hff & a5; end
//      CC : addi t1 t1 -1 
'h000000CC : begin t1 <= $signed(t1) + $signed(-1); end
//      D0 : addi a2 s0 -24 
'h000000D0 : begin a2 <= $signed(s0) + $signed(-24); end
//      D4 : add a2 a2 t1 
'h000000D4 : begin a2 <= $unsigned(a2) + $unsigned(t1); end
//      D8 : sb a5 0 (a2) 
'h000000D8 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 1; size <= 0; wdata <= a5[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    } while (uval > 0)
//      DC : bnez a0 94 <_fmt_base+#x28> 
'h000000DC : begin if($signed(a0) != 0) pc <= 148; end
//
//    char *p = &tmp[i]
//    while (*p) { 
//      E0 : lbu a5 0 (a2) 
'h000000E0 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//      E4 : bnez a5 104 <_fmt_base+#x98> 
'h000000E4 : begin if($signed(a5) != 0) pc <= 260; end
//        fputc(*p++, stream)
//        (*count)++
//    }
//}
//      E8 : lw ra 24 (sp) 
'h000000E8 : begin if(!valid) begin addr = $signed(36) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      EC : lw s0 20 (sp) 
'h000000EC : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      F0 : lw s1 1C (sp) 
'h000000F0 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//      F4 : addi sp sp 28 
'h000000F4 : begin sp <= $signed(sp) + $signed(40); end
//      F8 : ret 
'h000000F8 : begin pc <= ra; end
//        tmp[--i] = (rem < 10) ? (char)(rem + '0') : (char)(rem - 10 + 'a')
//      FC : addi a5 a5 57 
'h000000FC : begin a5 <= $signed(a5) + $signed(87); end
//     100 : j C8 <_fmt_base+#x5c> 
'h00000100 : begin pc <= 200; end
//        fputc(*p++, stream)
//     104 : addi a2 a2 1 
'h00000104 : begin a2 <= $signed(a2) + $signed(1); end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     108 : sw a5 0 (s1) 
'h00000108 : begin if(!valid) begin addr = $signed(0) + $signed(s1); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        (*count)++
//     10C : lw a5 0 (a3) 
'h0000010C : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     110 : addi a5 a5 1 
'h00000110 : begin a5 <= $signed(a5) + $signed(1); end
//     114 : sw a5 0 (a3) 
'h00000114 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     118 : j E0 <_fmt_base+#x74> 
'h00000118 : begin pc <= 224; end
//
// 0x0000011c <__mulsi3>:
//int __mulsi3(int a, int b) {
//     11C : addi sp sp -8 
'h0000011C : begin sp <= $signed(sp) + $signed(-8); end
//     120 : sw ra 4 (sp) 
'h00000120 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     124 : sw s0 0 (sp) 
'h00000124 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     128 : addi s0 sp 8 
'h00000128 : begin s0 <= $signed(sp) + $signed(8); end
//     12C : mv a5 a0 
'h0000012C : begin a5 <= a0; end
//    unsigned int u_a = ( 0xa < 0) ? -a : a
//     130 : srai a4 a0 1F 
'h00000130 : begin a4 <= $signed(a0) >>> 31; end
//     134 : xor a3 a4 a0 
'h00000134 : begin a3 <= $unsigned(a4) ^ $unsigned(a0); end
//     138 : sub a3 a3 a4 
'h00000138 : begin a3 <= $unsigned(a3) - $unsigned(a4); end
//    unsigned int u_b = ( 0xb < 0) ? -b : b
//     13C : srai a2 a1 1F 
'h0000013C : begin a2 <= $signed(a1) >>> 31; end
//     140 : xor a4 a2 a1 
'h00000140 : begin a4 <= $unsigned(a2) ^ $unsigned(a1); end
//     144 : sub a4 a4 a2 
'h00000144 : begin a4 <= $unsigned(a4) - $unsigned(a2); end
//    int res = 0
//     148 : li a0 0 
'h00000148 : begin a0 <= 0; end
//    while (u_b > 0) {
//     14C : bnez a4 16C <__mulsi3+#x50> 
'h0000014C : begin if($signed(a4) != 0) pc <= 364; end
//    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res
//     150 : xor a5 a5 a1 
'h00000150 : begin a5 <= $unsigned(a5) ^ $unsigned(a1); end
//     154 : bgez a5 15C <__mulsi3+#x40> 
'h00000154 : begin if($signed(a5) >= 0) pc <= 348; end
//     158 : neg a0 a0 
'h00000158 : begin a0 <= 0-a0; end
//}
//     15C : lw ra 4 (sp) 
'h0000015C : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     160 : lw s0 0 (sp) 
'h00000160 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     164 : addi sp sp 8 
'h00000164 : begin sp <= $signed(sp) + $signed(8); end
//     168 : ret 
'h00000168 : begin pc <= ra; end
//        if (u_b & 1) res += u_a
//     16C : andi a2 a4 1 
'h0000016C : begin a2 <= $signed(a4) & $signed(1); end
//     170 : beqz a2 178 <__mulsi3+#x5c> 
'h00000170 : begin if($signed(a2) == 0) pc <= 376; end
//     174 : add a0 a0 a3 
'h00000174 : begin a0 <= $unsigned(a0) + $unsigned(a3); end
//        u_ 0xa <<= 1
//     178 : slli a3 a3 1 
'h00000178 : begin a3 <= $unsigned(a3) << 1; end
//        u_b >>= 1
//     17C : srli a4 a4 1 
'h0000017C : begin a4 <= $unsigned(a4) >> 1; end
//     180 : j 14C <__mulsi3+#x30> 
'h00000180 : begin pc <= 332; end
//
// 0x00000184 <__modsi3>:
//int __modsi3(int a, int b) {
//     184 : addi sp sp -16 
'h00000184 : begin sp <= $signed(sp) + $signed(-16); end
//     188 : sw ra C (sp) 
'h00000188 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     18C : sw s0 8 (sp) 
'h0000018C : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     190 : sw s1 4 (sp) 
'h00000190 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     194 : addi s0 sp 10 
'h00000194 : begin s0 <= $signed(sp) + $signed(16); end
//     198 : mv s1 a0 
'h00000198 : begin s1 <= a0; end
//    unsigned int u_d = ( 0xb < 0) ? -b : b
//     19C : srai a4 a1 1F 
'h0000019C : begin a4 <= $signed(a1) >>> 31; end
//     1A0 : xor a1 a4 a1 
'h000001A0 : begin a1 <= $unsigned(a4) ^ $unsigned(a1); end
//    unsigned int u_n = ( 0xa < 0) ? -a : a
//     1A4 : srai a5 a0 1F 
'h000001A4 : begin a5 <= $signed(a0) >>> 31; end
//     1A8 : xor a0 a5 a0 
'h000001A8 : begin a0 <= $unsigned(a5) ^ $unsigned(a0); end
//    __udivsi3_umodsi3(u_n, u_d, &r)
//     1AC : addi a2 s0 -16 
'h000001AC : begin a2 <= $signed(s0) + $signed(-16); end
//     1B0 : sub a1 a1 a4 
'h000001B0 : begin a1 <= $unsigned(a1) - $unsigned(a4); end
//     1B4 : sub a0 a0 a5 
'h000001B4 : begin a0 <= $unsigned(a0) - $unsigned(a5); end
//     1B8 : auipc ra 0 
'h000001B8 : begin ra <= pc + (0 << 12); end
//     1BC : jalr -440 (ra) # 0 <__udivsi3_umodsi3> 
'h000001BC : begin pc <= $signed(-440) + $signed(ra); ra <= pc + 4; end
//    return ( 0xa < 0) ? -(int)r : (int)r
//     1C0 : lw a0 -16 (s0) 
'h000001C0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     1C4 : bgez s1 1CC <__modsi3+#x48> 
'h000001C4 : begin if($signed(s1) >= 0) pc <= 460; end
//     1C8 : neg a0 a0 
'h000001C8 : begin a0 <= 0-a0; end
//}
//     1CC : lw ra C (sp) 
'h000001CC : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     1D0 : lw s0 8 (sp) 
'h000001D0 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     1D4 : lw s1 4 (sp) 
'h000001D4 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     1D8 : addi sp sp 10 
'h000001D8 : begin sp <= $signed(sp) + $signed(16); end
//     1DC : ret 
'h000001DC : begin pc <= ra; end
//
// 0x000001e0 <fprintf>:
//    }
//    *dest = '\0'
//    (*count)++
//}
//
//int fprintf(void *stream, const char *fmt, ...) {
//     1E0 : addi sp sp -40 
'h000001E0 : begin sp <= $signed(sp) + $signed(-40); end
//     1E4 : sw ra 14 (sp) 
'h000001E4 : begin if(!valid) begin addr = $signed(20) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1E8 : sw s0 10 (sp) 
'h000001E8 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1EC : sw s1 C (sp) 
'h000001EC : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1F0 : addi s0 sp 18 
'h000001F0 : begin s0 <= $signed(sp) + $signed(24); end
//     1F4 : mv s1 a1 
'h000001F4 : begin s1 <= a1; end
//     1F8 : sw a2 0 (s0) 
'h000001F8 : begin if(!valid) begin addr = $signed(0) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1FC : sw a3 4 (s0) 
'h000001FC : begin if(!valid) begin addr = $signed(4) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     200 : sw a4 8 (s0) 
'h00000200 : begin if(!valid) begin addr = $signed(8) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     204 : sw a5 C (s0) 
'h00000204 : begin if(!valid) begin addr = $signed(12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    va_list args
//    va_start(args, fmt)
//     208 : sw s0 -20 (s0) 
'h00000208 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    int count = 0
//     20C : sw zero -16 (s0) 
'h0000020C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= zero; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (
//     210 : lbu a4 0 (s1) 
'h00000210 : begin if(!valid) begin addr = $signed(0) + $signed(s1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= {{24{1'b0}},rdata_b}; end
//     214 : bnez a4 230 <s0rintf+#x50> 
'h00000214 : begin if($signed(a4) != 0) pc <= 560; end
//            count++
//        }
//    }
//    va_end(args)
//    return count
//}
//     218 : lw a0 -16 (s0) 
'h00000218 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     21C : lw ra 14 (sp) 
'h0000021C : begin if(!valid) begin addr = $signed(20) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     220 : lw s0 10 (sp) 
'h00000220 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     224 : lw s1 C (sp) 
'h00000224 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     228 : addi sp sp 28 
'h00000228 : begin sp <= $signed(sp) + $signed(40); end
//     22C : ret 
'h0000022C : begin pc <= ra; end
//        if (*fmt == '%' && *(fmt + 1)) {
//     230 : li a5 25 
'h00000230 : begin a5 <= 37; end
//     234 : bne a4 a5 320 <s0rintf+#x140> 
'h00000234 : begin if($signed(a4) != $signed(a5)) pc <= 800; end
//     238 : lbu a5 1 (s1) 
'h00000238 : begin if(!valid) begin addr = $signed(1) + $signed(s1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     23C : beqz a5 320 <s0rintf+#x140> 
'h0000023C : begin if($signed(a5) == 0) pc <= 800; end
//            switch (*fmt) {
//     240 : li a4 73 
'h00000240 : begin a4 <= 115; end
//     244 : beq a5 a4 2C4 <s0rintf+#xe4> 
'h00000244 : begin if($signed(a5) == $signed(a4)) pc <= 708; end
//     248 : li a4 78 
'h00000248 : begin a4 <= 120; end
//     24C : beq a5 a4 2A8 <s0rintf+#xc8> 
'h0000024C : begin if($signed(a5) == $signed(a4)) pc <= 680; end
//     250 : li a4 64 
'h00000250 : begin a4 <= 100; end
//     254 : bne a5 a4 318 <s0rintf+#x138> 
'h00000254 : begin if($signed(a5) != $signed(a4)) pc <= 792; end
//                case 'd': fprintf_d(stream, va_arg(args, int), &count)
//     258 : lw a5 -20 (s0) 
'h00000258 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     25C : addi a4 a5 4 
'h0000025C : begin a4 <= $signed(a5) + $signed(4); end
//     260 : sw a4 -20 (s0) 
'h00000260 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     264 : lw a1 0 (a5) 
'h00000264 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//    if (val < 0) {
//     268 : bgez a1 284 <s0rintf+#xa4> 
'h00000268 : begin if($signed(a1) >= 0) pc <= 644; end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     26C : li a5 2D 
'h0000026C : begin a5 <= 45; end
//     270 : sw a5 0 (a0) 
'h00000270 : begin if(!valid) begin addr = $signed(0) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        (*count)++
//     274 : lw a5 -16 (s0) 
'h00000274 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     278 : addi a5 a5 1 
'h00000278 : begin a5 <= $signed(a5) + $signed(1); end
//     27C : sw a5 -16 (s0) 
'h0000027C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        val = -val
//     280 : neg a1 a1 
'h00000280 : begin a1 <= 0-a1; end
//    _fmt_base(stream, (unsigned int)val, 10, count)
//     284 : addi a3 s0 -16 
'h00000284 : begin a3 <= $signed(s0) + $signed(-16); end
//     288 : li a2 A 
'h00000288 : begin a2 <= 10; end
//     28C : sw a0 -24 (s0) 
'h0000028C : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     290 : auipc ra 0 
'h00000290 : begin ra <= pc + (0 << 12); end
//     294 : jalr -548 (ra) # 6C <_fmt_base> 
'h00000294 : begin pc <= $signed(-548) + $signed(ra); ra <= pc + 4; end
//     298 : lw a0 -24 (s0) 
'h00000298 : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//            fmt++
//     29C : addi s1 s1 1 
'h0000029C : begin s1 <= $signed(s1) + $signed(1); end
//    for (
//     2A0 : addi s1 s1 1 
'h000002A0 : begin s1 <= $signed(s1) + $signed(1); end
//     2A4 : j 210 <s0rintf+#x30> 
'h000002A4 : begin pc <= 528; end
//                case 'x': fprintf_x(stream, va_arg(args, unsigned int), &count)
//     2A8 : lw a5 -20 (s0) 
'h000002A8 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2AC : addi a4 a5 4 
'h000002AC : begin a4 <= $signed(a5) + $signed(4); end
//     2B0 : sw a4 -20 (s0) 
'h000002B0 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    _fmt_base(stream, val, 16, count)
//     2B4 : addi a3 s0 -16 
'h000002B4 : begin a3 <= $signed(s0) + $signed(-16); end
//     2B8 : li a2 10 
'h000002B8 : begin a2 <= 16; end
//     2BC : lw a1 0 (a5) 
'h000002BC : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//     2C0 : j 28C <s0rintf+#xac> 
'h000002C0 : begin pc <= 652; end
//                case 's': fprintf_s(stream, va_arg(args, char *), &count)
//     2C4 : lw a5 -20 (s0) 
'h000002C4 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     2C8 : addi a4 a5 4 
'h000002C8 : begin a4 <= $signed(a5) + $signed(4); end
//     2CC : sw a4 -20 (s0) 
'h000002CC : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2D0 : lw a4 0 (a5) 
'h000002D0 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//    if (!s) s = "(null)"
//     2D4 : bnez a4 2E0 <s0rintf+#x100> 
'h000002D4 : begin if($signed(a4) != 0) pc <= 736; end
//     2D8 : auipc a4 1 
'h000002D8 : begin a4 <= pc + (1 << 12); end
//     2DC : addi a4 a4 -728 # 1000 <main+#x9b0> 
'h000002DC : begin a4 <= $signed(a4) + $signed(-728); end
//     2E0 : lw a3 -16 (s0) 
'h000002E0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     2E4 : mv a5 a4 
'h000002E4 : begin a5 <= a4; end
//     2E8 : li a2 0 
'h000002E8 : begin a2 <= 0; end
//    while (*s) { fputc(*s++, stream)
//     2EC : lbu a1 0 (a5) 
'h000002EC : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= {{24{1'b0}},rdata_b}; end
//     2F0 : bnez a1 308 <s0rintf+#x128> 
'h000002F0 : begin if($signed(a1) != 0) pc <= 776; end
//     2F4 : beqz a2 29C <s0rintf+#xbc> 
'h000002F4 : begin if($signed(a2) == 0) pc <= 668; end
//     2F8 : sub a4 a3 a4 
'h000002F8 : begin a4 <= $unsigned(a3) - $unsigned(a4); end
//     2FC : add a5 a5 a4 
'h000002FC : begin a5 <= $unsigned(a5) + $unsigned(a4); end
//     300 : sw a5 -16 (s0) 
'h00000300 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     304 : j 29C <s0rintf+#xbc> 
'h00000304 : begin pc <= 668; end
//     308 : addi a5 a5 1 
'h00000308 : begin a5 <= $signed(a5) + $signed(1); end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     30C : sw a1 0 (a0) 
'h0000030C : begin if(!valid) begin addr = $signed(0) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     310 : li a2 1 
'h00000310 : begin a2 <= 1; end
//     314 : j 2EC <s0rintf+#x10c> 
'h00000314 : begin pc <= 748; end
//     318 : sw a5 0 (a0) 
'h00000318 : begin if(!valid) begin addr = $signed(0) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    return c
//     31C : j 29C <s0rintf+#xbc> 
'h0000031C : begin pc <= 668; end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     320 : sw a4 0 (a0) 
'h00000320 : begin if(!valid) begin addr = $signed(0) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            count++
//     324 : lw a5 -16 (s0) 
'h00000324 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     328 : addi a5 a5 1 
'h00000328 : begin a5 <= $signed(a5) + $signed(1); end
//     32C : sw a5 -16 (s0) 
'h0000032C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     330 : j 2A0 <s0rintf+#xc0> 
'h00000330 : begin pc <= 672; end
//
// 0x00000334 <fscanf>:
//
//int fscanf(void *stream, const char *fmt, ...) {
//     334 : addi sp sp -52 
'h00000334 : begin sp <= $signed(sp) + $signed(-52); end
//     338 : sw ra 20 (sp) 
'h00000338 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     33C : sw s0 1C (sp) 
'h0000033C : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     340 : sw s1 18 (sp) 
'h00000340 : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     344 : addi s0 sp 24 
'h00000344 : begin s0 <= $signed(sp) + $signed(36); end
//     348 : mv t1 a0 
'h00000348 : begin t1 <= a0; end
//     34C : sw a2 0 (s0) 
'h0000034C : begin if(!valid) begin addr = $signed(0) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     350 : sw a3 4 (s0) 
'h00000350 : begin if(!valid) begin addr = $signed(4) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     354 : sw a4 8 (s0) 
'h00000354 : begin if(!valid) begin addr = $signed(8) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     358 : sw a5 C (s0) 
'h00000358 : begin if(!valid) begin addr = $signed(12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    va_list args
//    va_start(args, fmt)
//     35C : sw s0 -16 (s0) 
'h0000035C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    int count = 0
//     360 : li a4 0 
'h00000360 : begin a4 <= 0; end
//    for (
//        if (*fmt == ' ') skip_ws(stream)
//     364 : li t2 20 
'h00000364 : begin t2 <= 32; end
//    for (
//     368 : lbu a5 0 (a1) 
'h00000368 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     36C : bnez a5 388 <fscanf+#x54> 
'h0000036C : begin if($signed(a5) != 0) pc <= 904; end
//            }
//        }
//    }
//    va_end(args)
//    return count
//}
//     370 : mv a0 a4 
'h00000370 : begin a0 <= a4; end
//     374 : lw ra 20 (sp) 
'h00000374 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     378 : lw s0 1C (sp) 
'h00000378 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     37C : lw s1 18 (sp) 
'h0000037C : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     380 : addi sp sp 34 
'h00000380 : begin sp <= $signed(sp) + $signed(52); end
//     384 : ret 
'h00000384 : begin pc <= ra; end
//            fmt++
//     388 : addi t0 a1 1 
'h00000388 : begin t0 <= $signed(a1) + $signed(1); end
//        if (*fmt == ' ') skip_ws(stream)
//     38C : bne a5 t2 3A0 <fscanf+#x6c> 
'h0000038C : begin if($signed(a5) != $signed(t2)) pc <= 928; end
//    return (unsigned char)(*(volatile char *)stream)
//     390 : lbu a5 0 (t1) 
'h00000390 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     394 : bgeu t2 a5 390 <fscanf+#x5c> 
'h00000394 : begin if($unsigned(t2) >= $unsigned(a5)) pc <= 912; end
//    for (
//     398 : addi a1 a1 1 
'h00000398 : begin a1 <= $signed(a1) + $signed(1); end
//     39C : j 368 <fscanf+#x34> 
'h0000039C : begin pc <= 872; end
//        else if (*fmt == '%' && *(fmt + 1)) {
//     3A0 : li a3 25 
'h000003A0 : begin a3 <= 37; end
//     3A4 : bne a5 a3 398 <fscanf+#x64> 
'h000003A4 : begin if($signed(a5) != $signed(a3)) pc <= 920; end
//     3A8 : lbu a5 1 (a1) 
'h000003A8 : begin if(!valid) begin addr = $signed(1) + $signed(a1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     3AC : beqz a5 398 <fscanf+#x64> 
'h000003AC : begin if($signed(a5) == 0) pc <= 920; end
//            switch (*fmt) {
//     3B0 : li a3 73 
'h000003B0 : begin a3 <= 115; end
//     3B4 : beq a5 a3 4E4 <fscanf+#x1b0> 
'h000003B4 : begin if($signed(a5) == $signed(a3)) pc <= 1252; end
//     3B8 : li a3 78 
'h000003B8 : begin a3 <= 120; end
//     3BC : beq a5 a3 478 <fscanf+#x144> 
'h000003BC : begin if($signed(a5) == $signed(a3)) pc <= 1144; end
//     3C0 : li a3 64 
'h000003C0 : begin a3 <= 100; end
//     3C4 : mv a1 t0 
'h000003C4 : begin a1 <= t0; end
//     3C8 : bne a5 a3 398 <fscanf+#x64> 
'h000003C8 : begin if($signed(a5) != $signed(a3)) pc <= 920; end
//                case 'd': fscanf_d(stream, va_arg(args, int *), &count)
//     3CC : lw a5 -16 (s0) 
'h000003CC : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     3D0 : addi a3 a5 4 
'h000003D0 : begin a3 <= $signed(a5) + $signed(4); end
//     3D4 : sw a3 -16 (s0) 
'h000003D4 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     3D8 : lw a3 0 (a5) 
'h000003D8 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     3DC : li a2 20 
'h000003DC : begin a2 <= 32; end
//    return (unsigned char)(*(volatile char *)stream)
//     3E0 : lbu a5 0 (t1) 
'h000003E0 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     3E4 : zext.b s1 a5 
'h000003E4 : begin s1 <= 32'hff & a5; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     3E8 : bge a2 a5 3E0 <fscanf+#xac> 
'h000003E8 : begin if($signed(a2) >= $signed(a5)) pc <= 992; end
//    int neg = (c == '-') ? (c = fgetc(stream), 1) : 0
//     3EC : li a2 2D 
'h000003EC : begin a2 <= 45; end
//     3F0 : li a5 0 
'h000003F0 : begin a5 <= 0; end
//     3F4 : bne s1 a2 404 <fscanf+#xd0> 
'h000003F4 : begin if($signed(s1) != $signed(a2)) pc <= 1028; end
//    return (unsigned char)(*(volatile char *)stream)
//     3F8 : lbu s1 0 (t1) 
'h000003F8 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{24{1'b0}},rdata_b}; end
//     3FC : zext.b s1 s1 
'h000003FC : begin s1 <= 32'hff & s1; end
//    int neg = (c == '-') ? (c = fgetc(stream), 1) : 0
//     400 : li a5 1 
'h00000400 : begin a5 <= 1; end
//    int val = 0, c = skip_ws(stream)
//     404 : li a0 0 
'h00000404 : begin a0 <= 0; end
//    while (c >= '0' &&  0xc <= '9') {
//     408 : li a2 9 
'h00000408 : begin a2 <= 9; end
//     40C : addi s1 s1 -48 
'h0000040C : begin s1 <= $signed(s1) + $signed(-48); end
//     410 : bgeu a2 s1 42C <fscanf+#xf8> 
'h00000410 : begin if($unsigned(a2) >= $unsigned(s1)) pc <= 1068; end
//    *dest = neg ? -val : val
//     414 : beqz a5 41C <fscanf+#xe8> 
'h00000414 : begin if($signed(a5) == 0) pc <= 1052; end
//     418 : neg a0 a0 
'h00000418 : begin a0 <= 0-a0; end
//     41C : sw a0 0 (a3) 
'h0000041C : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    (*count)++
//     420 : addi a4 a4 1 
'h00000420 : begin a4 <= $signed(a4) + $signed(1); end
//            fmt++
//     424 : mv a1 t0 
'h00000424 : begin a1 <= t0; end
//     428 : j 398 <fscanf+#x64> 
'h00000428 : begin pc <= 920; end
//     42C : sw t1 -36 (s0) 
'h0000042C : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     430 : sw a4 -32 (s0) 
'h00000430 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     434 : sw a5 -28 (s0) 
'h00000434 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     438 : sw t0 -24 (s0) 
'h00000438 : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     43C : sw a3 -20 (s0) 
'h0000043C : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        val = __mulsi3(val, 10) + (c - '0')
//     440 : li a1 A 
'h00000440 : begin a1 <= 10; end
//     444 : auipc ra 0 
'h00000444 : begin ra <= pc + (0 << 12); end
//     448 : jalr -808 (ra) # 11C <__mulsi3> 
'h00000448 : begin pc <= $signed(-808) + $signed(ra); ra <= pc + 4; end
//     44C : add a0 s1 a0 
'h0000044C : begin a0 <= $unsigned(s1) + $unsigned(a0); end
//    return (unsigned char)(*(volatile char *)stream)
//     450 : lw t1 -36 (s0) 
'h00000450 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//     454 : lbu s1 0 (t1) 
'h00000454 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{24{1'b0}},rdata_b}; end
//     458 : zext.b s1 s1 
'h00000458 : begin s1 <= 32'hff & s1; end
//     45C : li t2 20 
'h0000045C : begin t2 <= 32; end
//     460 : li a2 9 
'h00000460 : begin a2 <= 9; end
//     464 : lw a4 -32 (s0) 
'h00000464 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     468 : lw a5 -28 (s0) 
'h00000468 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     46C : lw t0 -24 (s0) 
'h0000046C : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t0 <= rdata_w; end
//     470 : lw a3 -20 (s0) 
'h00000470 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     474 : j 40C <fscanf+#xd8> 
'h00000474 : begin pc <= 1036; end
//                case 'x': fscanf_x(stream, va_arg(args, unsigned int *), &count)
//     478 : lw a5 -16 (s0) 
'h00000478 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     47C : addi a3 a5 4 
'h0000047C : begin a3 <= $signed(a5) + $signed(4); end
//     480 : sw a3 -16 (s0) 
'h00000480 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     484 : lw a0 0 (a5) 
'h00000484 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     488 : li a2 20 
'h00000488 : begin a2 <= 32; end
//    return (unsigned char)(*(volatile char *)stream)
//     48C : lbu a3 0 (t1) 
'h0000048C : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{24{1'b0}},rdata_b}; end
//     490 : zext.b a5 a3 
'h00000490 : begin a5 <= 32'hff & a3; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     494 : bge a2 a3 48C <fscanf+#x158> 
'h00000494 : begin if($signed(a2) >= $signed(a3)) pc <= 1164; end
//    unsigned int val = 0
//     498 : li a2 0 
'h00000498 : begin a2 <= 0; end
//        if (c >= '0' &&  0xc <= '9')      digit = c - '0'
//     49C : li s1 9 
'h0000049C : begin s1 <= 9; end
//        else if (c >= 'a' &&  0xc <= 'f') digit = c - 'a' + 10
//     4A0 : li a1 5 
'h000004A0 : begin a1 <= 5; end
//        if (c >= '0' &&  0xc <= '9')      digit = c - '0'
//     4A4 : addi a3 a5 -48 
'h000004A4 : begin a3 <= $signed(a5) + $signed(-48); end
//     4A8 : bgeu s1 a3 4B8 <fscanf+#x184> 
'h000004A8 : begin if($unsigned(s1) >= $unsigned(a3)) pc <= 1208; end
//        else if (c >= 'a' &&  0xc <= 'f') digit = c - 'a' + 10
//     4AC : addi a3 a5 -97 
'h000004AC : begin a3 <= $signed(a5) + $signed(-97); end
//     4B0 : bltu a1 a3 4CC <fscanf+#x198> 
'h000004B0 : begin if($unsigned(a1) < $unsigned(a3)) pc <= 1228; end
//     4B4 : addi a3 a5 -87 
'h000004B4 : begin a3 <= $signed(a5) + $signed(-87); end
//        val = (val << 4) | digit
//     4B8 : slli a2 a2 4 
'h000004B8 : begin a2 <= $unsigned(a2) << 4; end
//     4BC : or a2 a3 a2 
'h000004BC : begin a2 <= $unsigned(a3) | $unsigned(a2); end
//    return (unsigned char)(*(volatile char *)stream)
//     4C0 : lbu a5 0 (t1) 
'h000004C0 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     4C4 : zext.b a5 a5 
'h000004C4 : begin a5 <= 32'hff & a5; end
//    while (1) {
//     4C8 : j 4A4 <fscanf+#x170> 
'h000004C8 : begin pc <= 1188; end
//        else if (c >= 'A' &&  0xc <= 'F') digit = c - 'A' + 10
//     4CC : addi a3 a5 -65 
'h000004CC : begin a3 <= $signed(a5) + $signed(-65); end
//     4D0 : bltu a1 a3 4DC <fscanf+#x1a8> 
'h000004D0 : begin if($unsigned(a1) < $unsigned(a3)) pc <= 1244; end
//     4D4 : addi a3 a5 -55 
'h000004D4 : begin a3 <= $signed(a5) + $signed(-55); end
//     4D8 : j 4B8 <fscanf+#x184> 
'h000004D8 : begin pc <= 1208; end
//    *dest = val
//     4DC : sw a2 0 (a0) 
'h000004DC : begin if(!valid) begin addr = $signed(0) + $signed(a0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    (*count)++
//     4E0 : j 420 <fscanf+#xec> 
'h000004E0 : begin pc <= 1056; end
//                case 's': fscanf_s(stream, va_arg(args, char *), &count)
//     4E4 : lw a5 -16 (s0) 
'h000004E4 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     4E8 : addi a3 a5 4 
'h000004E8 : begin a3 <= $signed(a5) + $signed(4); end
//     4EC : sw a3 -16 (s0) 
'h000004EC : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     4F0 : lw a2 0 (a5) 
'h000004F0 : begin if(!valid) begin addr = $signed(0) + $signed(a5); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     4F4 : li a1 20 
'h000004F4 : begin a1 <= 32; end
//    return (unsigned char)(*(volatile char *)stream)
//     4F8 : lbu a5 0 (t1) 
'h000004F8 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//     4FC : zext.b a3 a5 
'h000004FC : begin a3 <= 32'hff & a5; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     500 : bge a1 a5 4F8 <fscanf+#x1c4> 
'h00000500 : begin if($signed(a1) >= $signed(a5)) pc <= 1272; end
//     504 : li a0 17 
'h00000504 : begin a0 <= 23; end
//     508 : lui a1 800 
'h00000508 : begin a1 <= 2048 << 12; end
//     50C : addi a1 a1 13 # 800013 <lfsr+#x7fd00b> 
'h0000050C : begin a1 <= $signed(a1) + $signed(19); end
//    while (c != -1 && c != ' ' && c != '\t' && c != '\n' && c != '\r') {
//     510 : addi a5 a3 -9 
'h00000510 : begin a5 <= $signed(a3) + $signed(-9); end
//     514 : bltu a0 a5 52C <fscanf+#x1f8> 
'h00000514 : begin if($unsigned(a0) < $unsigned(a5)) pc <= 1324; end
//     518 : srl a5 a1 a5 
'h00000518 : begin a5 <= $unsigned(a1) >> a5; end
//     51C : andi a5 a5 1 
'h0000051C : begin a5 <= $signed(a5) & $signed(1); end
//     520 : beqz a5 52C <fscanf+#x1f8> 
'h00000520 : begin if($signed(a5) == 0) pc <= 1324; end
//    *dest = '\0'
//     524 : sb zero 0 (a2) 
'h00000524 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 1; size <= 0; wdata <= zero[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     528 : j 420 <fscanf+#xec> 
'h00000528 : begin pc <= 1056; end
//        *dest++ = (char)c
//     52C : addi a2 a2 1 
'h0000052C : begin a2 <= $signed(a2) + $signed(1); end
//     530 : sb a3 -1 (a2) 
'h00000530 : begin if(!valid) begin addr = $signed(-1) + $signed(a2); valid <= 1; write <= 1; size <= 0; wdata <= a3[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    return (unsigned char)(*(volatile char *)stream)
//     534 : lbu a3 0 (t1) 
'h00000534 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{24{1'b0}},rdata_b}; end
//     538 : zext.b a3 a3 
'h00000538 : begin a3 <= 32'hff & a3; end
//     53C : j 510 <fscanf+#x1dc> 
'h0000053C : begin pc <= 1296; end
//
// 0x00000540 <isqrt>:
//#else
//#include "stdio.h"
//#endif
//
//
//unsigned int isqrt(unsigned int value) {
//     540 : addi sp sp -8 
'h00000540 : begin sp <= $signed(sp) + $signed(-8); end
//     544 : sw ra 4 (sp) 
'h00000544 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     548 : sw s0 0 (sp) 
'h00000548 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     54C : addi s0 sp 8 
'h0000054C : begin s0 <= $signed(sp) + $signed(8); end
//     550 : mv a4 a0 
'h00000550 : begin a4 <= a0; end
//    unsigned int res = 0
//    unsigned int bit = 1U << 30
//     554 : lui a5 40000 
'h00000554 : begin a5 <= 262144 << 12; end
//    while (bit > value) {
//     558 : bltu a4 a5 574 <isqrt+#x34> 
'h00000558 : begin if($unsigned(a4) < $unsigned(a5)) pc <= 1396; end
//    unsigned int res = 0
//     55C : li a0 0 
'h0000055C : begin a0 <= 0; end
//        bit >>= 2
//    }
//    while (bit != 0) {
//     560 : bnez a5 57C <isqrt+#x3c> 
'h00000560 : begin if($signed(a5) != 0) pc <= 1404; end
//            res >>= 1
//        }
//        bit >>= 2
//    }
//    return res
//}
//     564 : lw ra 4 (sp) 
'h00000564 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     568 : lw s0 0 (sp) 
'h00000568 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     56C : addi sp sp 8 
'h0000056C : begin sp <= $signed(sp) + $signed(8); end
//     570 : ret 
'h00000570 : begin pc <= ra; end
//        bit >>= 2
//     574 : srli a5 a5 2 
'h00000574 : begin a5 <= $unsigned(a5) >> 2; end
//     578 : j 558 <isqrt+#x18> 
'h00000578 : begin pc <= 1368; end
//        if (value >= res + bit) {
//     57C : add a3 a0 a5 
'h0000057C : begin a3 <= $unsigned(a0) + $unsigned(a5); end
//            res = (res >> 1) + bit
//     580 : srli a0 a0 1 
'h00000580 : begin a0 <= $unsigned(a0) >> 1; end
//        if (value >= res + bit) {
//     584 : bltu a4 a3 590 <isqrt+#x50> 
'h00000584 : begin if($unsigned(a4) < $unsigned(a3)) pc <= 1424; end
//            value -= res + bit
//     588 : sub a4 a4 a3 
'h00000588 : begin a4 <= $unsigned(a4) - $unsigned(a3); end
//            res = (res >> 1) + bit
//     58C : add a0 a0 a5 
'h0000058C : begin a0 <= $unsigned(a0) + $unsigned(a5); end
//        bit >>= 2
//     590 : srli a5 a5 2 
'h00000590 : begin a5 <= $unsigned(a5) >> 2; end
//     594 : j 560 <isqrt+#x20> 
'h00000594 : begin pc <= 1376; end
//
// 0x00000598 <prime>:
//
//int prime(int n, int d)
//{
//     598 : addi sp sp -16 
'h00000598 : begin sp <= $signed(sp) + $signed(-16); end
//     59C : sw ra C (sp) 
'h0000059C : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     5A0 : sw s0 8 (sp) 
'h000005A0 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     5A4 : sw s1 4 (sp) 
'h000005A4 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     5A8 : addi s0 sp 10 
'h000005A8 : begin s0 <= $signed(sp) + $signed(16); end
//     5AC : sw a0 -16 (s0) 
'h000005AC : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     5B0 : mv s1 a1 
'h000005B0 : begin s1 <= a1; end
//  if(d > isqrt(n)) return 1
//     5B4 : lw a0 -16 (s0) 
'h000005B4 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     5B8 : auipc ra 0 
'h000005B8 : begin ra <= pc + (0 << 12); end
//     5BC : jalr -120 (ra) # 540 <isqrt> 
'h000005BC : begin pc <= $signed(-120) + $signed(ra); ra <= pc + 4; end
//     5C0 : bltu a0 s1 5E0 <prime+#x48> 
'h000005C0 : begin if($unsigned(a0) < $unsigned(s1)) pc <= 1504; end
//  if(n % d == 0) return 0
//     5C4 : mv a1 s1 
'h000005C4 : begin a1 <= s1; end
//     5C8 : lw a0 -16 (s0) 
'h000005C8 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     5CC : auipc ra 0 
'h000005CC : begin ra <= pc + (0 << 12); end
//     5D0 : jalr -1096 (ra) # 184 <__modsi3> 
'h000005D0 : begin pc <= $signed(-1096) + $signed(ra); ra <= pc + 4; end
//     5D4 : beqz a0 5E4 <prime+#x4c> 
'h000005D4 : begin if($signed(a0) == 0) pc <= 1508; end
//  return prime(n, d+2)
//     5D8 : addi s1 s1 2 
'h000005D8 : begin s1 <= $signed(s1) + $signed(2); end
//     5DC : j 5B4 <prime+#x1c> 
'h000005DC : begin pc <= 1460; end
//  if(d > isqrt(n)) return 1
//     5E0 : li a0 1 
'h000005E0 : begin a0 <= 1; end
//}
//     5E4 : lw ra C (sp) 
'h000005E4 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     5E8 : lw s0 8 (sp) 
'h000005E8 : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     5EC : lw s1 4 (sp) 
'h000005EC : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     5F0 : addi sp sp 10 
'h000005F0 : begin sp <= $signed(sp) + $signed(16); end
//     5F4 : ret 
'h000005F4 : begin pc <= ra; end
//
// 0x000005f8 <primep>:
//
//int primep(int n)
//{
//     5F8 : addi sp sp -8 
'h000005F8 : begin sp <= $signed(sp) + $signed(-8); end
//     5FC : sw ra 4 (sp) 
'h000005FC : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     600 : sw s0 0 (sp) 
'h00000600 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     604 : addi s0 sp 8 
'h00000604 : begin s0 <= $signed(sp) + $signed(8); end
//  if(n <= 1) return 0
//     608 : li a5 1 
'h00000608 : begin a5 <= 1; end
//     60C : bge a5 a0 638 <primep+#x40> 
'h0000060C : begin if($signed(a5) >= $signed(a0)) pc <= 1592; end
//  if(n == 2) return 1
//     610 : li a3 2 
'h00000610 : begin a3 <= 2; end
//     614 : beq a0 a3 63C <primep+#x44> 
'h00000614 : begin if($signed(a0) == $signed(a3)) pc <= 1596; end
//  if(n % 2 == 0) return 0
//     618 : and a5 a0 a5 
'h00000618 : begin a5 <= $unsigned(a0) & $unsigned(a5); end
//     61C : beqz a5 63C <primep+#x44> 
'h0000061C : begin if($signed(a5) == 0) pc <= 1596; end
//  return prime(n ,3)
//     620 : li a1 3 
'h00000620 : begin a1 <= 3; end
//}
//     624 : lw ra 4 (sp) 
'h00000624 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     628 : lw s0 0 (sp) 
'h00000628 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     62C : addi sp sp 8 
'h0000062C : begin sp <= $signed(sp) + $signed(8); end
//  return prime(n ,3)
//     630 : auipc t1 0 
'h00000630 : begin t1 <= pc + (0 << 12); end
//     634 : jr -152 (t1) # 598 <prime> 
'h00000634 : begin pc <= $signed(-152) + $signed(t1); t1 <= pc + 4; end
//  if(n <= 1) return 0
//     638 : li a5 0 
'h00000638 : begin a5 <= 0; end
//}
//     63C : mv a0 a5 
'h0000063C : begin a0 <= a5; end
//     640 : lw ra 4 (sp) 
'h00000640 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     644 : lw s0 0 (sp) 
'h00000644 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     648 : addi sp sp 8 
'h00000648 : begin sp <= $signed(sp) + $signed(8); end
//     64C : ret 
'h0000064C : begin pc <= ra; end
//
// 0x00000650 <main>:
//
//int main()
//{
//     650 : addi sp sp -20 
'h00000650 : begin sp <= $signed(sp) + $signed(-20); end
//     654 : sw ra 10 (sp) 
'h00000654 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     658 : sw s0 C (sp) 
'h00000658 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     65C : sw s1 8 (sp) 
'h0000065C : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     660 : addi s0 sp 14 
'h00000660 : begin s0 <= $signed(sp) + $signed(20); end
//  int n, m
//  while(1) {
//    printf("find all prime number from\n\r> ")
//     664 : auipc a1 1 
'h00000664 : begin a1 <= pc + (1 << 12); end
//     668 : addi a1 a1 -1628 # 1008 <main+#x9b8> 
'h00000668 : begin a1 <= $signed(a1) + $signed(-1628); end
//     66C : auipc a0 1 
'h0000066C : begin a0 <= pc + (1 << 12); end
//     670 : lw a0 -1568 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000670 : begin if(!valid) begin addr = $signed(-1568) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     674 : auipc ra 0 
'h00000674 : begin ra <= pc + (0 << 12); end
//     678 : jalr -1172 (ra) # 1E0 <s0rintf> 
'h00000678 : begin pc <= $signed(-1172) + $signed(ra); ra <= pc + 4; end
//    scanf("%d", &n)
//     67C : addi a2 s0 -20 
'h0000067C : begin a2 <= $signed(s0) + $signed(-20); end
//     680 : auipc a1 1 
'h00000680 : begin a1 <= pc + (1 << 12); end
//     684 : addi a1 a1 -1624 # 1028 <main+#x9d8> 
'h00000684 : begin a1 <= $signed(a1) + $signed(-1624); end
//     688 : auipc a0 1 
'h00000688 : begin a0 <= pc + (1 << 12); end
//     68C : lw a0 -1592 (a0) # 1050 <_GLOBAL_OFFSET_TABLE_+#x8> 
'h0000068C : begin if(!valid) begin addr = $signed(-1592) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     690 : auipc ra 0 
'h00000690 : begin ra <= pc + (0 << 12); end
//     694 : jalr -860 (ra) # 334 <fscanf> 
'h00000694 : begin pc <= $signed(-860) + $signed(ra); ra <= pc + 4; end
//    printf("%d\n\rto\n\r> ", n)
//     698 : lw a2 -20 (s0) 
'h00000698 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     69C : auipc a1 1 
'h0000069C : begin a1 <= pc + (1 << 12); end
//     6A0 : addi a1 a1 -1648 # 102C <main+#x9dc> 
'h000006A0 : begin a1 <= $signed(a1) + $signed(-1648); end
//     6A4 : auipc a0 1 
'h000006A4 : begin a0 <= pc + (1 << 12); end
//     6A8 : lw a0 -1624 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x4> 
'h000006A8 : begin if(!valid) begin addr = $signed(-1624) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     6AC : auipc ra 0 
'h000006AC : begin ra <= pc + (0 << 12); end
//     6B0 : jalr -1228 (ra) # 1E0 <s0rintf> 
'h000006B0 : begin pc <= $signed(-1228) + $signed(ra); ra <= pc + 4; end
//    scanf("%d", &m)
//     6B4 : addi a2 s0 -16 
'h000006B4 : begin a2 <= $signed(s0) + $signed(-16); end
//     6B8 : auipc a1 1 
'h000006B8 : begin a1 <= pc + (1 << 12); end
//     6BC : addi a1 a1 -1680 # 1028 <main+#x9d8> 
'h000006BC : begin a1 <= $signed(a1) + $signed(-1680); end
//     6C0 : auipc a0 1 
'h000006C0 : begin a0 <= pc + (1 << 12); end
//     6C4 : lw a0 -1648 (a0) # 1050 <_GLOBAL_OFFSET_TABLE_+#x8> 
'h000006C4 : begin if(!valid) begin addr = $signed(-1648) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     6C8 : auipc ra 0 
'h000006C8 : begin ra <= pc + (0 << 12); end
//     6CC : jalr -916 (ra) # 334 <fscanf> 
'h000006CC : begin pc <= $signed(-916) + $signed(ra); ra <= pc + 4; end
//    printf("%d\n\r: ", m)
//     6D0 : lw a2 -16 (s0) 
'h000006D0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     6D4 : auipc a1 1 
'h000006D4 : begin a1 <= pc + (1 << 12); end
//     6D8 : addi a1 a1 -1692 # 1038 <main+#x9e8> 
'h000006D8 : begin a1 <= $signed(a1) + $signed(-1692); end
//     6DC : auipc a0 1 
'h000006DC : begin a0 <= pc + (1 << 12); end
//     6E0 : lw a0 -1680 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x4> 
'h000006E0 : begin if(!valid) begin addr = $signed(-1680) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     6E4 : auipc ra 0 
'h000006E4 : begin ra <= pc + (0 << 12); end
//     6E8 : jalr -1284 (ra) # 1E0 <s0rintf> 
'h000006E8 : begin pc <= $signed(-1284) + $signed(ra); ra <= pc + 4; end
//    for(int i = n
//     6EC : lw s1 -20 (s0) 
'h000006EC : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     6F0 : lw a5 -16 (s0) 
'h000006F0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     6F4 : bge a5 s1 714 <main+#xc4> 
'h000006F4 : begin if($signed(a5) >= $signed(s1)) pc <= 1812; end
//      if(primep(i)) printf("%d ", i)
//    }
//    printf("\n\r")
//     6F8 : auipc a1 1 
'h000006F8 : begin a1 <= pc + (1 << 12); end
//     6FC : addi a1 a1 -1716 # 1044 <main+#x9f4> 
'h000006FC : begin a1 <= $signed(a1) + $signed(-1716); end
//     700 : auipc a0 1 
'h00000700 : begin a0 <= pc + (1 << 12); end
//     704 : lw a0 -1716 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000704 : begin if(!valid) begin addr = $signed(-1716) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     708 : auipc ra 0 
'h00000708 : begin ra <= pc + (0 << 12); end
//     70C : jalr -1320 (ra) # 1E0 <s0rintf> 
'h0000070C : begin pc <= $signed(-1320) + $signed(ra); ra <= pc + 4; end
//    printf("find all prime number from\n\r> ")
//     710 : j 664 <main+#x14> 
'h00000710 : begin pc <= 1636; end
//      if(primep(i)) printf("%d ", i)
//     714 : mv a0 s1 
'h00000714 : begin a0 <= s1; end
//     718 : auipc ra 0 
'h00000718 : begin ra <= pc + (0 << 12); end
//     71C : jalr -288 (ra) # 5F8 <primep> 
'h0000071C : begin pc <= $signed(-288) + $signed(ra); ra <= pc + 4; end
//     720 : beqz a0 740 <main+#xf0> 
'h00000720 : begin if($signed(a0) == 0) pc <= 1856; end
//     724 : mv a2 s1 
'h00000724 : begin a2 <= s1; end
//     728 : auipc a1 1 
'h00000728 : begin a1 <= pc + (1 << 12); end
//     72C : addi a1 a1 -1768 # 1040 <main+#x9f0> 
'h0000072C : begin a1 <= $signed(a1) + $signed(-1768); end
//     730 : auipc a0 1 
'h00000730 : begin a0 <= pc + (1 << 12); end
//     734 : lw a0 -1764 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000734 : begin if(!valid) begin addr = $signed(-1764) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     738 : auipc ra 0 
'h00000738 : begin ra <= pc + (0 << 12); end
//     73C : jalr -1368 (ra) # 1E0 <s0rintf> 
'h0000073C : begin pc <= $signed(-1368) + $signed(ra); ra <= pc + 4; end
//    for(int i = n
//     740 : addi s1 s1 1 
'h00000740 : begin s1 <= $signed(s1) + $signed(1); end
//     744 : j 6F0 <main+#xa0> 
'h00000744 : begin pc <= 1776; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
