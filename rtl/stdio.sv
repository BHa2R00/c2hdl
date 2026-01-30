module tty_tx
(
  output reg ready, 
  input valid, 
  output reg tx, 
  input [7:0] data, 
  input rstb, clk
);
reg [3:0] cst;
reg [15:0] cnt;
reg [9:0] buffer;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    cnt <= 0;
    cst <= 0;
    buffer <= {10{1'b1}};
    tx <= 1;
    ready <= 0;
  end
  else begin
    ready <= 0;
    if(|cst) begin
      if(~|cnt) begin
        //cnt <= 50; // 50MHz clk / 1MHz baud 
        //cnt <= 200; // 200MHz clk / 1MHz baud 
        cnt <= 400; // 200MHz clk / 500KHz baud 
        cst <= cst - 1;
        buffer <= {1'b1,buffer[9:1]};
        if(cst == 1) begin
          ready <= valid;
          `ifdef SIM
          $write("%c", data);
          `endif
        end
      end
      else cnt <= cnt - 1;
      tx <= buffer[0];
    end
    else if(valid) begin
      cst <= 11;
      buffer <= {data,2'b01};
      cnt <= 0;
      tx <= 1;
    end
  end
end
endmodule


module tty_rx
(
  output reg ready, 
  input valid, 
  output [7:0] data, 
  input rx, 
  input rstb, clk 
);
reg [3:0] cst;
reg [15:0] cnt;
reg [8:0] buffer;
reg [1:0] rx_d;
always@(negedge rstb or posedge clk) begin
  if(!rstb) begin
    rx_d <= 2'b11;
    cnt <= 0;
    cst <= 0;
    ready <= 0;
  end
  else begin
    ready <= 0;
    rx_d <= {rx_d[0],rx};
    if(cst==0) begin
      if(rx_d==2'b10) begin
        //cnt <= 75; // 50MHz clk / 1MHz baud * 1.5 
        //cnt <= 300; // 200MHz clk / 1MHz baud * 1.5 
        cnt <= 600; // 200MHz clk / 500KHz baud * 1.5 
        cst <= 10;
      end
    end
    else if(cst==1) begin
      if(valid && (buffer[8]==1)) begin
        cst <= 0;
        ready <= 1;
      end
    end
    else begin
      if(~|cnt) begin
        //cnt <= 50; // 50MHz clk / 1MHz baud 
        //cnt <= 200; // 200MHz clk / 1MHz baud 
        cnt <= 400; // 200MHz clk / 500KHz baud 
        cst <= cst - 1;
        buffer <= {rx_d[1],buffer[8:1]};
      end
      else cnt <= cnt - 1;
    end
  end
end
assign data = buffer[7:0];
endmodule
