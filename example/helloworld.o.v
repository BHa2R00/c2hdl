module helloworld (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, t10, t20, t00, s10, a20, a10, a30, a40, a50, a00, s00, ra0, sp0);
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
input [31:0] t10, t20, t00, s10, a20, a10, a30, a40, a50, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata;
wire [15:0] rdata_h = rdata;
wire [ 7:0] rdata_b = rdata;
reg [31:0] zero, t1, t2, t0, s1, a2, a1, a3, a4, a5, a0, s0, ra, sp;
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
      pc <= (pc0 > 'h454) ? 'h454 + 4 : pc0;
      t1 <= t10;
      t2 <= t20;
      t0 <= t00;
      s1 <= s10;
      a2 <= a20;
      a1 <= a10;
      a3 <= a30;
      a4 <= a40;
      a5 <= a50;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h454) ? 'h454 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/helloworld.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <__mulsi3>:
//#define stdout ((void*)&stdout)
//#define stdin ((void*)&stdin)
//#define EOF (-1)
//#define NULL ((void *)0)
//
//int __mulsi3(int a, int b) {
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//      10 : mv a5 a0 
'h00000010 : begin a5 <= a0; end
//    int res = 0
//    unsigned int u_a = ( 0xa < 0) ? -a : a
//      14 : srai a4 a0 1F 
'h00000014 : begin a4 <= $signed(a0) >>> 31; end
//      18 : xor a3 a4 a0 
'h00000018 : begin a3 <= $signed(a4) ^ $signed(a0); end
//      1C : sub a3 a3 a4 
'h0000001C : begin a3 <= $signed(a3) - $signed(a4); end
//    unsigned int u_b = ( 0xb < 0) ? -b : b
//      20 : srai a2 a1 1F 
'h00000020 : begin a2 <= $signed(a1) >>> 31; end
//      24 : xor a4 a2 a1 
'h00000024 : begin a4 <= $signed(a2) ^ $signed(a1); end
//      28 : sub a4 a4 a2 
'h00000028 : begin a4 <= $signed(a4) - $signed(a2); end
//    int res = 0
//      2C : li a0 0 
'h0000002C : begin a0 <= 0; end
//    while (u_b > 0) {
//      30 : bnez a4 50 <__mulsi3+#x50> 
'h00000030 : begin if($signed(a4) != 0) pc <= 80; end
//        if (u_b & 1) res += u_a
//        u_ 0xa <<= 1
//        u_b >>= 1
//    }
//    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res
//      34 : xor a5 a5 a1 
'h00000034 : begin a5 <= $signed(a5) ^ $signed(a1); end
//      38 : bgez a5 40 <__mulsi3+#x40> 
'h00000038 : begin if($signed(a5) >= 0) pc <= 64; end
//      3C : neg a0 a0 
'h0000003C : begin a0 <= 0-a0; end
//}
//      40 : lw ra 4 (sp) 
'h00000040 : begin if(!valid) begin addr = $signed(4) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//      44 : lw s0 0 (sp) 
'h00000044 : begin if(!valid) begin addr = $signed(0) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//      48 : addi sp sp 8 
'h00000048 : begin sp <= $signed(sp) + $signed(8); end
//      4C : ret 
'h0000004C : begin pc <= ra; end
//        if (u_b & 1) res += u_a
//      50 : andi a2 a4 1 
'h00000050 : begin a2 <= $signed(a4) & $signed(1); end
//      54 : beqz a2 5C <__mulsi3+#x5c> 
'h00000054 : begin if($signed(a2) == 0) pc <= 92; end
//      58 : add a0 a0 a3 
'h00000058 : begin a0 <= $signed(a0) + $signed(a3); end
//        u_ 0xa <<= 1
//      5C : slli a3 a3 1 
'h0000005C : begin a3 <= $unsigned(a3) << 1; end
//        u_b >>= 1
//      60 : srli a4 a4 1 
'h00000060 : begin a4 <= $unsigned(a4) >> 1; end
//      64 : j 30 <__mulsi3+#x30> 
'h00000064 : begin pc <= 48; end
//
// 0x00000068 <itoa>:
//    unsigned int r
//    _u_div_mod(a, b, &r)
//    return r
//}
//
//char* itoa(int val, char* s) {
//      68 : addi sp sp -28 
'h00000068 : begin sp <= $signed(sp) + $signed(-28); end
//      6C : sw ra 18 (sp) 
'h0000006C : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      70 : sw s0 14 (sp) 
'h00000070 : begin if(!valid) begin addr = $signed(20) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      74 : sw s1 10 (sp) 
'h00000074 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//      78 : addi s0 sp 1C 
'h00000078 : begin s0 <= $signed(sp) + $signed(28); end
//      7C : mv a4 a0 
'h0000007C : begin a4 <= a0; end
//      80 : mv a0 a1 
'h00000080 : begin a0 <= a1; end
//    char* ptr = s
//      84 : mv a3 a1 
'h00000084 : begin a3 <= a1; end
//    unsigned int uval
//    
//    if (val < 0) {
//      88 : bgez a4 9C <itoa+#x34> 
'h00000088 : begin if($signed(a4) >= 0) pc <= 156; end
//        *ptr++ = '-'
//      8C : addi a3 a1 1 
'h0000008C : begin a3 <= $signed(a1) + $signed(1); end
//      90 : li a5 2D 
'h00000090 : begin a5 <= 45; end
//      94 : sb a5 0 (a1) 
'h00000094 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 1; size <= 0; wdata <= a5[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        uval = (unsigned int)(-val)
//      98 : neg a4 a4 
'h00000098 : begin a4 <= 0-a4; end
//    } else {
//        uval = (unsigned int)val
//    }
//
//    char buf[11]
//    int i = 0
//      9C : addi t0 s0 -24 
'h0000009C : begin t0 <= $signed(s0) + $signed(-24); end
//      A0 : li a1 0 
'h000000A0 : begin a1 <= 0; end
//      A4 : sw t0 -28 (s0) 
'h000000A4 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            q |= (1U << i)
//      A8 : li t2 1 
'h000000A8 : begin t2 <= 1; end
//    unsigned int q = 0, r = 0
//      AC : li t1 0 
'h000000AC : begin t1 <= 0; end
//    for (int i = 31
//      B0 : li a2 1F 
'h000000B0 : begin a2 <= 31; end
//    unsigned int q = 0, r = 0
//      B4 : li a5 0 
'h000000B4 : begin a5 <= 0; end
//        r = (r << 1) | ((n >> i) & 1)
//      B8 : slli s1 a5 1 
'h000000B8 : begin s1 <= $unsigned(a5) << 1; end
//      BC : srl a5 a4 a2 
'h000000BC : begin a5 <= $unsigned(a4) >> a2; end
//      C0 : andi a5 a5 1 
'h000000C0 : begin a5 <= $signed(a5) & $signed(1); end
//      C4 : or a5 a5 s1 
'h000000C4 : begin a5 <= $signed(a5) | $signed(s1); end
//        if (r >= d) {
//      C8 : li s1 9 
'h000000C8 : begin s1 <= 9; end
//      CC : bgeu s1 a5 DC <itoa+#x74> 
'h000000CC : begin if($unsigned(s1) >= $unsigned(a5)) pc <= 220; end
//            r -= d
//      D0 : addi a5 a5 -10 
'h000000D0 : begin a5 <= $signed(a5) + $signed(-10); end
//            q |= (1U << i)
//      D4 : sll s1 t2 a2 
'h000000D4 : begin s1 <= $unsigned(t2) << a2; end
//      D8 : or t1 t1 s1 
'h000000D8 : begin t1 <= $signed(t1) | $signed(s1); end
//    for (int i = 31
//      DC : addi a2 a2 -1 
'h000000DC : begin a2 <= $signed(a2) + $signed(-1); end
//      E0 : li s1 -1 
'h000000E0 : begin s1 <= -1; end
//      E4 : bne a2 s1 B8 <itoa+#x50> 
'h000000E4 : begin if($signed(a2) != $signed(s1)) pc <= 184; end
//    // Use the absolute magnitude for division to prevent signed logic errors
//    do {
//        unsigned int rem
//        uval = _u_div_mod(uval, 10, &rem)
//        buf[i++] = (char)(rem + '0')
//      E8 : addi a1 a1 1 
'h000000E8 : begin a1 <= $signed(a1) + $signed(1); end
//      EC : addi a5 a5 30 
'h000000EC : begin a5 <= $signed(a5) + $signed(48); end
//      F0 : sb a5 0 (t0) 
'h000000F0 : begin if(!valid) begin addr = $signed(0) + $signed(t0); valid <= 1; write <= 1; size <= 0; wdata <= a5[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    } while (uval > 0)
//      F4 : addi t0 t0 1 
'h000000F4 : begin t0 <= $signed(t0) + $signed(1); end
//      F8 : bnez t1 13C <itoa+#xd4> 
'h000000F8 : begin if($signed(t1) != 0) pc <= 316; end
//      FC : mv a5 a1 
'h000000FC : begin a5 <= a1; end
//     100 : mv a4 a3 
'h00000100 : begin a4 <= a3; end
//
//    // Reverse buffer into the destination string
//    while (i > 0) {
//        *ptr++ = buf[--i]
//     104 : addi a5 a5 -1 
'h00000104 : begin a5 <= $signed(a5) + $signed(-1); end
//     108 : addi a4 a4 1 
'h00000108 : begin a4 <= $signed(a4) + $signed(1); end
//     10C : lw a2 -28 (s0) 
'h0000010C : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     110 : add a2 a2 a5 
'h00000110 : begin a2 <= $signed(a2) + $signed(a5); end
//     114 : lbu a2 0 (a2) 
'h00000114 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     118 : sb a2 -1 (a4) 
'h00000118 : begin if(!valid) begin addr = $signed(-1) + $signed(a4); valid <= 1; write <= 1; size <= 0; wdata <= a2[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    while (i > 0) {
//     11C : bnez a5 104 <itoa+#x9c> 
'h0000011C : begin if($signed(a5) != 0) pc <= 260; end
//     120 : add a3 a3 a1 
'h00000120 : begin a3 <= $signed(a3) + $signed(a1); end
//    }
//    *ptr = '\0'
//     124 : sb zero 0 (a3) 
'h00000124 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 0; wdata <= zero[7:0]; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    return s
//}
//     128 : lw ra 18 (sp) 
'h00000128 : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     12C : lw s0 14 (sp) 
'h0000012C : begin if(!valid) begin addr = $signed(20) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     130 : lw s1 10 (sp) 
'h00000130 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     134 : addi sp sp 1C 
'h00000134 : begin sp <= $signed(sp) + $signed(28); end
//     138 : ret 
'h00000138 : begin pc <= ra; end
//        uval = _u_div_mod(uval, 10, &rem)
//     13C : mv a4 t1 
'h0000013C : begin a4 <= t1; end
//     140 : j AC <itoa+#x44> 
'h00000140 : begin pc <= 172; end
//
// 0x00000144 <fprintf>:
//    return nmemb
//}
//
//// printf scanf
//
//int fprintf(void *stream, const char *fmt, ...) {
//     144 : addi sp sp -56 
'h00000144 : begin sp <= $signed(sp) + $signed(-56); end
//     148 : sw ra 24 (sp) 
'h00000148 : begin if(!valid) begin addr = $signed(36) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     14C : sw s0 20 (sp) 
'h0000014C : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     150 : sw s1 1C (sp) 
'h00000150 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     154 : addi s0 sp 28 
'h00000154 : begin s0 <= $signed(sp) + $signed(40); end
//     158 : mv t1 a0 
'h00000158 : begin t1 <= a0; end
//     15C : mv s1 a1 
'h0000015C : begin s1 <= a1; end
//     160 : sw a2 0 (s0) 
'h00000160 : begin if(!valid) begin addr = $signed(0) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     164 : sw a3 4 (s0) 
'h00000164 : begin if(!valid) begin addr = $signed(4) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     168 : sw a4 8 (s0) 
'h00000168 : begin if(!valid) begin addr = $signed(8) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     16C : sw a5 C (s0) 
'h0000016C : begin if(!valid) begin addr = $signed(12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    va_list args
//    va_start(args, fmt)
//     170 : sw s0 -28 (s0) 
'h00000170 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    int count = 0
//     174 : li a5 0 
'h00000174 : begin a5 <= 0; end
//    char tmp[12]
//
//    for (
//     178 : lbu a4 0 (s1) 
'h00000178 : begin if(!valid) begin addr = $signed(0) + $signed(s1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= {{24{1'b0}},rdata_b}; end
//     17C : bnez a4 198 <s0rintf+#x54> 
'h0000017C : begin if($signed(a4) != 0) pc <= 408; end
//            count++
//        }
//    }
//    va_end(args)
//    return count
//}
//     180 : mv a0 a5 
'h00000180 : begin a0 <= a5; end
//     184 : lw ra 24 (sp) 
'h00000184 : begin if(!valid) begin addr = $signed(36) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     188 : lw s0 20 (sp) 
'h00000188 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     18C : lw s1 1C (sp) 
'h0000018C : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     190 : addi sp sp 38 
'h00000190 : begin sp <= $signed(sp) + $signed(56); end
//     194 : ret 
'h00000194 : begin pc <= ra; end
//        if (*fmt == '%' && *(fmt + 1) == 'd') {
//     198 : li a3 25 
'h00000198 : begin a3 <= 37; end
//     19C : bne a4 a3 204 <s0rintf+#xc0> 
'h0000019C : begin if($signed(a4) != $signed(a3)) pc <= 516; end
//     1A0 : lbu a2 1 (s1) 
'h000001A0 : begin if(!valid) begin addr = $signed(1) + $signed(s1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     1A4 : li a3 64 
'h000001A4 : begin a3 <= 100; end
//     1A8 : bne a2 a3 204 <s0rintf+#xc0> 
'h000001A8 : begin if($signed(a2) != $signed(a3)) pc <= 516; end
//     1AC : sw t1 -40 (s0) 
'h000001AC : begin if(!valid) begin addr = $signed(-40) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1B0 : sw a5 -36 (s0) 
'h000001B0 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            itoa(va_arg(args, int), tmp)
//     1B4 : lw a4 -28 (s0) 
'h000001B4 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     1B8 : addi a3 a4 4 
'h000001B8 : begin a3 <= $signed(a4) + $signed(4); end
//     1BC : sw a3 -28 (s0) 
'h000001BC : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1C0 : addi a1 s0 -24 
'h000001C0 : begin a1 <= $signed(s0) + $signed(-24); end
//     1C4 : sw a1 -32 (s0) 
'h000001C4 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     1C8 : lw a0 0 (a4) 
'h000001C8 : begin if(!valid) begin addr = $signed(0) + $signed(a4); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     1CC : auipc ra 0 
'h000001CC : begin ra <= pc + (0 << 12); end
//     1D0 : jalr -356 (ra) # 68 <itoa> 
'h000001D0 : begin pc <= $signed(-356) + $signed(ra); ra <= pc + 4; end
//            char *p = tmp
//     1D4 : lw a1 -32 (s0) 
'h000001D4 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a1 <= rdata_w; end
//            while (*p) { fputc(*p++, stream)
//     1D8 : lw a5 -36 (s0) 
'h000001D8 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     1DC : lw t1 -40 (s0) 
'h000001DC : begin if(!valid) begin addr = $signed(-40) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//     1E0 : lbu a4 0 (a1) 
'h000001E0 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= {{24{1'b0}},rdata_b}; end
//     1E4 : bnez a4 1F4 <s0rintf+#xb0> 
'h000001E4 : begin if($signed(a4) != 0) pc <= 500; end
//            fmt++
//     1E8 : addi s1 s1 1 
'h000001E8 : begin s1 <= $signed(s1) + $signed(1); end
//    for (
//     1EC : addi s1 s1 1 
'h000001EC : begin s1 <= $signed(s1) + $signed(1); end
//     1F0 : j 178 <s0rintf+#x34> 
'h000001F0 : begin pc <= 376; end
//            while (*p) { fputc(*p++, stream)
//     1F4 : addi a1 a1 1 
'h000001F4 : begin a1 <= $signed(a1) + $signed(1); end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     1F8 : sw a4 0 (t1) 
'h000001F8 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            while (*p) { fputc(*p++, stream)
//     1FC : addi a5 a5 1 
'h000001FC : begin a5 <= $signed(a5) + $signed(1); end
//     200 : j 1E0 <s0rintf+#x9c> 
'h00000200 : begin pc <= 480; end
//    *(volatile unsigned int *)stream = (unsigned int)c
//     204 : sw a4 0 (t1) 
'h00000204 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            count++
//     208 : addi a5 a5 1 
'h00000208 : begin a5 <= $signed(a5) + $signed(1); end
//     20C : j 1EC <s0rintf+#xa8> 
'h0000020C : begin pc <= 492; end
//
// 0x00000210 <fscanf>:
//
//int fscanf(void *stream, const char *fmt, ...) {
//     210 : addi sp sp -52 
'h00000210 : begin sp <= $signed(sp) + $signed(-52); end
//     214 : sw ra 20 (sp) 
'h00000214 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     218 : sw s0 1C (sp) 
'h00000218 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     21C : sw s1 18 (sp) 
'h0000021C : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     220 : addi s0 sp 24 
'h00000220 : begin s0 <= $signed(sp) + $signed(36); end
//     224 : mv t1 a0 
'h00000224 : begin t1 <= a0; end
//     228 : sw a2 0 (s0) 
'h00000228 : begin if(!valid) begin addr = $signed(0) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     22C : sw a3 4 (s0) 
'h0000022C : begin if(!valid) begin addr = $signed(4) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     230 : sw a4 8 (s0) 
'h00000230 : begin if(!valid) begin addr = $signed(8) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     234 : sw a5 C (s0) 
'h00000234 : begin if(!valid) begin addr = $signed(12) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    va_list args
//    va_start(args, fmt)
//     238 : sw s0 -16 (s0) 
'h00000238 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    int count = 0
//     23C : li a5 0 
'h0000023C : begin a5 <= 0; end
//    for (
//        if (*fmt == ' ') { skip_ws(stream)
//     240 : li a4 20 
'h00000240 : begin a4 <= 32; end
//    for (
//     244 : lbu a2 0 (a1) 
'h00000244 : begin if(!valid) begin addr = $signed(0) + $signed(a1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     248 : bnez a2 264 <fscanf+#x54> 
'h00000248 : begin if($signed(a2) != 0) pc <= 612; end
//            count++
//        }
//    }
//    va_end(args)
//    return count
//}
//     24C : mv a0 a5 
'h0000024C : begin a0 <= a5; end
//     250 : lw ra 20 (sp) 
'h00000250 : begin if(!valid) begin addr = $signed(32) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) ra <= rdata_w; end
//     254 : lw s0 1C (sp) 
'h00000254 : begin if(!valid) begin addr = $signed(28) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s0 <= rdata_w; end
//     258 : lw s1 18 (sp) 
'h00000258 : begin if(!valid) begin addr = $signed(24) + $signed(sp); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= rdata_w; end
//     25C : addi sp sp 34 
'h0000025C : begin sp <= $signed(sp) + $signed(52); end
//     260 : ret 
'h00000260 : begin pc <= ra; end
//        else if (*fmt == '%' && *(++fmt) == 'd') {
//     264 : addi a3 a1 1 
'h00000264 : begin a3 <= $signed(a1) + $signed(1); end
//        if (*fmt == ' ') { skip_ws(stream)
//     268 : bne a2 a4 27C <fscanf+#x6c> 
'h00000268 : begin if($signed(a2) != $signed(a4)) pc <= 636; end
//    return (unsigned char)(*(volatile char *)stream)
//     26C : lbu a3 0 (t1) 
'h0000026C : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= {{24{1'b0}},rdata_b}; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     270 : bgeu a4 a3 26C <fscanf+#x5c> 
'h00000270 : begin if($unsigned(a4) >= $unsigned(a3)) pc <= 620; end
//    for (
//     274 : addi a1 a1 1 
'h00000274 : begin a1 <= $signed(a1) + $signed(1); end
//     278 : j 244 <fscanf+#x34> 
'h00000278 : begin pc <= 580; end
//        else if (*fmt == '%' && *(++fmt) == 'd') {
//     27C : li a0 25 
'h0000027C : begin a0 <= 37; end
//     280 : bne a2 a0 274 <fscanf+#x64> 
'h00000280 : begin if($signed(a2) != $signed(a0)) pc <= 628; end
//     284 : lbu a2 1 (a1) 
'h00000284 : begin if(!valid) begin addr = $signed(1) + $signed(a1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     288 : mv a1 a3 
'h00000288 : begin a1 <= a3; end
//     28C : li a0 64 
'h0000028C : begin a0 <= 100; end
//     290 : bne a2 a0 274 <fscanf+#x64> 
'h00000290 : begin if($signed(a2) != $signed(a0)) pc <= 628; end
//            int *dest = va_arg(args, int *)
//     294 : lw a2 -16 (s0) 
'h00000294 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     298 : addi a1 a2 4 
'h00000298 : begin a1 <= $signed(a2) + $signed(4); end
//     29C : sw a1 -16 (s0) 
'h0000029C : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2A0 : lw t0 0 (a2) 
'h000002A0 : begin if(!valid) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t0 <= rdata_w; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     2A4 : li a1 20 
'h000002A4 : begin a1 <= 32; end
//    return (unsigned char)(*(volatile char *)stream)
//     2A8 : lbu a2 0 (t1) 
'h000002A8 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//     2AC : zext.b s1 a2 
'h000002AC : begin s1 <= 32'hff & a2; end
//    while ((c = fgetc(stream)) <= ' ' && c != EOF)
//     2B0 : bge a1 a2 2A8 <fscanf+#x98> 
'h000002B0 : begin if($signed(a1) >= $signed(a2)) pc <= 680; end
//            int neg = (c == '-') ? (c = fgetc(stream), 1) : 0
//     2B4 : li a1 2D 
'h000002B4 : begin a1 <= 45; end
//     2B8 : li a2 0 
'h000002B8 : begin a2 <= 0; end
//     2BC : bne s1 a1 2CC <fscanf+#xbc> 
'h000002BC : begin if($signed(s1) != $signed(a1)) pc <= 716; end
//    return (unsigned char)(*(volatile char *)stream)
//     2C0 : lbu s1 0 (t1) 
'h000002C0 : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{24{1'b0}},rdata_b}; end
//     2C4 : zext.b s1 s1 
'h000002C4 : begin s1 <= 32'hff & s1; end
//            int neg = (c == '-') ? (c = fgetc(stream), 1) : 0
//     2C8 : li a2 1 
'h000002C8 : begin a2 <= 1; end
//            int val = 0, c = skip_ws(stream)
//     2CC : li a0 0 
'h000002CC : begin a0 <= 0; end
//            while (c >= '0' &&  0xc <= '9') {
//     2D0 : li t2 9 
'h000002D0 : begin t2 <= 9; end
//     2D4 : addi s1 s1 -48 
'h000002D4 : begin s1 <= $signed(s1) + $signed(-48); end
//     2D8 : bgeu t2 s1 2F4 <fscanf+#xe4> 
'h000002D8 : begin if($unsigned(t2) >= $unsigned(s1)) pc <= 756; end
//            *dest = neg ? -val : val
//     2DC : beqz a2 2E4 <fscanf+#xd4> 
'h000002DC : begin if($signed(a2) == 0) pc <= 740; end
//     2E0 : neg a0 a0 
'h000002E0 : begin a0 <= 0-a0; end
//     2E4 : sw a0 0 (t0) 
'h000002E4 : begin if(!valid) begin addr = $signed(0) + $signed(t0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//            count++
//     2E8 : addi a5 a5 1 
'h000002E8 : begin a5 <= $signed(a5) + $signed(1); end
//        else if (*fmt == '%' && *(++fmt) == 'd') {
//     2EC : mv a1 a3 
'h000002EC : begin a1 <= a3; end
//     2F0 : j 274 <fscanf+#x64> 
'h000002F0 : begin pc <= 628; end
//     2F4 : sw t1 -36 (s0) 
'h000002F4 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2F8 : sw a5 -32 (s0) 
'h000002F8 : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     2FC : sw a3 -28 (s0) 
'h000002FC : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     300 : sw t0 -24 (s0) 
'h00000300 : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= t0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     304 : sw a2 -20 (s0) 
'h00000304 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//                val = __mulsi3(val, 10) + (c - '0')
//     308 : li a1 A 
'h00000308 : begin a1 <= 10; end
//     30C : auipc ra 0 
'h0000030C : begin ra <= pc + (0 << 12); end
//     310 : jalr -780 (ra) # 0 <__mulsi3> 
'h00000310 : begin pc <= $signed(-780) + $signed(ra); ra <= pc + 4; end
//     314 : add a0 s1 a0 
'h00000314 : begin a0 <= $signed(s1) + $signed(a0); end
//    return (unsigned char)(*(volatile char *)stream)
//     318 : lw t1 -36 (s0) 
'h00000318 : begin if(!valid) begin addr = $signed(-36) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t1 <= rdata_w; end
//     31C : lbu s1 0 (t1) 
'h0000031C : begin if(!valid) begin addr = $signed(0) + $signed(t1); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) s1 <= {{24{1'b0}},rdata_b}; end
//     320 : zext.b s1 s1 
'h00000320 : begin s1 <= 32'hff & s1; end
//     324 : li a4 20 
'h00000324 : begin a4 <= 32; end
//     328 : li t2 9 
'h00000328 : begin t2 <= 9; end
//     32C : lw a5 -32 (s0) 
'h0000032C : begin if(!valid) begin addr = $signed(-32) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     330 : lw a3 -28 (s0) 
'h00000330 : begin if(!valid) begin addr = $signed(-28) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a3 <= rdata_w; end
//     334 : lw t0 -24 (s0) 
'h00000334 : begin if(!valid) begin addr = $signed(-24) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) t0 <= rdata_w; end
//     338 : lw a2 -20 (s0) 
'h00000338 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     33C : j 2D4 <fscanf+#xc4> 
'h0000033C : begin pc <= 724; end
//
// 0x00000340 <main>:
//#include "stdio.h"
//#include "string.h"
//#endif
//
//int main()
//{
//     340 : addi sp sp -20 
'h00000340 : begin sp <= $signed(sp) + $signed(-20); end
//     344 : sw ra 10 (sp) 
'h00000344 : begin if(!valid) begin addr = $signed(16) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     348 : sw s0 C (sp) 
'h00000348 : begin if(!valid) begin addr = $signed(12) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     34C : sw s1 8 (sp) 
'h0000034C : begin if(!valid) begin addr = $signed(8) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//     350 : addi s0 sp 14 
'h00000350 : begin s0 <= $signed(sp) + $signed(20); end
//  fprintf(stdout, "\r\nhello world\n\r> ")
//     354 : auipc a1 1 
'h00000354 : begin a1 <= pc + (1 << 12); end
//     358 : addi a1 a1 -852 # 1000 <main+#xcc0> 
'h00000358 : begin a1 <= $signed(a1) + $signed(-852); end
//     35C : auipc a0 1 
'h0000035C : begin a0 <= pc + (1 << 12); end
//     360 : lw a0 -788 (a0) # 1048 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000360 : begin if(!valid) begin addr = $signed(-788) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     364 : auipc ra 0 
'h00000364 : begin ra <= pc + (0 << 12); end
//     368 : jalr -544 (ra) # 144 <s0rintf> 
'h00000368 : begin pc <= $signed(-544) + $signed(ra); ra <= pc + 4; end
//  while(1) {
//    int a=1, b=1, c=0, l
//    fprintf(stdout, "input a limit of fibonacci\n\r> ")
//     36C : auipc a1 1 
'h0000036C : begin a1 <= pc + (1 << 12); end
//     370 : addi a1 a1 -856 # 1014 <main+#xcd4> 
'h00000370 : begin a1 <= $signed(a1) + $signed(-856); end
//     374 : auipc a0 1 
'h00000374 : begin a0 <= pc + (1 << 12); end
//     378 : lw a0 -812 (a0) # 1048 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000378 : begin if(!valid) begin addr = $signed(-812) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     37C : auipc ra 0 
'h0000037C : begin ra <= pc + (0 << 12); end
//     380 : jalr -568 (ra) # 144 <s0rintf> 
'h00000380 : begin pc <= $signed(-568) + $signed(ra); ra <= pc + 4; end
//    fscanf(stdin, "%d", &l)
//     384 : addi a2 s0 -16 
'h00000384 : begin a2 <= $signed(s0) + $signed(-16); end
//     388 : auipc a1 1 
'h00000388 : begin a1 <= pc + (1 << 12); end
//     38C : addi a1 a1 -852 # 1034 <main+#xcf4> 
'h0000038C : begin a1 <= $signed(a1) + $signed(-852); end
//     390 : auipc a0 1 
'h00000390 : begin a0 <= pc + (1 << 12); end
//     394 : lw a0 -836 (a0) # 104C <_GLOBAL_OFFSET_TABLE_+#x8> 
'h00000394 : begin if(!valid) begin addr = $signed(-836) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     398 : auipc ra 0 
'h00000398 : begin ra <= pc + (0 << 12); end
//     39C : jalr -392 (ra) # 210 <fscanf> 
'h0000039C : begin pc <= $signed(-392) + $signed(ra); ra <= pc + 4; end
//    fprintf(stdout, "%d\n", l)
//     3A0 : lw a2 -16 (s0) 
'h000003A0 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a2 <= rdata_w; end
//     3A4 : auipc a1 1 
'h000003A4 : begin a1 <= pc + (1 << 12); end
//     3A8 : addi a1 a1 -876 # 1038 <main+#xcf8> 
'h000003A8 : begin a1 <= $signed(a1) + $signed(-876); end
//     3AC : auipc a0 1 
'h000003AC : begin a0 <= pc + (1 << 12); end
//     3B0 : lw a0 -868 (a0) # 1048 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h000003B0 : begin if(!valid) begin addr = $signed(-868) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     3B4 : auipc ra 0 
'h000003B4 : begin ra <= pc + (0 << 12); end
//     3B8 : jalr -624 (ra) # 144 <s0rintf> 
'h000003B8 : begin pc <= $signed(-624) + $signed(ra); ra <= pc + 4; end
//    if(l < 0) {
//     3BC : lw a5 -16 (s0) 
'h000003BC : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a5 <= rdata_w; end
//     3C0 : bltz a5 44C <main+#x10c> 
'h000003C0 : begin if($signed(a5)  < 0) pc <= 1100; end
//    int a=1, b=1, c=0, l
//     3C4 : li s1 1 
'h000003C4 : begin s1 <= 1; end
//     3C8 : mv a5 s1 
'h000003C8 : begin a5 <= s1; end
//        b = c
//        fprintf(stdout, "%d ", a)
//      }
//    }
//    else {
//      while( 0xa < l) {
//     3CC : lw a4 -16 (s0) 
'h000003CC : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     3D0 : bge a5 a4 440 <main+#x100> 
'h000003D0 : begin if($signed(a5) >= $signed(a4)) pc <= 1088; end
//        c = a+b
//     3D4 : add a4 a5 s1 
'h000003D4 : begin a4 <= $signed(a5) + $signed(s1); end
//     3D8 : sw a4 -20 (s0) 
'h000003D8 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        a = b
//        b = c
//        fprintf(stdout, "%d ", a)
//     3DC : mv a2 s1 
'h000003DC : begin a2 <= s1; end
//     3E0 : auipc a1 1 
'h000003E0 : begin a1 <= pc + (1 << 12); end
//     3E4 : addi a1 a1 -932 # 103C <main+#xcfc> 
'h000003E4 : begin a1 <= $signed(a1) + $signed(-932); end
//     3E8 : auipc a0 1 
'h000003E8 : begin a0 <= pc + (1 << 12); end
//     3EC : lw a0 -928 (a0) # 1048 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h000003EC : begin if(!valid) begin addr = $signed(-928) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     3F0 : auipc ra 0 
'h000003F0 : begin ra <= pc + (0 << 12); end
//     3F4 : jalr -684 (ra) # 144 <s0rintf> 
'h000003F4 : begin pc <= $signed(-684) + $signed(ra); ra <= pc + 4; end
//        a = b
//     3F8 : mv a5 s1 
'h000003F8 : begin a5 <= s1; end
//        b = c
//     3FC : lw a4 -20 (s0) 
'h000003FC : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     400 : mv s1 a4 
'h00000400 : begin s1 <= a4; end
//     404 : j 3CC <main+#x8c> 
'h00000404 : begin pc <= 972; end
//        c = a+b
//     408 : add a4 a5 s1 
'h00000408 : begin a4 <= $signed(a5) + $signed(s1); end
//     40C : sw a4 -20 (s0) 
'h0000040C : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//        fprintf(stdout, "%d ", a)
//     410 : mv a2 s1 
'h00000410 : begin a2 <= s1; end
//     414 : auipc a1 1 
'h00000414 : begin a1 <= pc + (1 << 12); end
//     418 : addi a1 a1 -984 # 103C <main+#xcfc> 
'h00000418 : begin a1 <= $signed(a1) + $signed(-984); end
//     41C : auipc a0 1 
'h0000041C : begin a0 <= pc + (1 << 12); end
//     420 : lw a0 -980 (a0) # 1048 <_GLOBAL_OFFSET_TABLE_+#x4> 
'h00000420 : begin if(!valid) begin addr = $signed(-980) + $signed(a0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a0 <= rdata_w; end
//     424 : auipc ra 0 
'h00000424 : begin ra <= pc + (0 << 12); end
//     428 : jalr -736 (ra) # 144 <s0rintf> 
'h00000428 : begin pc <= $signed(-736) + $signed(ra); ra <= pc + 4; end
//        a = b
//     42C : mv a5 s1 
'h0000042C : begin a5 <= s1; end
//        b = c
//     430 : lw a4 -20 (s0) 
'h00000430 : begin if(!valid) begin addr = $signed(-20) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     434 : mv s1 a4 
'h00000434 : begin s1 <= a4; end
//      while(a > l) {
//     438 : lw a4 -16 (s0) 
'h00000438 : begin if(!valid) begin addr = $signed(-16) + $signed(s0); valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end if(ready) a4 <= rdata_w; end
//     43C : blt a4 a5 408 <main+#xc8> 
'h0000043C : begin if($signed(a4) < $signed(a5)) pc <= 1032; end
//      }
//    }
//    fprintf(stdout,"\n\r")
//     440 : auipc a1 1 
'h00000440 : begin a1 <= pc + (1 << 12); end
//     444 : addi a1 a1 -1024 # 1040 <main+#xd00> 
'h00000444 : begin a1 <= $signed(a1) + $signed(-1024); end
//     448 : j 35C <main+#x1c> 
'h00000448 : begin pc <= 860; end
//      a=-1
//     44C : li s1 -1 
'h0000044C : begin s1 <= -1; end
//     450 : mv a5 s1 
'h00000450 : begin a5 <= s1; end
//     454 : j 438 <main+#xf8> 
'h00000454 : begin pc <= 1080; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
