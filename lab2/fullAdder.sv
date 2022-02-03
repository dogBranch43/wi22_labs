//James Jhong
//Jean Kim
//1/18/2022
//EE469 Lab 2

//This module is a Full Adder, capable of doing
//addition between two bits and carry in bit
//outputting either a 1 or 0 sum and a carry out

`timescale 1ps / 1ps
module fullAdder(a, b, ci, co, sum) ;
	input logic a, b, ci;
	output logic co, sum; 
	logic [2:0] temp;
	
	xor #50 (sum, a, b, ci);
	and #50 (temp[0], a, b);
	and #50 (temp[1], a, ci);
	and #50 (temp[2], b, ci); 
	or  #50 (co, temp[0], temp[1], temp[2]);
endmodule
