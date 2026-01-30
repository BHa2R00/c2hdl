`timescale 1ns/1ps
`include "levenshtein.o.v"


module levenshtein_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [7:0] pc0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    reg  [31:0] rdata;
    reg         ready;

    reg [ 7:0] ram ['h1000:'h2000];
    reg  [31:0] t10, t00, a40, a30, s10, a10, a20, a50, a00, s00, ra0, sp0;
    levenshtein dut (
        .clk   (clk),
        .rstb  (rstb),
        .setb  (setb),
        .idle  (idle),
        .ra0(ra0),
        .a40(a40),
        .a30(a30),
        .a20(a20),
        .a10(a10),
        .a00(a00),
        .pc0 (pc0),
        .sp0 (sp0),
        .s00 (s00),
        .addr  (addr),
        .size  (size),
        .valid (valid),
        .write (write),
        .wdata (wdata),
        .rdata (rdata),
        .ready (ready)
    );

    wire [31:0] addr1 = addr >> 2;

always @(posedge clk or negedge rstb) begin
    if(!rstb) begin
      ready <= 0;
    end else begin
      ready <= valid;
        if (valid) begin
            if (write) begin
                case(size)
                  0 : ram[addr] <= wdata>>(8*addr[1:0]);
                  1 : {ram[addr+1],ram[addr]} <= wdata>>(8*addr[1:0]);
                  2 : {ram[addr+3],ram[addr+2],ram[addr+1],ram[addr]} <= wdata>>(8*addr[1:0]);
                endcase
            end
            else begin
              rdata <= {
                ram[{addr[31:2],2'd3}], 
                ram[{addr[31:2],2'd2}], 
                ram[{addr[31:2],2'd1}], 
                ram[{addr[31:2],2'd0}]
                };
            end
        end
    end
end

wire [31:0] a = {
  ram['h1100+00],ram['h1100+01],
  ram['h1100+02],ram['h1100+03]
  };
wire [39:0] b = {
  ram['h1200+00],ram['h1200+01],
  ram['h1200+02],ram['h1200+03],
  ram['h1200+04]
  };
wire [39:0] c = {
  ram['h1300+00],ram['h1300+01],
  ram['h1300+02],ram['h1300+03],
  ram['h1300+04]
  };
reg signed [31:0] d;

initial begin
  `ifdef FST
  $dumpfile("levenshtein_tb.fst");
  $dumpvars(0,levenshtein_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("levenshtein_tb.fsdb");
  $fsdbDumpvars(0,levenshtein_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  sp0 = 'h2000;
  {
  ram['h1100+00],ram['h1100+01],
  ram['h1100+02],ram['h1100+03]
  } = "shit";
  {
  ram['h1200+00],ram['h1200+01],
  ram['h1200+02],ram['h1200+03],
  ram['h1200+04]
  } = "urmom";
  {
  ram['h1300+00],ram['h1300+01],
  ram['h1300+02],ram['h1300+03],
  ram['h1300+04]
  } = "Shit!";
  a00 = 'h1100; // a_p
  a10 = 4; // a_len
  a20 = 'h1200; // b_p
  a30 = 5; // b_len
  pc0 = 'h0; ra0 = 'he4+4; // call levenshtein 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); d = dut.a0; @(posedge clk); // ret levenshtein
  $write("d(%s,%s) = %d\n", a, b, d);
  repeat(3) @(posedge clk); setb = 0;
  a20 = 'h1300; // b_p
  a30 = 5; // b_len
  pc0 = 'h0; ra0 = 'he4+4; // call levenshtein 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); d = dut.a0; @(posedge clk); // ret levenshtein
  $write("d(%s,%s) = %d\n", a, c, d);
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
