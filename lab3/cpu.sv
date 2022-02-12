//This module is the dataPath module, which handles using the
//ALU file and register file to perform operations based on input instructions
//and then accessing the memory accordingly. 

module cpu(clk, instruction, Reg2Loc, RegWrite,  MemWrite, MemToReg, ALUSrc,
                                                        ALUOp, zero, negative, overflow, carry_out) ;
	
	parameter delay = 100000;
	
	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	
	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic clk, zero;
	logic [63:0]	test_val;
	logic [31:0] 	instruction;
	logic 			BrTaken, UncondBr;
	logic [63:0] 	PC;
	logic [4:0]		Rd, Rm, Rn;
	logic [3:0]    cntrls;
	
	// logic [4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	// logic [63:0]	WriteData;
	// logic [63:0]	ReadData1, ReadData2;
	// ADDI = 1001000100
	// SUBS = 11101011000
	// ADDS = 10101011000
	// B    = 000101
	// CBZ  = 10110100
	// STUR = 11111000000
	// LDUR = 11111000010
	// HALT = 000101
	// B.LT = 01010100
	
	
	instructionPath 	ip1(.clk, .BrTaken, .UncondBr, .instruction, .PC);
	instructmem 		im1 (.address(PC), .instruction, .clk);
	datamem 				dm1 (.address(PC), .write_enable(RegWrite), .read_enable(ReadData1), 
										.write_data(WriteData), .clk, .xfer_size, .read_data);

	regfile 				rf1 (.ReadData1, .ReadData2, .WriteData, .ReadRegister1, .ReadRegister2, .WriteRegister, .RegWrite, .clk) ;

endmodule

