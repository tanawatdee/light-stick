module LFSR    (
out             ,  // Output of the counter
enable          ,  // Enable  for counter
clk             ,  // clock input
reset              // reset input
);

//----------Output Ports--------------
output [7:0] out;
//------------Input Ports--------------
input [7:0] data;
input enable, clk, reset;
//------------Internal Variables--------
reg [7:0] out = 8'b0;
wire        linear_feedback;

//-------------Code Starts Here-------
assign linear_feedback = !(out[7] ^ out[3]);

always @(posedge clk)
if (reset) begin // active high reset
  out <= 8'b0 ;
end else if (enable) begin
  out <= {out[6],out[5],
          out[4],out[3],
          out[2],out[1],
          out[0], linear_feedback};
end 

endmodule // End Of Module counter

module CLK(input internal_clk,output clock_play,clock_pwn, output wire[7:0] rand_num);
  reg[19:0]state;
  reg[23:0]state2;
  reg elapsed;
  reg elapsed2;

  LFSR L1(rand_num, 1'b1, elapsed2, 1'b0);

  always @(posedge internal_clk)
    begin
      if (state == 1000000)
        state <= 1;
      else
        state <= state+1;
      if (state2 == 12500000)
        state2 <= 1;
      else
        state2 <= state2+1;
    end
  always @(state)
    begin
      if (state == 1000000)
        elapsed = 1;
      else
        elapsed = 0;
    end
  always @(state2)
    begin
      if(state2 == 12500000)
        elapsed2 = 1;
      else
        elapsed2 = 0;
    end

  assign clock_play = elapsed;
  assign clock_pwn = elapsed2;
endmodule