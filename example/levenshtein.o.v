module levenshtein (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, t10, t00, a40, a30, s10, a10, a20, a50, a00, s00, ra0, sp0);
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
input [31:0] t10, t00, a40, a30, s10, a10, a20, a50, a00, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
reg [31:0] zero, t1, t0, a4, a3, s1, a1, a2, a5, a0, s0, ra, sp;
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
      pc <= (pc0 > 'h124) ? 'h124 + 4 : pc0;
      t1 <= t10;
      t0 <= t00;
      a4 <= a40;
      a3 <= a30;
      s1 <= s10;
      a1 <= a10;
      a2 <= a20;
      a5 <= a50;
      a0 <= a00;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'h124) ? 'h124 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/levenshtein.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <min3>:
//#inclu 0xde <stdio.h>
//#endif
//#inclu 0xde <string.h>
//
//int min3(int a, int b, int c)
//{
//       0 : addi sp sp -8 
'h00000000 : begin sp <= $signed(sp) + $signed(-8); end
//       4 : sw ra 4 (sp) 
'h00000004 : begin if(!valid && !ready) begin addr <= $signed(4) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       8 : sw s0 0 (sp) 
'h00000008 : begin if(!valid && !ready) begin addr <= $signed(0) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       C : addi s0 sp 8 
'h0000000C : begin s0 <= $signed(sp) + $signed(8); end
//      10 : mv a5 a0 
'h00000010 : begin a5 <= a0; end
//  int m = a
//  if( 0xb < m) m = b
//  if( 0xc < m) m = c
//      14 : mv a0 a2 
'h00000014 : begin a0 <= a2; end
//      18 : blt a2 a1 20 <min3+#x20> 
'h00000018 : begin if($signed(a2) < $signed(a1)) pc <= 32; end
//      1C : mv a0 a1 
'h0000001C : begin a0 <= a1; end
//      20 : bge a5 a0 28 <min3+#x28> 
'h00000020 : begin if($signed(a5) >= $signed(a0)) pc <= 40; end
//      24 : mv a0 a5 
'h00000024 : begin a0 <= a5; end
//  return m
//}
//      28 : lw ra 4 (sp) 
'h00000028 : begin if(!valid && !ready) begin addr <= 4 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      2C : lw s0 0 (sp) 
'h0000002C : begin if(!valid && !ready) begin addr <= 0 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//      30 : addi sp sp 8 
'h00000030 : begin sp <= $signed(sp) + $signed(8); end
//      34 : ret 
'h00000034 : begin pc <= ra; end
//
// 0x00000038 <levenshtein>:
//
//int levenshtein(char* a, int a_len, char* b, int b_len)
//{
//      38 : addi sp sp -40 
'h00000038 : begin sp <= $signed(sp) + $signed(-40); end
//      3C : sw ra 24 (sp) 
'h0000003C : begin if(!valid && !ready) begin addr <= $signed(36) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      40 : sw s0 20 (sp) 
'h00000040 : begin if(!valid && !ready) begin addr <= $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      44 : sw s1 1C (sp) 
'h00000044 : begin if(!valid && !ready) begin addr <= $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      48 : addi s0 sp 28 
'h00000048 : begin s0 <= $signed(sp) + $signed(40); end
//      4C : sw a0 -16 (s0) 
'h0000004C : begin if(!valid && !ready) begin addr <= $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      50 : sw a2 -20 (s0) 
'h00000050 : begin if(!valid && !ready) begin addr <= $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      54 : mv s1 a3 
'h00000054 : begin s1 <= a3; end
//  if(a_len ==0) return b_len
//      58 : beqz a1 108 <levenshtein+#xd0> 
'h00000058 : begin if($signed(a1) == 0) pc <= 264; end
//  if(b_len ==0) return a_len
//      5C : beqz a3 120 <levenshtein+#xe8> 
'h0000005C : begin if($signed(a3) == 0) pc <= 288; end
//  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1
//  int m = min3(
//    levenshtein(a, a_len-1, b, b_len) +1, 
//      60 : addi a5 a1 -1 
'h00000060 : begin a5 <= $signed(a1) + $signed(-1); end
//      64 : sw a1 -28 (s0) 
'h00000064 : begin if(!valid && !ready) begin addr <= $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      68 : sw a5 -24 (s0) 
'h00000068 : begin if(!valid && !ready) begin addr <= $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      6C : mv a1 a5 
'h0000006C : begin a1 <= a5; end
//      70 : auipc ra 0 
'h00000070 : begin ra <= pc + (0 << 12); end
//      74 : jalr -56 (ra) # 38 <levenshtein> 
'h00000074 : begin pc <= $signed(-56) + $signed(ra); ra <= pc + 4; end
//      78 : sw a0 -40 (s0) 
'h00000078 : begin if(!valid && !ready) begin addr <= $signed(-40) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//    levenshtein(a, a_len, b, b_len-1) +1, 
//      7C : addi a3 s1 -1 
'h0000007C : begin a3 <= $signed(s1) + $signed(-1); end
//      80 : sw a3 -36 (s0) 
'h00000080 : begin if(!valid && !ready) begin addr <= $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      84 : lw a2 -20 (s0) 
'h00000084 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//      88 : lw a4 -28 (s0) 
'h00000088 : begin if(!valid && !ready) begin addr <= -28 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      8C : mv a1 a4 
'h0000008C : begin a1 <= a4; end
//      90 : sw a4 -32 (s0) 
'h00000090 : begin if(!valid && !ready) begin addr <= $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      94 : lw a0 -16 (s0) 
'h00000094 : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a0 <= rdata_w; end
//      98 : auipc ra 0 
'h00000098 : begin ra <= pc + (0 << 12); end
//      9C : jalr -96 (ra) # 38 <levenshtein> 
'h0000009C : begin pc <= $signed(-96) + $signed(ra); ra <= pc + 4; end
//      A0 : sw a0 -28 (s0) 
'h000000A0 : begin if(!valid && !ready) begin addr <= $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//    levenshtein(a, a_len-1, b, b_len-1) +cost
//      A4 : lw a3 -36 (s0) 
'h000000A4 : begin if(!valid && !ready) begin addr <= -36 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//      A8 : lw a2 -20 (s0) 
'h000000A8 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//      AC : lw a1 -24 (s0) 
'h000000AC : begin if(!valid && !ready) begin addr <= -24 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a1 <= rdata_w; end
//      B0 : lw a0 -16 (s0) 
'h000000B0 : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a0 <= rdata_w; end
//      B4 : auipc ra 0 
'h000000B4 : begin ra <= pc + (0 << 12); end
//      B8 : jalr -124 (ra) # 38 <levenshtein> 
'h000000B8 : begin pc <= $signed(-124) + $signed(ra); ra <= pc + 4; end
//  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1
//      BC : lw a5 -16 (s0) 
'h000000BC : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      C0 : lw a4 -32 (s0) 
'h000000C0 : begin if(!valid && !ready) begin addr <= -32 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      C4 : add a3 a5 a4 
'h000000C4 : begin a3 <= $signed(a5) + $signed(a4); end
//      C8 : lw a5 -20 (s0) 
'h000000C8 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      CC : add a4 a5 s1 
'h000000CC : begin a4 <= $signed(a5) + $signed(s1); end
//      D0 : lbu a5 -1 (a3) 
'h000000D0 : begin if(!valid && !ready) begin addr <= $signed(-1) + $signed(a3); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//      D4 : lbu a4 -1 (a4) 
'h000000D4 : begin if(!valid && !ready) begin addr <= $signed(-1) + $signed(a4); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= {{24{1'b0}},rdata_b}; end
//      D8 : sub a5 a5 a4 
'h000000D8 : begin a5 <= $signed(a5) - $signed(a4); end
//      DC : snez a5 a5 
'h000000DC : begin a5 <= (a5 != 0) ? 1 : 0; end
//  int m = min3(
//      E0 : add a5 a5 a0 
'h000000E0 : begin a5 <= $signed(a5) + $signed(a0); end
//      E4 : lw t0 -28 (s0) 
'h000000E4 : begin if(!valid && !ready) begin addr <= -28 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) t0 <= rdata_w; end
//      E8 : addi t0 t0 1 
'h000000E8 : begin t0 <= $signed(t0) + $signed(1); end
//  if( 0xb < m) m = b
//      EC : lw t1 -40 (s0) 
'h000000EC : begin if(!valid && !ready) begin addr <= -40 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) t1 <= rdata_w; end
//      F0 : addi t1 t1 1 
'h000000F0 : begin t1 <= $signed(t1) + $signed(1); end
//      F4 : bge t0 t1 FC <levenshtein+#xc4> 
'h000000F4 : begin if($signed(t0) >= $signed(t1)) pc <= 252; end
//      F8 : mv t1 t0 
'h000000F8 : begin t1 <= t0; end
//  if( 0xc < m) m = c
//      FC : mv s1 a5 
'h000000FC : begin s1 <= a5; end
//     100 : bge t1 a5 108 <levenshtein+#xd0> 
'h00000100 : begin if($signed(t1) >= $signed(a5)) pc <= 264; end
//     104 : mv s1 t1 
'h00000104 : begin s1 <= t1; end
//  )
//  return m
//}
//     108 : mv a0 s1 
'h00000108 : begin a0 <= s1; end
//     10C : lw ra 24 (sp) 
'h0000010C : begin if(!valid && !ready) begin addr <= 36 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//     110 : lw s0 20 (sp) 
'h00000110 : begin if(!valid && !ready) begin addr <= 32 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//     114 : lw s1 1C (sp) 
'h00000114 : begin if(!valid && !ready) begin addr <= 28 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s1 <= rdata_w; end
//     118 : addi sp sp 28 
'h00000118 : begin sp <= $signed(sp) + $signed(40); end
//     11C : ret 
'h0000011C : begin pc <= ra; end
//  if(b_len ==0) return a_len
//     120 : mv s1 a1 
'h00000120 : begin s1 <= a1; end
//     124 : j 108 <levenshtein+#xd0> 
'h00000124 : begin pc <= 264; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
