`timescale 10ns/1ps
//This module is the instructionPath
module instructionPath(clock,BrTaken, UncondBr, Instruction, PC) ;
	input logic [31:0] instruction;
	input logic clock, BrTaken, UncondBr, Instruction;
	output logic [63:0] PC;
	//Sign 
		
	signExtender #(,.sign(1'b1),);
	signExtender #(,.sign(1'b1),);

	//Need 1 shifter to two places
	//need 2 adders
	//need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
	//need two sign extenders
	
	
	
endmodule
