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

(* ram_style = "block" *) 
(* ramstyle = "M9K" *) 
reg [31:0] mem[0:(SIZE>>2)-1];
wire [31:0] addr1 = addr>>2;
wire [31:0] wdata1 = wdata << (8*addr[1:0]);
wire [31:0] mask = (size==2 ? 32'hffffffff : size==1 ? 32'hffff : 32'hff) << (addr[1:0]*8);
wire [31:0] unmask =~mask;
wire [31:0] rdata1 = mem[addr1];
wire [31:0] wdata2 = (wdata1 & mask) | (rdata1 & unmask);
initial begin $readmemh(MEMH,mem); end
always@(posedge clk) begin
  if(valid && write) begin
    mem[addr1] <= wdata2;
  end
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
