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
	
	
	DFFs_64 dffs (.clk, .rst(1'b0), .in(PC), .out(pcTemp));
	
	assign shiftBrAddr = BrAddr << 2;
	//for addigng PC insturctions
	fullAdder_64bit plus4 (.a(PC), .b(64'd4), .out(noBranchTemp));
	fullAdder_64bit plusBr (.a(PC), .b(shiftBrAddr), .out(BrTakenTemp));

	mux64_2to1 m1uncondBr(.i1(uncondAddr26), .i0(condAddr19), .out(BrAddr), .select(UncondBr));
	mux64_2to1 m2BrTaken(.i0(noBranchTemp), .i1(BrTakenTemp), .out(pcTemp), .select(BrTaken));

	always_ff @(posedge clk) begin
		PC <= pcTemp;
	end
	
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