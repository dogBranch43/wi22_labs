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
	logic[63:0] BrAddr;
	logic[63:0] condBrTemp;
	logic[63:0] BrTakenTemp, noBranchTemp;
	logic[63:0] pcTemp;
	logic[63:0] pcPrev;
	logic[63:0] shiftBrAddr;
	

	signExtender #(26) unBr (.addr(instruction[25 : 0]), .out(uncondAddr26));
	signExtender #(19) cbz (.addr(instruction[23 : 5]), .out(condAddr19));
		
	
	//Need 1 shifter to two places
	//need 2 adders
	//need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
	//need two sign extenders
	
	mux64_2to1 m1uncondBr(.i0(uncondAddr26), .i1(condAddr19), .out(BrAddr), .select(UncondBr));
	mux64_2to1 m2BrTaken(.i0(BrTakenTemp), .i1(noBranchTemp), .out(pcTemp), .select(BrTaken));
	DFFs_64 dffs (.clk, .rst(1'b0), .in(PC), .out(pcPrev));
//
//	shifter branchLeftShift2 (.value(BrAddr), .direction(1'b0), .distance(6'b000010), .result(shiftBrAddr));
	
	//for addigng PC insturctions
	fullAdder_64bit plus4 (.a(PC), .b(64'd4), .out(noBranchTemp));
	fullAdder_64bit plusBr (.a(pcPrev), .b(shiftBrAddr), .out(BrTakenTemp));
endmodule

module instructionPath_testbench() ; 
	logic [31:0] instruction;
	logic clk, BrTaken, UncondBr;
	logic [63:0] PC;

	instructionPath dut (.clk, .BrTaken, .UncondBr, .instruction, .PC);

	parameter CLOCK_PERIOD = 100000;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		instruction <= 32'b10010001000000000110001111100010; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
		instruction <= 32'b10001011000001010000000001000011; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
		$stop;
	end
endmodule