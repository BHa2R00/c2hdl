module ram 
#(
  parameter MEMH = "",
  parameter SIZE = 'h100 
)
(
  output reg        ready, 
  output reg [31:0] rdata, 
   input     [31:0] wdata, 
   input            write, 
   input     [31:0] addr, 
   input     [ 1:0] size, 
   input            valid, 
   input            rstb, clk
);

//(* ramstyle = "M9K" *) 
//(* ram_style = "block" *) 
reg [31:0] mem[0:(SIZE>>2)-1];
wire [31:0] addr1 = addr>>2;
wire [3:0] be = (size==2 ? 4'b1111 : size==1 ? 4'b0011 : 4'b0001) << addr[1:0];
wire [31:0] wdata1 = wdata << (8*addr[1:0]);
reg [31:0] rdata1;
initial begin $readmemh(MEMH,mem); end
always@(posedge clk) begin
  if(valid && write) begin
    if(be[0]) mem[addr1][ 7: 0] <= wdata1[ 7: 0];
    if(be[1]) mem[addr1][15: 8] <= wdata1[15: 8];
    if(be[2]) mem[addr1][23:16] <= wdata1[23:16];
    if(be[3]) mem[addr1][31:24] <= wdata1[31:24];
  end
  rdata1 <= mem[addr1];
end
always@(*) begin
  rdata = rdata1 >> (8*addr[1:0]);
end

always@(negedge rstb or posedge clk) begin
  if(~rstb) begin
    ready <= 1'b0;
  end
  else begin
    ready <= valid;
  end
end

endmodule
