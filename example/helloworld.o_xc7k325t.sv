`timescale 1ns/1ps

`include "../rtl/ram.sv"
`include "../rtl/stdio.sv"
`include "helloworld.o.v"

module helloworld_xc7k325t 
(
  output [1:0] debug, 
  input stdin_rx,
  output stdout_tx,
  output idle, 
  input rst, clk_p, clk_n
);

wire rstb = ~rst;
wire clk;
IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) u_clk ( .O(clk), .I(clk_p), .IB(clk_n));

reg setb;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    setb <=0;
  end
  else begin
    setb <=1;
  end
end
wire [10:0] pc0 = 'h340;
wire [31:0] ra0 = 4+'h454;
wire [31:0] sp0 = 'h1ffc;

    wire [31:0] addr;
    wire [2:0] size;
    wire        valid;
    wire        write;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        ready;

    helloworld dut (
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
  wire [7:0] stdout_data = wdata[7:0];
tty_tx #(400) // 200MHz / 500KHz 
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
tty_rx #(400) // 200MHz / 500KHz
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
  "helloworld.o_32.memh",
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

assign debug[0] = stdout_tx;
assign debug[1] = stdin_rx;

endmodule
