`timescale 10ns/1ps
//This module is the instructionPath
module instructionPath(clock,BrTaken, UncondBr, instruction, PC) ;
	input logic [31:0] instruction;
	input logic clock, BrTaken, UncondBr;
	output logic [63:0] PC;
	//Sign 
	//Daddr 19 for LDUR and STUR
	//Default to length 9 opcode for arithmetic
	//Uncond Br 26
	//CBZ conditional br 19
	
//	signExtender #(.addr(), .out());
//	signExtender #(.addr(), .out());	
//	signExtender #(.addr(), .out());

	//Need 1 shifter to two places
	//need 2 adders
	//need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
	//need two sign extenders
	
	
	
endmodule
