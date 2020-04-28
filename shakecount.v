module shakecount(
	input btnR,
	output[15:0] LED
);
	reg[15:0] count = 16'b0;
	assign LED = count;

	always @(posedge btnR) begin
		count = count+1;
	end
endmodule