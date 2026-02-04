`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "tea.o.v"


module tea_tb;

    reg clk;
    always #5 clk = ~clk;

    reg rstb;
    reg setb;
    wire idle;

    reg [9:0] pc0;
    reg [31:0] sp0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    reg  [31:0] rdata;
    reg         ready;

    reg [31:0] ra0, a30, a40, a50, a00, a10, a20;
    tea dut (
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
  "tea.o_32.memh"
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

wire [31:0] round = u_ram.mem[0>>2];
wire [31:0] dat_p = u_ram.mem[4>>2];
wire [31:0] key_p = u_ram.mem[8>>2];
wire [31:0] dat = u_ram.mem['h10>>2];
wire [63:0] key = {u_ram.mem['h24>>2],u_ram.mem['h20>>2]};

initial begin
  `ifdef FST
  $dumpfile("tea_tb.fst");
  $dumpvars(0,tea_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("tea_tb.fsdb");
  $fsdbDumpvars(0,tea_tb);
  `endif
  clk = 0;
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h1100;
  u_ram.mem[0>>2] = 10;
  u_ram.mem[4>>2] = 'h1010;
  u_ram.mem[8>>2] = 'h1020;
  {u_ram.mem[a00+11],u_ram.mem[a00+10],u_ram.mem[a00+ 9],u_ram.mem[a00+ 8]} = 'h1200+00;
  u_ram.mem['h10>>2] = "shit";
  {u_ram.mem['h24>>2],u_ram.mem['h20>>2]} = {16'h1234,16'h5678,16'h9ABC,16'hDEF1};
  $write("plain = %s\n", dat);
  pc0 = 'h80; ra0 = 'h160+4;
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  $write("ciper = %x , %s\n", dat, dat);
  repeat(3) @(posedge clk); setb = 0;
  pc0 = 'h164; ra0 = 'h27c+4;
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  $write("plain = %s\n", dat);
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
