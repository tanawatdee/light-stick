`timescale 100ps/100ps

module Buf (i, o);

	input i;
	output o;

	buf A1(o, i);

endmodule

module Not (i, o);

	input i;
	output o;

	not A1(o, i);

endmodule

module And (i1, i2, o);

	input i1, i2;
	output o;

	and A1(o, i1, i2);

endmodule

module Or (i1, i2, o);

	input i1, i2;
	output o;

	or A1(o, i1, i2);

endmodule

module Nor (i1, i2, o);

	input i1, i2;
	output o;

	nor A1(o, i1, i2);

endmodule

module Nand (i1, i2, o);

	input i1, i2;
	output o;

	nand A1(o, i1, i2);

endmodule

module Xor (i1, i2, o);

	input i1, i2;
	output o;

	xor A1(o, i1, i2);

endmodule

module Xnor (i1, i2, o);

	input i1, i2;
	output o;

	xnor A1(o, i1, i2);

endmodule

// module gate;

// 	wire i1, i2, oBuf, oNot, oAnd, oOr, oNor, oNand, oXor, oXnor;
//    	integer i;
//    	integer k=0;
//    	parameter arr = 8'b00011011;/*or reg [15:0] arr = 8'b00011011 */

//    	assign {i1, i2} = k;
//    	Buf B1(i1, oBuf);
//    	Not N1(i1, oNot);
//    	And A1(i1, i2, oAnd);
//    	Or O1(i1, i2, oOr);
//    	Nor No1(i1, i2, oNor);
//    	Nand Na1(i1, i2, oNand);
//    	Xor X1(i1, i2, oXor);
//    	Xnor Xn1(i1, i2, oXnor);

// 	initial begin

// 		$dumpfile("gate.vcd");
// 		$dumpvars(0, gate);

// 		for(i=3;i>=0;i=i-1) begin
// 			k[0] = arr[2*i];
// 			k[1] = arr[2*i+1];
// 			#50 $display("done testing case %d", i);
// 		end

// 		$finish;

// 	end

// endmodule