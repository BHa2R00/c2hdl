`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "insertsort.o.v"


module insertsort_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [8:0] pc0;
    reg [31:0] sp0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    reg  [31:0] rdata;
    reg         ready;

    reg [31:0] ra0, a30, a40, a50, a00, a10, a20;
    insertsort dut (
        .clk   (clk),
        .rstb  (rstb),
        .setb  (setb),
        .idle  (idle),
        .ra0(ra0),
        .a40(a40),
        .a50(a50),
        .a00(a00),
        .pc0 (pc0),
        .sp0 (sp0),
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
  "insertsort.o_32.memh",
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

`define A_p    u_ram.mem[ 0>>2]
`define a      u_ram.mem[ 4>>2]
`define a_top  u_ram.mem[ 8>>2]
`define i      u_ram.mem[12>>2]
`define j      u_ram.mem[16>>2]
`define p      u_ram.mem[20>>2]
`define r      u_ram.mem[24>>2]
wire signed [31:0] A_p   = `A_p  ;
wire signed [31:0] a     = `a    ;
wire signed [31:0] a_top = `a_top;
wire signed [31:0] i     = `i    ;
wire signed [31:0] j     = `j    ;
wire signed [31:0] p     = `p    ;
wire signed [31:0] r     = `r    ;

always@(posedge ($signed(`r) == 0)) begin
  $write("r hit\n");
end

integer k;

initial begin
  `ifdef FST
  $dumpfile("insertsort_tb.fst");
  $dumpvars(0,insertsort_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("insertsort_tb.fsdb");
  $fsdbDumpvars(0,insertsort_tb);
  `endif
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h1ffc;
  `A_p = 'h1200;
  `a_top = 0;
  $write("push\n");
  for(k=0;k<75;k=k+1) begin
    `a = $signed($urandom_range(00,'hffffffff));
    pc0 = 'h0; ra0 = 'h40+4; // call push_a 
    repeat(3) @(posedge clk); setb = 1;
    wait(idle == 1); 
    repeat(3) @(posedge clk); setb = 0;
  end
  $write("sort\n");
  pc0 = 'h16c; ra0 = 'h1f4+4; // call insertsort 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  repeat(3) @(posedge clk); setb = 0;
  `a_top = `a_top -1;
  $write("pop\n");
  for(k=0;k<75;k=k+1) begin
    pc0 = 'h44; ra0 = 'h84+4; // call pop_a 
    repeat(3) @(posedge clk); setb = 1;
    wait(idle == 1); 
    repeat(3) @(posedge clk); setb = 0;
  end
  $finish;
end

endmodule
