//Jean Kim
//James Jhong
//EE469 Lab 3

//This is the control signals method
//Based on the inputed instructions, it will select the correct control signals
//to be used in the CPU
`timescale 1ps/1ps
module controlSignals(instruction, zero, negative, overflow, carry_out, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, writeEnable, BrTaken, UncondBr, ALUOp);
	input logic [31:0] instruction;
	input logic zero, negative, carry_out, overflow;
	output logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, ALUOp, writeEnable;
	
	//Instructions
	parameter [10:0] LDUR = 11'b11111000010, ADDI = 11'b1001000100x, B = 11'b000101xxxxx,
						  SUBS = 11'b11101011000, EOR = 11'b11001010000, CBZ = 11'b10110100xxx, STUR = 11'b11111000000,
						  ADDS = 11'b10101011000, LSR = 11'b11010011010, AND = 11'b10001010000, BLT = 11'b01010100xxx;
	//Selecting the correct signals based on the input
	always_comb begin
		case(instruction[31:21])
			 ADDI : begin
										Reg2Loc   = 1'bx;
										ALUSrc    = 1'b1;
										MemToReg  = 1'b0;
										RegWrite  = 1'b1;
										MemWrite  = 1'b0;
										BrTaken   = 1'b0;
										UncondBr  = 1'bx;
										ALUOp     = 3'b010;
										writeEnable = 0;
						end
			 
			 CBZ : begin
										
										Reg2Loc   = 1'b0;
										ALUSrc    = 1'b0;
										MemToReg  = 1'bx;
										RegWrite  = 1'b0;
										MemWrite  = 1'b0;
										BrTaken   = zero;
										UncondBr  = 1'b0;
										ALUOp     = 3'b000;
										writeEnable = 0;
					 end
			 
			 SUBS : begin
										
										Reg2Loc   = 1'b1;
										ALUSrc    = 1'b0;
										MemToReg  = 1'b0;
										RegWrite  = 1'b1;
										MemWrite  = 1'b0;
										BrTaken   = 1'b0;
										UncondBr  = 1'bx;
										ALUOp     = 3'b011;
										writeEnable = 1;
			 end
			 
			 LSR : begin
			 			        		Reg2Loc   = 1'b1;
			                    		ALUSrc    = 1'b0;
			                    		MemToReg  = 1'b0;
			                    		MemWrite  = 1'b1;
										RegWrite  = 1'b1;
										BrTaken   = 1'bx;
			                    		UncondBr  = 1'b0;
										ALUOp     = 3'bxxx;
						    			writeEnable = 0;
			 end
			 
			 LDUR : begin
										
										Reg2Loc   = 1'bx;
										ALUSrc    = 1'b1;
										MemToReg  = 1'b1;
										MemWrite  = 1'b0;
										RegWrite  = 1'b1;
										BrTaken   = 1'b0;
										UncondBr  = 1'bx;
										ALUOp     = 3'b010;
										writeEnable = 0;
			 end
			  
			 ADDS :begin			
										ALUSrc    = 1'b0;
										Reg2Loc   = 1'b1;
										MemToReg  = 1'b0;
										RegWrite  = 1'b1;
										MemWrite  = 1'b0;
										BrTaken   = 1'b0;
										UncondBr  = 1'bx;
										ALUOp     = 3'b010;
										writeEnable = 1;
			 end
			 
			 B :begin
										Reg2Loc   = 1'b0;
										ALUSrc    = 1'b0;
										MemToReg  = 1'b0;
										MemWrite  = 1'b0;
										RegWrite  = 1'b0;
										BrTaken   = 1'b1;
										UncondBr  = 1'b1;
										ALUOp     = 3'bxxx;
										writeEnable = 0;
			 end
			 
			 STUR : begin
										
										Reg2Loc   = 1'b0;
										ALUSrc    = 1'b1;
										MemToReg  = 1'bx;
										MemWrite  = 1'b1;
										RegWrite  = 1'b0;
										BrTaken   = 1'b0;
										UncondBr  = 1'bx;
										ALUOp     = 3'b010;
										writeEnable = 0;
			 end
			 
			 EOR : begin
										
			                    		Reg2Loc   = 1'b1;
			                    		ALUSrc    = 1'b0;
			                    		MemToReg  = 1'b0;
			                    		MemWrite  = 1'b1;
										RegWrite  = 1'b1;
										BrTaken   = 1'bx;
			                    		UncondBr  = 1'b0;
										ALUOp     = 3'bxxx;
										writeEnable = 0;
			 end
			 
			 AND : begin
										
			                     		Reg2Loc   = 1'b1;
			                     		ALUSrc    = 1'b0;
			                     		MemToReg  = 1'b0;
			                     		MemWrite  = 1'b0;
										RegWrite  = 1'b1;
										BrTaken   = 1'b0;
			                     		UncondBr  = 1'bx;
										ALUOp     = 3'b100;
										writeEnable = 0;
					end
			BLT : begin
										Reg2Loc   = 1'b0;
										ALUSrc    = 1'b0;
										MemToReg  = 1'b0;
										MemWrite  = 1'b0;
										RegWrite  = 1'b0;
										BrTaken   = overflow ^ negative;
										UncondBr  = 1'b0;
										ALUOp     = 3'b011;
										writeEnable = 0;
			 end                 
		endcase
		end
endmodule

module controlSignals_testbench() ;
	logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, ALUOp;
	logic [31:0] instruction;
	logic zero, negative, carry_out, overflow;
	
	
	controlSignals dut (instruction, zero, negative, overflow, carry_out, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, ALUOp);
	
	initial begin
		//LDUR
		instruction = 32'b11111000010xxxxxxxxxxxxxxxxxxxxx; #2000;
		//ADDI	
		instruction = 32'b1001000100xxxxxxxxxxxxxxxxxxxxxx; #2000;
		//ADDS
		instruction = 32'b10101011000xxxxxxxxxxxxxxxxxxxxx; #2000;
		//SUBS
		instruction = 32'b11101011000xxxxxxxxxxxxxxxxxxxxx; #2000;
		//LSR
		instruction = 32'b11010011100xxxxxxxxxxxxxxxxxxxxx; #2000;
		//CBZ
		zero = 0;
		instruction = 32'b10110100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;         //CBZ
		zero = 1;
		instruction = 32'b10110100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;         //CBZ
		//B
		zero = 0;
		instruction = 32'b000101xxxxxxxxxxxxxxxxxxxxxxxxxx; #2000;
		//B.LT
		negative = 0; overflow = 0; #20;
		instruction = 32'b01010100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;
		negative = 0; overflow = 1; #20;
		instruction = 32'b01010100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;
		negative = 1; overflow = 0; #20;                   
		instruction = 32'b01010100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;
		negative = 1; overflow = 1; #20;                   
		instruction = 32'b01010100xxxxxxxxxxxxxxxxxxxxxxxx; #2000;
		//EOR                                              
		instruction = 32'b11001010000xxxxxxxxxxxxxxxxxxxxx; #2000;
		//AND                                              
		instruction = 32'b10001010000xxxxxxxxxxxxxxxxxxxxx; #2000;
		//STUR
		instruction = 32'b11111000000xxxxxxxxxxxxxxxxxxxxx; #2000;
		//SUBS                                              
		instruction = 32'b11101011000xxxxxxxxxxxxxxxxxxxxx; #2000;
		$stop;
	end
endmodule
