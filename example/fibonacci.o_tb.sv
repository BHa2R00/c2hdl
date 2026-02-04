`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "fibonacci.o.v"


module fibonacci_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [7:0] pc0;
    reg [31:0] sp0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        ready;

    reg [31:0] ra0, a30, a40, a50, a00, a10, a20;
    fibonacci dut (
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
  "fibonacci.o_32.memh"
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

wire [31:0] a = u_ram.mem[ 0>>2];
wire [31:0] b = u_ram.mem[ 4>>2];
wire [31:0] c = u_ram.mem[ 8>>2];
wire [31:0] k = u_ram.mem[12>>2];

initial begin
  `ifdef FST
  $dumpfile("fibonacci_tb.fst");
  $dumpvars(0,fibonacci_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("fibonacci_tb.fsdb");
  $fsdbDumpvars(0,fibonacci_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h1100;
  pc0 = 'h40;ra0 = 'h88+4;
  u_ram.mem[ 0>>2] = 1;
  u_ram.mem[ 4>>2] = 1;
  u_ram.mem[ 8>>2] = 0;
  u_ram.mem[12>>2] = 16;
  repeat(3) @(posedge clk); setb = 0;
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
