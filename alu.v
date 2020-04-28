
// Code your design here
module alu(
           input [3:0] A,B,  // ALU 4-bit Inputs                 
           input [3:0] ALU_Sel,// ALU Selection
           output [3:0] ALU_Out, // ALU 4-bit Output
           output CarryOut, // Carry Out Flag
 		   output Z, // Carry Out Flag
  		   output V // Carry Out Flag
    );
    reg [3:0] ALU_Result; reg Z,V;
    wire [4:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[4]; // Carryout flag
    always @(*)
    begin
      if(ALU_Sel[3]==1'b0) begin
        case(ALU_Sel[2:0])
        3'b000:
          ALU_Result = B;
        3'b001:
          ALU_Result = A+B;
        3'b010:
          ALU_Result = A-B;
        3'b100:
          ALU_Result = 4'b0000;
        3'b101:
          ALU_Result = A&B;
        3'b110:
          ALU_Result = A|B;
        3'b111:
          ALU_Result = ~A;
        default: ALU_Result = A;
        endcase
      end
      else begin
        ALU_Result = A;
      end
      if (ALU_Result ==0) Z=1; else Z=0;
      if (A[3]==0 && B[3] ==0 && ALU_Result[3]==0) 
        if(ALU_Result[3]==0) V=0; else V=1; 
      else if ((A[3]==1 && B[3] ==1))
        if(ALU_Result[3]==1) V=0; else V=1;
      else V=0;
      
    end

endmodule

/////////////////////////////////////////////////////////////////////
// Code your testbench here
// or browse Examples
module tb_alu;
//Inputs
 reg[3:0] A,B;
 reg[3:0] ALU_Sel;

//Outputs
 wire[3:0] ALU_Out;
 wire CarryOut,V,Z;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            A,B,  // ALU 4-bit Inputs                 
            ALU_Sel,// ALU Selection
            ALU_Out, // ALU 4-bit Output
            CarryOut, // Carry Out Flag
   			Z,
   			V
     );
    initial begin
    // hold reset state for 100 ns.
      A = 4'hA;
      B = 4'h2;
      //ALU_Sel = 4'h0;
      
           
      A = 4'b1000;
      B = 4'b1000;
      ALU_Sel=0;
      #10;
        $monitor("ALU_Sel=%b, result=%b,  CarryOut=%b, V=%b, Z=%b", ALU_Sel,ALU_Out, CarryOut,V,Z);
       #10;
         ALU_Sel=1;
      #20;
        $monitor("ALU_Sel=%b, result=%b,  CarryOut=%b, V=%b, Z=%b", ALU_Sel,ALU_Out, CarryOut,V,Z);
       #10;
         ALU_Sel=2;
      #20;
      $monitor("ALU_Sel=%b, result=%b,  CarryOut=%b, V=%b, Z=%b", ALU_Sel,ALU_Out, CarryOut,V,Z);
     
    end
endmodule
