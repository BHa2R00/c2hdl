`timescale 1ns/1ps
//`define ALTERA
`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "helloworld.o.v"


module helloworld_ep4ce10 
(
  output [7:0] debug, 
  input stdin_rx,
  output stdout_tx,
  output idle, 
  input rst, clk
);

wire rstb = ~rst;
reg setb;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    setb <= 0;
  end
  else begin
    setb <= 1;
  end
end

    wire [9:0] pc0='h1CC;
    wire [31:0] ra0='h22C+4;
    wire [31:0] sp0='h1100;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        ready;

    reg [31:0] s10, a20, a10, a40, a50, a30, a00, s00;
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
  wire [7:0] stdin_data;
tty_rx
u_stdin (
stdin_ready,
stdin_valid,
stdin_data,
stdin_rx,
rstb, clk
);
/*
reg ram_ready;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    ram_ready <= 0;
  end
  else begin
    ram_ready <= valid;
  end
end
wire [31:0] ram_wdata = wdata>>(8*addr[1:0]);
(* ramstyle = "M9K" *) reg [7:0] ram ['h0000:'h0100];
initial $readmemh("helloworld.o.memh",ram);
always@(posedge clk) begin
  if(valid) begin
    if(write) begin
      ram[{addr[31:2],2'd0}] <= ram_wdata[7:0];
      if(size>0) begin
        ram[{addr[31:2],2'd1}] <= ram_wdata[15:8];
      end
      if(size>1) begin
        ram[{addr[31:2],2'd2}] <= ram_wdata[23:16];
        ram[{addr[31:2],2'd3}] <= ram_wdata[31:24];
      end
    end
  end
end
wire [31:0] ram_rdata = {
        ram[{addr[31:2],2'd3}], 
        ram[{addr[31:2],2'd2}], 
        ram[{addr[31:2],2'd1}], 
        ram[{addr[31:2],2'd0}]
        };
*/
wire        ram_ready ;
wire [31:0] ram_rdata ;
wire [31:0] ram_wdata = wdata;
wire        ram_write = write;
wire [31:0] ram_addr  = addr -'h1000;
wire [ 1:0] ram_size  = size[1:0];
wire        ram_valid = ((addr >='h1000) && (addr <'h2000)) ? valid : 1'b0;
ram 
#(
  "helloworld.o.memh"
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

assign debug[0] = stdout_tx;
assign debug[1] = stdin_rx;
endmodule
