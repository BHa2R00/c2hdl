`timescale 1ns/1ps
`include "tea.o.v"


module tea_tb;

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

    reg [ 7:0] ram ['h1000:'h2000];
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
            rdata <= {ram[{addr[31:2],2'd3}], ram[{addr[31:2],2'd2}], ram[{addr[31:2],2'd1}], ram[{addr[31:2],2'd0}]};
        end
    end
end

wire [31:0] round = {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]};
wire [31:0] dat_p = {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]};
wire [31:0] key_p = {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]};
wire [31:0] dat = {
  ram['h1100+00],ram['h1100+01],
  ram['h1100+02],ram['h1100+03]
  };
wire [63:0] key = {
  ram['h1200+01],ram['h1200+00],
  ram['h1200+03],ram['h1200+02],
  ram['h1200+05],ram['h1200+04],
  ram['h1200+07],ram['h1200+06]
  };

initial begin
  `ifdef FST
  $dumpfile("tea_tb.fst");
  $dumpvars(0,tea_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("tea_tb.fsdb");
  $fsdbDumpvars(0,tea_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1000;
  sp0 = 'h2000;
  {ram[a00+ 3],ram[a00+ 2],ram[a00+ 1],ram[a00+ 0]} = 10;
  {ram[a00+ 7],ram[a00+ 6],ram[a00+ 5],ram[a00+ 4]} = 'h1100+00;
  {ram[a00+11],ram[a00+10],ram[a00+ 9],ram[a00+ 8]} = 'h1200+00;
  {
  ram['h1100+00],ram['h1100+01],
  ram['h1100+02],ram['h1100+03]
  } = "shit";
  {
  ram['h1200+01],ram['h1200+00],
  ram['h1200+03],ram['h1200+02],
  ram['h1200+05],ram['h1200+04],
  ram['h1200+07],ram['h1200+06]
  } = {16'h1234,16'h5678,16'h9ABC,16'hDEF1};
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
