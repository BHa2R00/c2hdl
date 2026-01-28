`timescale 1ns/1ps
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
    reg  [31:0] rdata;
    reg         ready;

    reg [ 7:0] ram ['h1000:'h2000];
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

    integer i;
    wire [31:0] addr1 = addr >> 2;

always @(posedge clk or negedge rstb) begin
    if(!rstb) begin
      ready <= 0;
    end else begin
      ready <= valid;
        if (valid) begin
            if (write) begin
                ram[addr] <= wdata[7:0];
                if(size >= 1) ram[addr+1] <= wdata[15:8];
                if(size == 2) begin
                    ram[addr+2] <= wdata[23:16];
                    ram[addr+3] <= wdata[31:24];
                end
            end
            rdata <= {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr]};
        end
    end
end

wire [31:0] a = {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]};
wire [31:0] b = {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]};
wire [31:0] c = {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]};
wire [31:0] k = {ram[a00+15],ram[a00+14],ram[a00+13],ram[a00+12]};

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
  sp0 = 'h2000;
  pc0 = 'h40;ra0 = 'h88+4;
  {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]} = 1;
  {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]} = 1;
  {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]} = 0;
  {ram[a00+15],ram[a00+14],ram[a00+13],ram[a00+12]} = 16;
  repeat(3) @(posedge clk); setb = 0;
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); 
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
