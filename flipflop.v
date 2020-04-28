`timescale 100ps/100ps
`include "gate.v"

module SR (s, r, q, qp);

	input s, r;
	output q, qp;

	nor N1(q, clr, r, qp);
	nor N2(qp, pre, s, q);

endmodule

module D_no_trig (clock, d, q, qp);

	input clock, d;
	output q, qp;
	wire s, r;

	And A1(clock, d, s);
	And A2(clock, ~d, r);
	SR S1(s, r, q, qp);

endmodule

module D (clock, d, q, qp);

	input clock, d;
	output q, qp;
	wire d2;

	D_no_trig D1(~clock, d, d2, );
	D_no_trig D2(clock, d2, q, qp);


endmodule

module JK (clock, j, k, q, qp);

	input clock, j, k;
	output q, qp;
	wire j1, k1, d;

	And A1(j, qp, j1);
	And A2(~k, q, k1);
	Or O1(j1, k1, d);
	D D1(clock, d, q, qp);

endmodule

module D_preset (clock, d, pre, clr, q, qp);

	input clock, d, pre, clr;
	output reg q, qp;

	always @(posedge clock or posedge clr or posedge pre) begin
		if (clr) begin
			q <= 0;
		end
		else if (pre) begin
			q <= 1;
		end
		else begin
			q <= d;
		end
		qp <= ~q;
	end

endmodule

module flipflop;

	//####### setting circuits #########
	wire clock, j, kf, q, qp;

	JK J1(clock, j, kf, q, qp);


	//####### setting test cases #######
	parameter testcase = 24'b001101011111011111011111;
	
	reg [2:0] k = 0;
	assign {clock, j, kf} = k;

	//##################################
	//####### run test cases ###########
	//##################################
	integer nTestbit = $bits(k);
	integer nTestcase = $bits(testcase)/$bits(k);
	integer loop1, loop2;

	initial begin

		$dumpfile("flipflop.vcd");
		$dumpvars(0, flipflop);
		$display("__________________________");

		for(loop1=nTestcase-1;loop1>=0;loop1=loop1-1) begin
			for(loop2=0;loop2<nTestbit;loop2=loop2+1) begin
				k[loop2] = testcase[nTestbit*loop1+loop2];
			end
			#10 $display("k = %b", k);
		end

		$finish;

	end

	//##################################

endmodule