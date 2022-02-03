//James Jhong
//Jean Kim
//1/18/2022
//EE469 Lab 2

//This module is the main 64 bitALU, arithmetic logic unit, a unit capable of
//basic arithmetic and logic operations that can handle working
//with different number types, such as decimal, binary and two's comp. 

`timescale 1ps/1ps;
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out) ;
	input logic		[63:0] 	A, B;
	input logic		[2:0]		cntrl;
	output logic 	[63:0] 	result;
	output logic 				negative, zero, overflow, carry_out;
	
	logic [63:0] carryOuts;
	logic co, cin;
	genvar i;
	
	//initializing the first ALU
	alu_1bit_slice first (.a(A[0]), .b(B[0]), .cin(cntrl[0]), .co(carryOuts[0]), .control(cntrl), .out(result[0]));
	
	//The other 63 alus initialized here
	generate 
		for(i = 1; i < 64; i++) begin
			alu_1bit_slice alu1(.a(A[i]), .b(B[i]), .cin(carryOuts[i - 1]), .co(carryOuts[i]), .control(cntrl), .out(result[i]));
		end
	endgenerate
	
	//negative is the sign result from 63rd bit alu
	assign negative = result[63];
	
	//NOR gate of all results from all alu bits for zero
	nor_in64 zeroCheck (.in(result) ,.zeroFlag(zero));
	
	//CarryOut comes from the last ALU
	assign carry_out = carryOuts[63];
	
	//Overflow is the result of a xor of the carryouts from alu 63 and alu 62
	xor #50 overflowCheck(overflow, carry_out, carryOuts[62]);	//overflow carry out 63 != carry out 62
endmodule
