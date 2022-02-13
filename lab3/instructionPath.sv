
`timescale 10ns/1ps
//This module is the instructionPath
module instructionPath(clk, BrTaken, UncondBr, instruction, rst) ;
    output logic [31:0] instruction;
    input logic clk, BrTaken, UncondBr, rst;
    //output logic [63:0] PC;
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
    logic [63:0] PC;

    initial begin

    end

    signExtender #(26) unBr (.addr(instruction[25 : 0]), .out(uncondAddr26));
    signExtender #(19) cbz (.addr(instruction[23 : 5]), .out(condAddr19));


    //Need 1 shifter to two places
    //need 2 adders
    //need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
    //need two sign extenders

    DFFs_64 dffs (.clk, .rst(1'b0), .in(PC), .out(pcPrev));

    assign shiftBrAddr = BrAddr << 2;

`timescale 1ns/10ps
//This module is the instructionPath
module instructionPath(clk, BrTaken, UncondBr, instruction, rst) ;
	output logic [31:0] instruction;
	input logic clk, BrTaken, UncondBr, rst;
	//output logic [63:0] PC;
	//Sign 
	//Default to length 9 opcode for arithmetic
	//Uncond Br 26
	//CBZ conditional br 19
	logic[63:0] uncondAddr26, condAddr19;
	logic[63:0] BrAddr;
	logic[63:0] BrTakenTemp, noBranchTemp;
	logic[63:0] pcTemp;
	logic[63:0] pcPrev;
	logic[63:0] shiftBrAddr;
	logic [63:0] PC;
	logic [31:0] instructionTemp;
	
	//extender as seen in diagram for the branches.
	signExtender #(26) unBr (.addr(instructionTemp[25 : 0]), .out(uncondAddr26));
	signExtender #(19) cbz (.addr(instructionTemp[23 : 5]), .out(condAddr19));
		
	
	//Need 1 shifter to two places
	//need 2 adders
	//need two muxs ( 1 takes BrTaken as signal, other takes unCondBr as signal
	//need two sign extenders
	
	DFFs_64 dffs (.clk, .rst(1'b0), .in(pcTemp), .out(pcPrev));
	
	//shifting the branch left by 2
	assign shiftBrAddr = BrAddr << 2;
	
	//for addigng PC insturctions
	fullAdder_64bit plus4 (.a(PC), .b(64'd4), .out(noBranchTemp));
	fullAdder_64bit plusBr (.a(pcPrev), .b(shiftBrAddr), .out(BrTakenTemp));
	
	//Muxes: 1st chooses uncondbr and 2nd chooses a branch taken or not, not is for pc <= pc + 4;
	mux64_2to1 m1uncondBr(.i0(uncondAddr26), .i1(condAddr19), .out(BrAddr), .select(UncondBr));
	mux64_2to1 m2BrTaken(.i0(noBranchTemp), .i1(BrTakenTemp), .out(pcTemp), .select(BrTaken));
	
	instructmem 		im1 (.address(PC), .instruction(instructionTemp), .clk);
	
	//this block increments PC and instruction accordingly
	always_ff @(posedge clk) begin
		if (rst) begin
			PC <= 0;
			pcTemp <=0;
			pcPrev <=0;
			noBranchTemp<=0;
			BrTakenTemp <=0;
			instructionTemp <= 0;
			BrAddr <=0;
		end else begin
			PC <= pcTemp;
			instruction <= instructionTemp;
		end
	end
endmodule

module instructionPath_testbench() ; 
	logic [31:0] instruction;
	logic clk, BrTaken, UncondBr, rst;
	logic [63:0] PC;

	instructionPath dut (.clk, .BrTaken, .UncondBr, .instruction, .rst);


    //for addigng PC insturctions
    fullAdder_64bit plus4 (.a(PC), .b(64'd4), .out(noBranchTemp));
    fullAdder_64bit plusBr (.a(pcPrev), .b(shiftBrAddr), .out(BrTakenTemp));

    mux64_2to1 m1uncondBr(.i0(uncondAddr26), .i1(condAddr19), .out(BrAddr), .select(UncondBr));
    mux64_2to1 m2BrTaken(.i0(noBranchTemp), .i1(BrTakenTemp), .out(pcTemp), .select(BrTaken));

    instructmem         im1 (.address(PC), .instruction, .clk);

    always_ff @(posedge clk) begin
        if (rst) begin
            PC <= 0;
        end else begin
            PC <= pcTemp;
        end
    end
endmodule

// module instructionPath_testbench() ;
// 	logic [31:0] instruction;
//    logic clk, BrTaken, UncondBr, rst;
	
// 	instructionPath dut (.*);
// 	parameter CLOCK_PERIOD = 100;
// 	initial begin
// 		clk <= 0;
// 		forever #(CLOCK_PERIOD/2) clk <= ~clk;
// 	end
	
// 	initial begin

// 		rst <= 1; @(posedge clk);
// 		rst <= 0; @(posedge clk);
// 		BrTaken <= 0; UncondBr <= 0;  @(posedge clk);

// 		rst <=0 ;@(posedge clk);
// 		rst <=1 ;@(posedge clk);
// 		rst <=0 ;@(posedge clk);
// 		instruction <= 32'b10010001000000000110001111100010; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
// 		instruction <= 32'b10001011000001010000000001000011; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
// 		instruction <= 32'b10001011000001010001100001000011; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
// 		instruction <= 32'b10001011000001011000000001000011; BrTaken <= 0; UncondBr <= 0; @(posedge clk);
// 		instruction <= 32'b10001011000001010000000101000011; BrTaken <= 0; UncondBr <= 0; @(posedge clk);

// 		$stop;
// 	end
// endmodule
