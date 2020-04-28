
// Code your design here
module alu(
           input [7:0] A,B,  // ALU 8-bit Inputs                 
           input [3:0] ALU_Sel,// ALU Selection
           output [7:0] ALU_Out, // ALU 8-bit Output
           output CarryOut, // Carry Out Flag
 		   output Z, // Carry Out Flag
  		   output V // Carry Out Flag
    );
  reg [7:0] ALU_Result; reg Z,V;
    wire [8:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[8]; // Carryout flag
    always @(*)
    begin
        case(ALU_Sel)
        4'b0000: // Addition
           ALU_Result = A + B ; 
        4'b0001: // Subtraction
           ALU_Result = A - B ;
        4'b0010: // Multiplication
           ALU_Result = A * B;
        4'b0011: // Division
           ALU_Result = A/B;
        4'b0100: // Logical shift left
           ALU_Result = A<<1;
         4'b0101: // Logical shift right
           ALU_Result = A>>1;
         4'b0110: // Rotate left
           ALU_Result = {A[6:0],A[7]};
         4'b0111: // Rotate right
           ALU_Result = {A[0],A[7:1]};
          4'b1000: //  Logical and 
           ALU_Result = A & B;
          4'b1001: //  Logical or
           ALU_Result = A | B;
          4'b1010: //  Logical xor 
           ALU_Result = A ^ B;
          4'b1011: //  Logical nor
           ALU_Result = ~(A | B);
          4'b1100: // Logical nand 
           ALU_Result = ~(A & B);
          4'b1101: // Logical xnor
           ALU_Result = ~(A ^ B);
          4'b1110: // Greater comparison
           ALU_Result = (A>B)?8'd1:8'd0 ;
          4'b1111: // Equal comparison   
            ALU_Result = (A==B)?8'd1:8'd0 ;
          default: ALU_Result = A + B ; 
        endcase
      if (ALU_Result ==0) Z=1; else Z=0;
      if (A[7]==0 && B[7] ==0 && ALU_Result[7]==0) 
        if(ALU_Result[7]==0) V=0; else V=1; 
      else if ((A[7]==1 && B[7] ==1))
        if(ALU_Result[7]==1) V=0; else V=1;
      else V=0;
      
    end

endmodule

/////////////////////////////////////////////////////////////////////
// Code your testbench here
// or browse Examples
module tb_alu;
//Inputs
 reg[7:0] A,B;
 reg[3:0] ALU_Sel;

//Outputs
 wire[7:0] ALU_Out;
 wire CarryOut,V,Z;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            A,B,  // ALU 8-bit Inputs                 
            ALU_Sel,// ALU Selection
            ALU_Out, // ALU 8-bit Output
            CarryOut, // Carry Out Flag
   			Z,
   			V
     );
    initial begin
    // hold reset state for 100 ns.
      A = 8'h0A;
      B = 4'h02;
      //ALU_Sel = 4'h0;
      
           
      A = 8'b11110000;
      B = 8'b00000000;
      ALU_Sel=0;
      #10;
        $monitor("ALU_Sel=%b, result=%b", ALU_Sel,ALU_Out);
       #10;
         ALU_Sel=1;
      #20;
        $monitor("ALU_Sel=%b, result=%b", ALU_Sel,ALU_Out);
       #10;
         ALU_Sel=2;
      #20;
      $monitor("ALU_Sel=%b, result=%b,  CarryOut=%b, V=%b, Z=%b", ALU_Sel,ALU_Out, CarryOut,V,Z);
     
    end
endmodule
