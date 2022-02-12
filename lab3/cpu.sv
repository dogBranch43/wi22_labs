
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module cpu();

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
	
	always_comb begin
		casez (instruction[31:20]) begin
			11'b1001000100?: 
		end
	end
	
	
	parameter CLOCK_PERIOD=100;
	initial begin
		 clk <= 0;
		 forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	 end
 
 
 
	initial begin
		
		
		
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<3; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		assign test_val = A + B;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);

	end
	

endmodule 
