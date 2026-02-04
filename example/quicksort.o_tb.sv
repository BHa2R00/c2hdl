`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "quicksort.o.v"


module quicksort_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
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
    quicksort dut (
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
  "quicksort.o_32.memh", 
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

wire [31:0] A_p    = u_ram.mem[ 0>>2];
wire [31:0] a      = u_ram.mem[ 4>>2];
wire [31:0] a_top  = u_ram.mem[ 8>>2];
wire [31:0] i      = u_ram.mem[12>>2];
wire [31:0] j      = u_ram.mem[16>>2];
wire [31:0] x      = u_ram.mem[20>>2];
wire [31:0] pr_p   = u_ram.mem[24>>2];
wire [31:0] pr_top = u_ram.mem[28>>2];
wire [31:0] p      = u_ram.mem[32>>2];
wire [31:0] r      = u_ram.mem[36>>2];
wire [31:0] q      = u_ram.mem[40>>2];

always@(posedge ($signed(pr_top) == -1)) begin
  $write("pr_top hit\n");
end

integer k;

initial begin
  `ifdef FST
  $dumpfile("quicksort_tb.fst");
  $dumpvars(0,quicksort_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("quicksort_tb.fsdb");
  $fsdbDumpvars(0,quicksort_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h1ffc;
  u_ram.mem[24>>2] = 'h1100; // pr_p
  u_ram.mem[ 0>>2] = 'h1200; // A_p
  u_ram.mem[ 8>>2] = 0; // a_top
  $write("push\n");
  for(k=0;k<75;k=k+1) begin
    u_ram.mem[ 4>>2] = $signed($urandom_range(00,'hffffffff)); // a 
    pc0 = 'h0; ra0 = 'h40+4; // call push_a 
    repeat(3) @(posedge clk); setb = 1;
    wait(idle == 1); 
    repeat(3) @(posedge clk); setb = 0;
  end
  $write("sort\n");
  pc0 = 'h2bc; ra0 = 'h390+4; // call quicksort 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  repeat(3) @(posedge clk); setb = 0;
  u_ram.mem[ 8>>2] = u_ram.mem[ 8>>2] -1;
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
