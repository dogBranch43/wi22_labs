//This module is the dataPath module, which handles using the
//ALU file and register file to perform operations based on input instructions
//and then accessing the memory accordingly. 
`timescale  1ns/10ps
module dataPath(clk, instruction, Reg2Loc, RegWrite,  MemWrite, MemToReg, ALUSrc, ALUOp, zero, negative, overflow, carry_out, Rd, Rm, Rn, result, WriteData) ;
    input logic clk, Reg2Loc, RegWrite, MemWrite, MemToReg, ALUSrc;
    input logic [2 : 0] ALUOp;
    input logic [31 : 0] instruction;
    input logic [4 : 0] Rd, Rm, Rn;
    input logic [63:0] WriteData;
    output logic zero, negative, overflow, carry_out;
    output logic [63 : 0] result;    //Calling the control signal module from the main would give the signals needed for this method and the reg file. 
    
    logic [63 : 0] d1, d2, writeData, DAddr9, Imm12;
    logic [63 : 0] bForALU;
    logic [63 : 0] aluOut;
    logic lsrSel;
    logic constant;
    logic [63 : 0] constantVal;
    logic [63 : 0] outputMemory;
    logic [63 : 0] mToROutput;
    logic [4 : 0] regData;
    logic [63 : 0] d1_lsr;
    logic [6 : 0] shamt;

    or #5 (constant, MemToReg, MemWrite);
	
    //LSR shifting
    assign shamt = instruction[16:10];
    assign d1_lsr = d1 >> shamt;
 	
    //When the operation is LSR, select is on (to be used for selecting either the ALU result or the shifted value
    always_comb begin
		case (instruction[31:21])
			11'b11010011010 : lsrSel = 1;
		endcase
    end

    genvar i;
    generate //reg2Loc mux for selecting inputs for the reg file
        for (i = 0; i < 5; i++) begin : regs
            multiplexor2to1 regs (.in({Rm[i], Rd[i]}), .out(regData[i]), .select(Reg2Loc));
        end
    endgenerate

    //dAddr or imm12 mux selecting for alu
    mux64_2to1 dAddrOrImm12 (.i0(DAddr9), .i1(Imm12), .out(constantVal), .select(constant));
    //selecting between b or the constant of either daddr9 or imm12
    mux64_2to1 aluSCRmux (.i0(d2), .i1(constantVal), .out(bForALU), .select(ALUSrc));

	//extender and zero extender for daddr9 and imm12
    signExtender daddr9 (.addr(instruction[20:12]), .out(DAddr9));
    zeroExtender #(12) imm12(.addr(instruction[21:10]), .out(Imm12));

	//alu and regfile calls
    regfile rf (.ReadData1(d1), .ReadData2(d2), .WriteData, 
					 .ReadRegister1(Rn), .ReadRegister2(regData), .WriteRegister(Rd),
					 .RegWrite, .clk);
                     
    alu a1(.A(d1), .B(bForALU), .cntrl(ALUOp), .result(aluOut), .negative, .zero, .overflow, .carry_out);
   
	//choosing between lsr result or alu output
    mux64_2to1 shifterOut (.i0(aluOut), .i1(d1_lsr), .out(result), .select(lsrSel));
endmodule


module dataPath_testbench() ;
    logic clk, Reg2Loc, RegWrite, MemWrite, MemToReg, ALUSrc;
    logic [2 : 0] ALUOp;
    logic [31 : 0] instruction;
    logic [4 : 0] Rd, Rm, Rn;
    logic [63:0] WriteData;
    logic zero, negative, overflow, carry_out;
    logic [63 : 0] result;

    dataPath dut (.*);

    parameter CLOCK_PERIOD = 100000;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

    initial begin
        //ADDI
        instruction <= 32'b10010001000000000000010000000001; Reg2Loc <= 1'bx; RegWrite <= 1'b1;  MemWrite <= 1'b0; MemToReg <= 1'b0; ALUSrc <= 1'b1; ALUOp <= 3'b010; Rd <= instruction[4:0]; Rm <= instruction[9:5]; Rn <= instruction[21:10];  WriteData <= 64'b1;    @(posedge clk);
        
        $stop;
		  
    end

endmodule
