`timescale 10ns/1ps
//This module is the instructionPath
module instructionPath(clk, BrTaken, UncondBr, instruction, PC) ;
	input logic [31:0] instruction;
	input logic clk, BrTaken, UncondBr;
	output logic [63:0] PC;
	//Sign 
	//Default to length 9 opcode for arithmetic
	//Uncond Br 26
	//CBZ conditional br 19
	logic[63:0] uncondAddr26, condAddr19;

	signExtender #(26) unBr (.addr(instruction[23 : 0]), .out(uncondAddr26));
	signExtender #(19) cbz (.addr(instruction[23 : 5]), .out(condAddr19));
		
	//Need 1 shifter to two places
	//need 2 adders
	//need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
	//need two sign extenders
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin : bits
			



		end
	endgenerate

	//for addigng PC insturctions
	//fullAdder_64bit ();
	
endmodule

module instructionPath_testbench() ; 
	logic [31:0] instruction;
	logic clk, BrTaken, UncondBr;
	logic [63:0] PC;

	parameter CLOCK_PERIOD = 100000;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		$stop;
	end
endmodule