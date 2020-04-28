`include "ROM.v"

module PLAY(
	input wire clock_play,
	input wire restart,
	input wire[3:0] song_no,
	output reg[5:0] rgb_signal = 6'b110011
);
	reg[15:0] address_temp = 16'h0000;
	reg[11:0] iTime = 12'h000;
	reg[1:0] iPhase = 2'b00;
	reg[5:0] key_msb = 6'o00;
	reg[5:0] key_lsb = 6'o00;
	reg[5:0] nColor = 6'o00;
	reg[15:0] address;
	wire[5:0] data;
	wire[11:0] keyTime;
	time seed;
	assign keyTime = {key_msb,key_lsb};

	ROM R1(address,data);

	always @(posedge clock_play) begin
		if (restart) begin
			iTime <= 12'h000;
			iPhase <= 2'b00;
			address <= {2'b00,4'b0,10'b0000000000};
			rgb_signal <= 6'b110011;
		end
		else begin
			case(iPhase)
				2'b00: begin
					key_msb <= data;
					address <= address+1;
				end
				2'b01: begin
					key_lsb <= data;
					address <= address+1;
				end
				2'b10: begin
					nColor <= data;
					address_temp <= address;
					address <= address+1;
				end
				2'b11: begin
				    if (iTime>=keyTime) begin
				        rgb_signal <= data;
                        address <= address_temp+1+nColor;
				    end
				end
			endcase

			if(keyTime==12'hfff&&iPhase==2'b11)
				iPhase <= 2'b11;
			else if (iPhase==2'b00||iPhase==2'b01||iPhase==2'b10)
				iPhase <= iPhase+1;
			else if (iTime>=keyTime)
				iPhase <= 2'b00;

			iTime <= iTime+1;
		end
	end
	reg clk=1'b0;
	reg rst=1'b1;
	integer i;
	assign clock_play = clk;
	assign restart = rst;

	initial begin
		$dumpfile("PLAY.vcd");
		$dumpvars(0, PLAY);
		#10 clk=~clk;#10 clk=~clk;#10 clk=~clk;#10 clk=~clk;#10 clk=~clk;#10 clk=~clk;#10 clk=~clk;rst=~rst;
		for(i=0;i<32'h660;i=i+1)
			#10 clk=~clk;
	end
	//A14 B15 K17
endmodule