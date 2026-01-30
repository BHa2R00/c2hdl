`timescale 1ns/1ps

`include "../hw.sv"
`include "helloworld.o.v"


module helloworld_tb;

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
    wire [31:0] rdata;
    wire        ready;

    reg [ 7:0] ram ['h1000:'h2000];
    reg [31:0] s10, a20, a10, a40, a50, a30, a00, s00, ra0, sp0;
    helloworld dut (
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

reg ram_ready;
reg [31:0] ram_rdata;
always @(posedge clk or negedge rstb) begin
    if(!rstb) begin
      ram_ready <= 0;
    end else begin
      ram_ready <= valid;
      if (valid) begin
        if (write) begin
            ram[addr] <= wdata[7:0];
            if(size >= 1) ram[addr+1] <= wdata[15:8];
            if(size == 2) begin
                ram[addr+2] <= wdata[23:16];
                ram[addr+3] <= wdata[31:24];
            end
        end
        else begin
          ram_rdata <= {
            ram[{addr[31:2],2'd3}], 
            ram[{addr[31:2],2'd2}], 
            ram[{addr[31:2],2'd1}], 
            ram[{addr[31:2],2'd0}]
            };
        end
      end
    end
end

assign ready = 
  (addr=='h3000) ? stdout_ready :
  ram_ready;
assign rdata =
  (addr=='h3000) ? 0 : 
  ram_rdata;

wire [703:0] a = {
  ram['h1100+00],ram['h1100+01],ram['h1100+02],ram['h1100+03],
  ram['h1100+04],ram['h1100+05],ram['h1100+06],ram['h1100+07],
  ram['h1100+08],ram['h1100+09],ram['h1100+10],ram['h1100+11],
  ram['h1100+12],ram['h1100+13],ram['h1100+14],ram['h1100+15],
  ram['h1100+16],ram['h1100+17],ram['h1100+18],ram['h1100+19],
  ram['h1100+20],ram['h1100+21]
  };
reg signed [31:0] d;

initial begin
  `ifdef FST
  $dumpfile("helloworld_tb.fst");
  $dumpvars(0,helloworld_tb);
  `endif
  `ifdef FSDB
  $fsdbDumpfile("helloworld_tb.fsdb");
  $fsdbDumpvars(0,helloworld_tb);
  `endif
  rstb = 0;
  setb = 0;
  #20 rstb = 1;
  a00 = 'h1100; // &ptr
  a10 = 1; // size
  a20 = 22; // nmemb 
  a30 = 'h3000; // &stream -> stdio
  sp0 = 'h2000;
  {
  ram['h1100+00],ram['h1100+01],ram['h1100+02],ram['h1100+03],
  ram['h1100+04],ram['h1100+05],ram['h1100+06],ram['h1100+07],
  ram['h1100+08],ram['h1100+09],ram['h1100+10],ram['h1100+11],
  ram['h1100+12],ram['h1100+13],ram['h1100+14],ram['h1100+15],
  ram['h1100+16],ram['h1100+17],ram['h1100+18],ram['h1100+19],
  ram['h1100+20],ram['h1100+21]
  } = "shit! urmom is so fat\n";
  pc0 = 'h80; ra0 = 'he8+4; // call helloworld 
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); d = dut.a0; @(posedge clk); // ret helloworld
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
