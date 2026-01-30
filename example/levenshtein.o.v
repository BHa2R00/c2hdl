module levenshtein (clk, rstb, setb, idle, pc, pc0, addr, size, valid, write, wdata, rdata, ready, t10, t00, a50, a40, a10, a30, a20, a00, s10, s00, ra0, sp0);
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
input [31:0] t10, t00, a50, a40, a10, a30, a20, a00, s10, s00, ra0, sp0;
wire [31:0] rdata_w = rdata >> (8*addr[1:0]);
wire [15:0] rdata_h = rdata >> (8*addr[1:0]);
wire [ 7:0] rdata_b = rdata >> (8*addr[1:0]);
reg [31:0] zero, t1, t0, a5, a4, a1, a3, a2, a0, s1, s0, ra, sp;
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
      pc <= (pc0 > 'hE4) ? 'hE4 + 4 : pc0;
      t1 <= t10;
      t0 <= t00;
      a5 <= a50;
      a4 <= a40;
      a1 <= a10;
      a3 <= a30;
      a2 <= a20;
      a0 <= a00;
      s1 <= s10;
      s0 <= s00;
      ra <= ra0;
      sp <= sp0;
      idle <= 0;
    end
    else if(!idle) begin
      pc <= (pc > 'hE4) ? 'hE4 + 4 : pc + 4;
      if(pc == ra0) idle <= 1;
      case(pc)
//
//example/levenshtein.o:     file format elf32-littleriscv
//
//
//Disassembly of section .text:
//
// 0x00000000 <levenshtein>:
//#inclu 0xde <stdio.h>
//#endif
//#inclu 0xde <string.h>
//
//int levenshtein(char* a, int a_len, char* b, int b_len)
//{
//       0 : addi sp sp -40 
'h00000000 : begin sp <= $signed(sp) + $signed(-40); end
//       4 : sw ra 24 (sp) 
'h00000004 : begin if(!valid && !ready) begin addr <= $signed(36) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= ra; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       8 : sw s0 20 (sp) 
'h00000008 : begin if(!valid && !ready) begin addr <= $signed(32) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//       C : sw s1 1C (sp) 
'h0000000C : begin if(!valid && !ready) begin addr <= $signed(28) + $signed(sp); valid <= 1; write <= 1; size <= 2; wdata <= s1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      10 : addi s0 sp 28 
'h00000010 : begin s0 <= $signed(sp) + $signed(40); end
//      14 : sw a0 -16 (s0) 
'h00000014 : begin if(!valid && !ready) begin addr <= $signed(-16) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      18 : sw a2 -20 (s0) 
'h00000018 : begin if(!valid && !ready) begin addr <= $signed(-20) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      1C : mv s1 a3 
'h0000001C : begin s1 <= a3; end
//  if(a_len ==0) return b_len
//      20 : beqz a1 D0 <levenshtein+#xd0> 
'h00000020 : begin if($signed(a1) == 0) pc <= 208; end
//      24 : mv a4 a1 
'h00000024 : begin a4 <= a1; end
//  if(b_len ==0) return a_len
//      28 : beqz a3 CC <levenshtein+#xcc> 
'h00000028 : begin if($signed(a3) == 0) pc <= 204; end
//  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1
//  int d = levenshtein(a, a_len-1, b, b_len) +1
//      2C : addi a5 a1 -1 
'h0000002C : begin a5 <= $signed(a1) + $signed(-1); end
//      30 : sw a1 -28 (s0) 
'h00000030 : begin if(!valid && !ready) begin addr <= $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a1; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      34 : sw a5 -24 (s0) 
'h00000034 : begin if(!valid && !ready) begin addr <= $signed(-24) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a5; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      38 : mv a1 a5 
'h00000038 : begin a1 <= a5; end
//      3C : auipc ra 0 
'h0000003C : begin ra <= pc + (0 << 12); end
//      40 : jalr -60 (ra) # 0 <levenshtein> 
'h00000040 : begin pc <= $signed(-60) + $signed(ra); ra <= pc + 4; end
//      44 : sw a0 -40 (s0) 
'h00000044 : begin if(!valid && !ready) begin addr <= $signed(-40) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  int i = levenshtein(a, a_len, b, b_len-1) +1
//      48 : addi a3 s1 -1 
'h00000048 : begin a3 <= $signed(s1) + $signed(-1); end
//      4C : sw a3 -36 (s0) 
'h0000004C : begin if(!valid && !ready) begin addr <= $signed(-36) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a3; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      50 : lw a2 -20 (s0) 
'h00000050 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//      54 : lw a4 -28 (s0) 
'h00000054 : begin if(!valid && !ready) begin addr <= -28 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      58 : mv a1 a4 
'h00000058 : begin a1 <= a4; end
//      5C : sw a4 -32 (s0) 
'h0000005C : begin if(!valid && !ready) begin addr <= $signed(-32) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a4; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//      60 : lw a0 -16 (s0) 
'h00000060 : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a0 <= rdata_w; end
//      64 : auipc ra 0 
'h00000064 : begin ra <= pc + (0 << 12); end
//      68 : jalr -100 (ra) # 0 <levenshtein> 
'h00000068 : begin pc <= $signed(-100) + $signed(ra); ra <= pc + 4; end
//      6C : sw a0 -28 (s0) 
'h0000006C : begin if(!valid && !ready) begin addr <= $signed(-28) + $signed(s0); valid <= 1; write <= 1; size <= 2; wdata <= a0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end end
//  int s = levenshtein(a, a_len-1, b, b_len-1) +cost
//      70 : lw a3 -36 (s0) 
'h00000070 : begin if(!valid && !ready) begin addr <= -36 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a3 <= rdata_w; end
//      74 : lw a2 -20 (s0) 
'h00000074 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a2 <= rdata_w; end
//      78 : lw a1 -24 (s0) 
'h00000078 : begin if(!valid && !ready) begin addr <= -24 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a1 <= rdata_w; end
//      7C : lw a0 -16 (s0) 
'h0000007C : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a0 <= rdata_w; end
//      80 : auipc ra 0 
'h00000080 : begin ra <= pc + (0 << 12); end
//      84 : jalr -128 (ra) # 0 <levenshtein> 
'h00000084 : begin pc <= $signed(-128) + $signed(ra); ra <= pc + 4; end
//  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1
//      88 : lw a5 -16 (s0) 
'h00000088 : begin if(!valid && !ready) begin addr <= -16 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      8C : lw a4 -32 (s0) 
'h0000008C : begin if(!valid && !ready) begin addr <= -32 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= rdata_w; end
//      90 : add a4 a5 a4 
'h00000090 : begin a4 <= $signed(a5) + $signed(a4); end
//      94 : lw a5 -20 (s0) 
'h00000094 : begin if(!valid && !ready) begin addr <= -20 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= rdata_w; end
//      98 : add a5 a5 s1 
'h00000098 : begin a5 <= $signed(a5) + $signed(s1); end
//      9C : lbu a4 -1 (a4) 
'h0000009C : begin if(!valid && !ready) begin addr <= $signed(-1) + $signed(a4); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a4 <= {{24{1'b0}},rdata_b}; end
//      A0 : lbu a5 -1 (a5) 
'h000000A0 : begin if(!valid && !ready) begin addr <= $signed(-1) + $signed(a5); valid <= 1; write <= 0; size <= 0; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) a5 <= {{24{1'b0}},rdata_b}; end
//      A4 : sub a4 a4 a5 
'h000000A4 : begin a4 <= $signed(a4) - $signed(a5); end
//      A8 : snez a4 a4 
'h000000A8 : begin a4 <= (a4 != 0) ? 1 : 0; end
//  int s = levenshtein(a, a_len-1, b, b_len-1) +cost
//      AC : add a4 a4 a0 
'h000000AC : begin a4 <= $signed(a4) + $signed(a0); end
//  int i = levenshtein(a, a_len, b, b_len-1) +1
//      B0 : lw t0 -28 (s0) 
'h000000B0 : begin if(!valid && !ready) begin addr <= -28 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) t0 <= rdata_w; end
//      B4 : addi a5 t0 1 
'h000000B4 : begin a5 <= $signed(t0) + $signed(1); end
//  if(i < d) d = i
//      B8 : lw t1 -40 (s0) 
'h000000B8 : begin if(!valid && !ready) begin addr <= -40 + s0; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) t1 <= rdata_w; end
//      BC : blt t0 t1 C4 <levenshtein+#xc4> 
'h000000BC : begin if($signed(t0) < $signed(t1)) pc <= 196; end
//  int d = levenshtein(a, a_len-1, b, b_len) +1
//      C0 : addi a5 t1 1 
'h000000C0 : begin a5 <= $signed(t1) + $signed(1); end
//  if(s < d) d = s
//      C4 : mv s1 a5 
'h000000C4 : begin s1 <= a5; end
//      C8 : bge a4 a5 D0 <levenshtein+#xd0> 
'h000000C8 : begin if($signed(a4) >= $signed(a5)) pc <= 208; end
//  if(b_len ==0) return a_len
//      CC : mv s1 a4 
'h000000CC : begin s1 <= a4; end
//  return d
//}
//      D0 : mv a0 s1 
'h000000D0 : begin a0 <= s1; end
//      D4 : lw ra 24 (sp) 
'h000000D4 : begin if(!valid && !ready) begin addr <= 36 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) ra <= rdata_w; end
//      D8 : lw s0 20 (sp) 
'h000000D8 : begin if(!valid && !ready) begin addr <= 32 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s0 <= rdata_w; end
//      DC : lw s1 1C (sp) 
'h000000DC : begin if(!valid && !ready) begin addr <= 28 + sp; valid <= 1; write <= 0; size <= 2; pc <= pc; end else if(valid && !ready) begin pc <= pc; end else if(valid && ready) begin valid <= 0; pc <= pc; end if(ready) s1 <= rdata_w; end
//      E0 : addi sp sp 28 
'h000000E0 : begin sp <= $signed(sp) + $signed(40); end
//      E4 : ret 
'h000000E4 : begin pc <= ra; end
        default : pc <= pc;
      endcase
    end
  end
end
endmodule
