`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "binarysearch.o.v"


module binarysearch_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [6:0] pc0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        ready;

reg [31:0] a20, a30, a50, a00, a10, a40, s00, ra0, sp0;
    binarysearch dut (
        .clk   (clk),
        .rstb  (rstb),
        .setb  (setb),
        .idle  (idle),
        .ra0(ra0),
        .a50(a50),
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

  wire stdout_ready;
  wire stdout_valid = (addr=='h3000) && valid && write;
  wire stdout_tx;
  wire [7:0] stdout_data = wdata[7:0];
tty_tx
u_stdout (
stdout_ready,
stdout_valid,
stdout_tx,
stdout_data,
rstb, clk
);


  wire stdin_ready;
  wire stdin_valid = (addr=='h3004) && valid && ~write;
  wire stdin_rx;
  wire [7:0] stdin_data;
tty_rx
u_stdin (
stdin_ready,
stdin_valid,
stdin_data,
stdin_rx,
rstb, clk
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
  "binarysearch.o_32.memh",
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
  (addr=='h3000) ? stdout_ready :
  (addr=='h3004) ? stdin_ready :
  ram_ready;
assign rdata =
  (addr=='h3000) ? 0 : 
  (addr=='h3004) ? stdin_data : 
  ram_rdata;

integer k, j;
initial begin
  `ifdef FST
  $dumpfile("binarysearch_tb.fst");
  $dumpvars(0,binarysearch_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("binarysearch_tb.fsdb");
  $fsdbDumpvars(0,binarysearch_tb);
  `endif
  j=-5000;
  for(k=0;k<100;k=k+1) begin
    u_ram.mem[k] = j;
    $write("%5d : %5d", k, j); if(k%8==7) $write("\n");
    j= j+$urandom_range(0,'hff);
  end
  j=(j-5000)/2;
  #20 rstb = 1;
  a00 = 'h1000; // A[]
  a10 = 0; // size
  a20 = 100; // size
  a30 = j; // target 
  sp0 = 'h1ffc;
  pc0 = 'h0; ra0 = 'h50+4; // call binarysearch
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  k=dut.a0; 
  @(posedge clk); // ret binarysearch
  $write("\nsearch(%5d) = %5d : %5d\n", j, k, u_ram.mem[k]);
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
