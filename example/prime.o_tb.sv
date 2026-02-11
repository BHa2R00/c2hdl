`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "prime.o.v"


module prime_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [10:0] pc0;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        ready;

    reg [31:0] s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0;
    prime dut (
        .clk   (clk),
        .rstb  (rstb),
        .setb  (setb),
        .idle  (idle),
        .ra0(ra0),
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

  wire stdout_ready;
  wire stdout_valid = (addr=='h3000) && valid && write;
  wire stdout_tx;
  wire [7:0] stdout_data = wdata;
tty_tx #(50) // 50MHz / 1MHz
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
tty_rx #(50) // 50MHz / 1MHz
u_stdin (
stdin_ready,
stdin_valid,
stdin_data,
stdin_rx,
rstb, clk
);

wire [31:0] lfsr_q;
wire        lfsr_valid = (addr =='h3008) ? valid : 1'b0;
reg         lfsr_ready;
always@(posedge clk) lfsr_ready <= lfsr_valid;
lfsr 
u_lfsr (
  .q(lfsr_q),
  .rstb(rstb), .clk(clk) 
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
  "prime.o_32.memh",
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
  (addr=='h3008) ? lfsr_ready :
  ram_ready;
assign rdata =
  (addr=='h3000) ? 0 : 
  (addr=='h3004) ? stdin_data : 
  (addr=='h3008) ? lfsr_q : 
  ram_rdata;

wire tx_empty;
reg tx_push;
reg [7:0] tx_data;
reg [8191:0] tx_mem;
reg signed [15:0] tx_k;
tty_tx #(50) // 50MHz / 1MHz
u_tx (
  tx_empty, 
  tx_push, 
  stdin_rx, 
  tx_data, 
  rstb, clk
);

task puts;
  while(tx_k>0) begin
    tx_data = tx_mem>>(8*(tx_k-1));
    tx_push = 0;
    @(posedge clk);
    tx_push = 1;
    @(posedge tx_empty);
    @(posedge clk);
    tx_push = 0;
    tx_k=tx_k-1;
    repeat(100) @(posedge clk);
  end
endtask

initial begin
  `ifdef FST
  $dumpfile("prime_tb.fst");
  $dumpvars(0,prime_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("prime_tb.fsdb");
  $fsdbDumpvars(0,prime_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  sp0 = 'h1ffc;
  pc0 = 'h650; ra0 = 4+'h744; // call main
  repeat(3) @(posedge clk); setb = 1;
  wait(stdout_data==10); wait(stdout_data==13);
  wait(stdout_data==">"); wait(stdout_data==" ");
  repeat(5) @(posedge clk);
  tx_mem = "5\n"; tx_k=2; puts;
  wait(stdout_data==10); wait(stdout_data==13);
  wait(stdout_data==">"); wait(stdout_data==" ");
  repeat(5) @(posedge clk);
  tx_mem = "55\n"; tx_k=3; puts;
  wait(idle == 1); @(posedge clk); // ret main
  $finish;
end

endmodule
