`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
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

wire        ram_ready ;
wire [31:0] ram_rdata ;
wire [31:0] ram_wdata = wdata;
wire        ram_write = write;
wire [31:0] ram_addr  = addr -'h1000;
wire [ 1:0] ram_size  = size[1:0];
wire        ram_valid = ((addr >='h1000) && (addr <'h2000)) ? valid : 1'b0;
ram 
#(
  "levenshtein.o_32.memh",
  'h1000
)
u_ram (
  ram_ready, 
  ram_rdata, 
  ram_wdata, 
  ram_write, 
  ram_addr , 
  ram_size , 
  ram_valid, 
  rstb, clk
);

assign ready = 
  ram_ready;
assign rdata =
  ram_rdata;

`define a u_ram.mem['h100>>2]
`define b {u_ram.mem['h204>>2],u_ram.mem['h200>>2]}
`define c {u_ram.mem['h304>>2],u_ram.mem['h300>>2]}
wire [31:0] a = `a;
wire [63:0] b = `b;
wire [63:0] c = `c;

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
  `a = "shit";
  `b = "urmom";
  `c = "Shit!";
  a00 = 'h1100; // a_p
  a10 = 4; // a_len
  a20 = 'h1200; // b_p
  a30 = 5; // b_len
  pc0 = 'h0; ra0 = 'he4+4; // call levenshtein 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1);
  $write("d(%s,%s) = %d\n", a, b, dut.a0);
  @(posedge clk); // ret levenshtein
  repeat(3) @(posedge clk); setb = 0;
  a20 = 'h1300; // b_p
  a30 = 5; // b_len
  pc0 = 'h0; ra0 = 'he4+4; // call levenshtein 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1);
  $write("d(%s,%s) = %d\n", a, c, dut.a0);
  @(posedge clk); // ret levenshtein
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
