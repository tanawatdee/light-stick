`timescale 100ps/100ps
`include "gate.v"

module FA(ci, a, b, s, co);

	input ci, a, b;
	output s, co;
	wire w1, w2, w3;

	Xor X1(a, b, w1);
	Xor X2(w1, ci, s);
	And A1(a, b, w2);
	And A2(w1, ci, w3);
	Or O1(w2, w3, co);

endmodule

