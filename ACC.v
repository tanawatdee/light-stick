module ACC(
	input wire next,
	input wire prev,
	input wire shake,
	input wire clk,
	output reg restart = 1'b1,
	output reg[3:0] song_no = 4'b0001
);
	reg[11:0] iTime = 12'h000;
	reg[1:0] shaked = 1'b0;

	always @(posedge next or posedge prev) begin
		if (next) begin
			song_no = song_no + 1;

			if(song_no>9) begin
				song_no = 4'b0001;
			end
		end
		else if (prev) begin
			song_no = song_no - 1;

			if(song_no<1) begin
				song_no = 4'b1001;
			end
		end

		restart = 1'b1;
	end

	always @(posedge clk)
		iTime = iTime + 1;

	always @(posedge shake) begin
		if (shaked == 1'b0) begin
			iTime = 12'h000;
			shaked = 1'b1;
		end
		else begin
			if ((iTime >= 12'h014) && (iTime <= 12'h03c)) begin
				shaked = 1'b0;
				restart = 1'b0;
			end

			else begin
				iTime = 12'h000;
			end
		end
	end
endmodule