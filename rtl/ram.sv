module ram 
#(
  parameter MEMH = ""
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

`ifdef ALTERA
wire [3:0] be = (size==2 ? 4'b1111 : size==1 ? 4'b0011 : 4'b0001) << addr[1:0];
wire [31:0] q;
wire [31:0] wdata1 = wdata << (8*addr[1:0]);
altsyncram	altsyncram_component (
			.address_a ((addr>>2)&((1<<8)-1)),
			.clock0 (clk),
			.q_a (q),
			.aclr0 (1'b0),
			.addressstall_a (1'b0),
      .byteena_a (be),
			.clocken0 (1'b1),
			.data_a (wdata1),
			.rden_a (valid),
			.wren_a (valid && write)
      );
defparam
  altsyncram_component.byte_size = 8,
  altsyncram_component.width_byteena_a = 4,
  altsyncram_component.address_aclr_a = "NONE",
  altsyncram_component.clock_enable_input_a = "BYPASS",
  altsyncram_component.clock_enable_output_a = "BYPASS",
  altsyncram_component.init_file = MEMH,
	altsyncram_component.intended_device_family = "Cyclone IV E",
	altsyncram_component.lpm_type = "altsyncram",
	altsyncram_component.numwords_a = 256,
	altsyncram_component.operation_mode = "SINGLE_PORT",
  altsyncram_component.outdata_aclr_a = "NONE",
	altsyncram_component.outdata_reg_a = "UNREGISTERED",
	//altsyncram_component.outdata_reg_a = "CLOCK0",
	altsyncram_component.widthad_a = 8,
	altsyncram_component.width_a = 32;
always@(posedge clk) rdata = q >> (8*addr[1:0]);
`else
reg [7:0] mem[0:'h100];
wire [3:0] be = (size==2 ? 4'b1111 : size==1 ? 4'b0011 : 4'b0001) << addr[1:0];
wire [31:0] wdata1 = wdata << (8*addr[1:0]);
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    $readmemh(MEMH,mem);
  end
  else begin
    if(valid) begin
      if(write) begin
        if(be[0]) mem[{addr[31:2],2'h0}] <= wdata1[ 7: 0];
        if(be[1]) mem[{addr[31:2],2'h1}] <= wdata1[15: 8];
        if(be[2]) mem[{addr[31:2],2'h2}] <= wdata1[23:16];
        if(be[3]) mem[{addr[31:2],2'h3}] <= wdata1[31:24];
      end
    end
  end
end
always@(negedge rstb or posedge clk) begin
  if(~rstb) begin
    rdata <= 0;
  end
  else if(&{valid}) begin
    rdata <= {
    mem[{addr[31:2],2'h3}],
    mem[{addr[31:2],2'h2}],
    mem[{addr[31:2],2'h1}],
    mem[{addr[31:2],2'h0}]
    } >> (8*addr[1:0]);
  end
end
`endif
always@(negedge rstb or posedge clk) begin
  if(~rstb) begin
    ready <= 1'b0;
  end
  else begin
    ready <= valid;
  end
end

endmodule
