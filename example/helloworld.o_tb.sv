`timescale 1ns/1ps

`include "../rtl/stdio.sv"
`include "helloworld.o.v"


module helloworld_tb;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rstb = 0;
    reg setb = 0;
    wire idle;

    reg [8:0] pc0;

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


reg ram_ready;
reg [31:0] ram_rdata;
always @(posedge clk or negedge rstb) begin
    if(!rstb) begin
      ram_ready <= 0;
    end else begin
      ram_ready <= valid;
      if (valid) begin
        if (write) begin
            case(size)
              0 : ram[addr] <= wdata>>(8*addr[1:0]);
              1 : {ram[addr+1],ram[addr]} <= wdata>>(8*addr[1:0]);
              2 : {ram[addr+3],ram[addr+2],ram[addr+1],ram[addr]} <= wdata>>(8*addr[1:0]);
            endcase
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
  (addr=='h3004) ? stdin_ready :
  ram_ready;
assign rdata =
  (addr=='h3000) ? 0 : 
  (addr=='h3004) ? stdin_data : 
  ram_rdata;

wire [703:0] a = {
  ram['h1100+00],ram['h1100+01],ram['h1100+02],ram['h1100+03],
  ram['h1100+04],ram['h1100+05],ram['h1100+06],ram['h1100+07],
  ram['h1100+08],ram['h1100+09],ram['h1100+10],ram['h1100+11],
  ram['h1100+12],ram['h1100+13],ram['h1100+14],ram['h1100+15],
  ram['h1100+16],ram['h1100+17],ram['h1100+18],ram['h1100+19],
  ram['h1100+20],ram['h1100+21]
  };

wire tx_empty;
reg tx_push;
reg [7:0] tx_data;
reg [8191:0] tx_mem;
reg signed [15:0] tx_k;
tty_tx
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
  end
    tx_data = 'h0d;
    tx_push = 0;
    @(posedge clk);
    tx_push = 1;
    @(posedge tx_empty);
    @(posedge clk);
    tx_push = 0;
endtask

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
  a30 = 'h3000; // &stream -> stdout
  sp0 = 'h2000;
  {
  ram['h1100+00],ram['h1100+01],ram['h1100+02],ram['h1100+03],
  ram['h1100+04],ram['h1100+05],ram['h1100+06],ram['h1100+07],
  ram['h1100+08],ram['h1100+09],ram['h1100+10],ram['h1100+11],
  ram['h1100+12],ram['h1100+13],ram['h1100+14],ram['h1100+15],
  ram['h1100+16],ram['h1100+17],ram['h1100+18],ram['h1100+19],
  ram['h1100+20],ram['h1100+21]
  } = "shit! urmom is so fat\n";
  pc0 = 'h80; ra0 = 'he8+4; // call fwrite
  repeat(3) @(posedge clk); setb = 1;
  wait(idle == 1); @(posedge clk); // ret fwrite
  repeat(3) @(posedge clk); setb = 0;
  a20 = 15; // nmemb 
  a30 = 'h3004; // &stream -> stdin
  pc0 = 'hec; ra0 = 'h150+4; // call fread
  repeat(3) @(posedge clk); setb = 1;
  tx_mem = "AYO! what's up\n"; tx_k=15; puts;
  wait(idle == 1); @(posedge clk); // ret fread
  repeat(3) @(posedge clk); setb = 0;
  $finish;
end

endmodule
