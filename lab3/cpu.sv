
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

	// ADDI = 1001000100
	// SUBS = 11101011000
	// ADDS = 10101011000
	// B    = 000101
	// CBZ  = 10110100
	// STUR = 11111000000
	// LDUR = 11111000010
	// HALT = 000101
	// B.LT = 01010100
module cpu(clk);
	input logic clk;
	
	logic zero, negative, overflow, carry_out;
	logic [31:0] 	instruction;
	logic 			BrTaken, UncondBr;
	logic [63:0] 	PC, ALUResult, read_data, writeData;
	logic [4:0]		Rd, Rm, Rn;
	logic [3:0]    cntrls;
	
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, ALUSrc, ALUOp, .writeEnable;
	
	instructmem 		im1 (.address(PC), .instruction, .clk);
	
	instructionPath 	ip1 (.clk, .BrTaken, .UncondBr, .instruction, .PC);							// Outputs counter
	
	controlSignals		cs1 (.instruction, .zero, .negative, .overflow, .carry_out, 				// input
											.Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, 			// output
											.writeEnable, .BrTaken, .UncondBr, .ALUOp);						// output
	
	dataPath				dp1 (.clk, .instruction, .Reg2Loc, .RegWrite,  .MemWrite, .MemToReg, .ALUSrc,.ALUOp, // input
											.zero, .negative, .overflow, .carry_out, .result(ALUResult), .Rd, .Rm, .Rn) ; // output
									// add in writeData									  
	
	datamem 				dm1 (.address(Rd), .write_enable(MemWrite), .read_enable(MemToReg), 
										.write_data(ALUResult), .clk, .xfer_size, .read_data);
	
	mux64_2to1 			m2r (.i0(ALUResult), .i1(read_data), .out(writeData), .select(MemToReg)) ;
	
	assign Rd = instruction[4:0];
	assign Rm = instruction[20:16];
	assign Rm = instruction[9:5];
	
endmodule 

module cpu_test();
	parameter delay = 100000;
	
	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	
	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	logic clk;
	
	cpu cpu1(.clk);
	
	integer i;
		
	parameter CLOCK_PERIOD=100;
	initial begin
		 clk <= 0;
		 PC <= 0;
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
/**
always_comb begin
		casez (instruction[31:21]) begin
			11'b1001000100?: begin					// ADDI
				Rd = instruction[4:0];		// Destination
				Rn = instruction[9:5];		// Source
				//Rn = instruction[21:10]; 	// IMM12
				cntrls = 3'b010;
			end
			11'b11101011000: begin
				Rd = instruction[20:16];		// Destination
				Rn = instruction[9:5];		// Source 1 og value
				//Rn[11:0] = instruction[4:0]; 	// Source 2 begin minus
				cntrls = 3'b011;
			end
			11'b11111000000: begin 			/// STUR
				Rd = instruction[4:0];		// Destination
				Rn = instruction[9:5];		// Source
			end
			11'b11111000010: begin 			/// LDUR
				Rd = instruction[4:0];		// Destination
				Rn = instruction[9:5];		// Source
			end
			default: begin
				cntrls = 3'b000;
			end
		endcase
	end
*/
