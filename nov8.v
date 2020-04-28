module fns(input clk, input rst, output[3:0] state);
	reg[3:0] state;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state = 4'b0000;
		end
		else begin
			case(state)
				4'b0000: state = 4'b0001;
				4'b0001: state = 4'b0010;
				4'b0010: state = 4'b0011;
				4'b0011: state = 4'b0100;
				4'b0100: state = 4'b0101;
				4'b0101: state = 4'b0110;
				4'b0110: state = 4'b0000;
			endcase
		end
	end
endmodule

module t_fns();
	reg clk, rst;
	wire[3:0] state;
	fns F1(clk, rst, state);

	initial begin
		$dumpfile("nov8.vcd");
		$dumpvars(0, t_fns);
		
		clk = 1'b0;
		
		$monitor("state = %b", state);
		
		#5 rst = 1'b1;
		#5 rst = 1'b0;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
		#5 clk = ~clk;
	end
endmodule