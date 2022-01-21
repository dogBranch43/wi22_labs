//James Jhong
//Jean Kim
//1/18/2022
//EE469 Lab 2

//This module is the main 64 bitALU, arithmetic logic unit, a unit capable of
//basic arithmetic and logic operations that can handle working
//with different number types, such as decimal, binary and two's comp. 

module alu(A, B, cntrl, result, negative, zero, overflow, carry_out) ;
	input logic	[63:0] A, B;
	input logic	[2:0]	cntrl;
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	//array of 1 bit alu slices?
	//logic [63:0] alu_slices;
	//assign negative = alu_slices[63];
	//assign overflow = alu_slices[63] carryout XOR carryout alu_slices[62];
	//assign zero = XOR all alu_slices
	//assign carryOut = result from alu [63]
	
	
endmodule
