`timescale 1ns/1ps
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

    reg [ 7:0] ram ['h1000:'h2000];
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
            rdata <= {ram[{addr[31:2],2'd3}], ram[{addr[31:2],2'd2}], ram[{addr[31:2],2'd1}], ram[{addr[31:2],2'd0}]};
        end
    end
end

wire [31:0] A_p    = {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]};
wire [31:0] a      = {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]};
wire [31:0] a_top  = {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]};
wire [31:0] i      = {ram[a00+15],ram[a00+14],ram[a00+13],ram[a00+12]};
wire [31:0] j      = {ram[a00+19],ram[a00+18],ram[a00+17],ram[a00+16]};
wire [31:0] p      = {ram[a00+23],ram[a00+22],ram[a00+21],ram[a00+20]};
wire [31:0] r      = {ram[a00+27],ram[a00+26],ram[a00+25],ram[a00+24]};

always@(posedge ($signed(r) == 0)) begin
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
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h2000;
  {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]} = 'h1200; // A_p
  {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]} = 0; // a_top
  $write("push\n");
  for(k=0;k<75;k=k+1) begin
    {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]} = $signed($urandom_range(00,'hffffffff)); // a 
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
  {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]} = {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]} -1;
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
