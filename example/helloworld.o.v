module helloworld (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0);
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
input [31:0] s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
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
      pc <= (pc0 > 'hE8) ? 'hE8 + 4 : pc0;
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
      pc <= (pc > 'hE8) ? 'hE8 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/helloworld.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <__mulsi3>:
//    while (n--) *d++ = *s++
//    return dest
//}
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
'h00000050 : begin if(!valid && !ready) begin addr = 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      54 : lw s0 0 (sp) 
'h00000054 : begin if(!valid && !ready) begin addr = 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
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
'h000000B4 : begin if(!valid && !ready) begin addr = -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a1 <= rdata_w; end
//      B8 : lw a3 -20 (s0) 
'h000000B8 : begin if(!valid && !ready) begin addr = -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//      BC : bne a5 a0 D8 <fwrite+#x58> 
'h000000BC : begin if($signed(a5) != $signed(a0)) pc <= 216; end
//        *port = data[i]
//    }
//    return nmemb
//}
//      C0 : mv a0 a1 
'h000000C0 : begin a0 <= a1; end
//      C4 : lw ra 10 (sp) 
'h000000C4 : begin if(!valid && !ready) begin addr = 16 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      C8 : lw s0 C (sp) 
'h000000C8 : begin if(!valid && !ready) begin addr = 12 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//      CC : lw s1 8 (sp) 
'h000000CC : begin if(!valid && !ready) begin addr = 8 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s1 <= rdata_w; end
//      D0 : addi sp sp 14 
'h000000D0 : begin sp <= $signed(sp) + $signed(20); end
//      D4 : ret 
'h000000D4 : begin pc <= ra; end
//        *port = data[i]
//      D8 : add a2 s1 a5 
'h000000D8 : begin a2 <= $signed(s1) + $signed(a5); end
//      DC : lbu a2 0 (a2) 
'h000000DC : begin if(!valid && !ready) begin addr = $signed(0) + $signed(a2); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a2 <= {{24{1'b0}},rdata_b}; end
//      E0 : sb a2 0 (a3) 
'h000000E0 : begin if(!valid) begin addr = $signed(0) + $signed(a3); valid <= 1; write <= 1; size <= 0; wdata <= a2[7:0]<<(8*addr[1:0]); pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; end end
//    for (size_t i = 0
//      E4 : addi a5 a5 1 
'h000000E4 : begin a5 <= $signed(a5) + $signed(1); end
//      E8 : j BC <fwrite+#x3c> 
'h000000E8 : begin pc <= 188; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
