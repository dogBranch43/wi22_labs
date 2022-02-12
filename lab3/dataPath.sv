//This module is the dataPath module, which handles using the
//ALU file and register file to perform operations based on input instructions
//and then accessing the memory accordingly. 
`timescale  1ps/1ps
module dataPath(clk, instruction, Reg2Loc, RegWrite,  MemWrite, MemToReg, ALUSrc,
                                                        ALUOp, zero, negative, overflow, carry_out, result, Rd, Rm, Rn, result) ;
	input logic clk, Reg2Loc, RegWrite, MemWrite, MemToReg, ALUSrc, ALUOp;

                                   

    input logic [2 : 0] ALUOp;
    input logic [31 : 0] instruction;
    input logic [4 : 0] Rd, Rm, Rn;
    output logic zero, negative, overflow, carry_out;

    output logic [63 : 0] result;

	output logic [63:0] ALUResult;

    //Calling the control signal module from the main would give the signals needed for this method and the reg file. 
    
    logic [63 : 0] d1, d2, writeData, DAddr9, Imm12;
    logic [4: 0] regout;
    logic [63 : 0] bForALU;
    logic [63 : 0] aluOut;
    logic [63:0] WriteData;
    logic constant;
    logic [63 : 0] constantVal;
    logic [63 : 0] outputMemory;
    logic [63 : 0] mToROutput;
    logic [63 : 0] regData;
    logic [63 : 0] d1_lsr;
    logic [6 : 0] shamt;

    or #50 (.a(MemToReg), .b(MemWrite), .out(constant));

    assign shamt = instruction[16:10];
    assign d1_lsr = d1 >> shamt;
    /* 
    Need Reg2Loc Mux
    Need 1 sign extend
    Need Alusrc mux
    MemToReg mux
    */
    always_comb begin
        if (instruction[10:0] == LSR = 11'b11010011010)
            assign d1_lsr = 1;
    end

    genvar i;
    generate 
        for (i = 0; i < 5; i++) begin : regs
            multiplexor2to1 reg (.in({Rm, Rd}), .out(regData), .select(Reg2Loc));
        end
    endgenerate

    mux64_2to1 dAddrOrImm12 (.i0(DAddr9), .i1(Imm12), .out(constantVal), .select(constant));

    //mux64_2to1 mToR (.i0(aluResult), .i1(outputMemory), .out(mToROutput), .select(MemToReg));


    mux64_2to1 aluSCRmux (.i0(d2), .i1(constantVal), .out(bForALU), .select(ALUSrc));
    signExtender daddr9 (.in(insturction[20:12]), .out(DAddr9));
    zeroExtender #(12) imm12(.in(instruction[21:10]), .out(Imm12));


    regfile rf (.ReadData1(d1), .ReadData2(d2), .WriteData, 
					 .ReadRegister1(Rn), .ReadRegister2(regout), .WriteRegister(Rd),
					 .RegWrite, .clk);
    alu(.A(d1), .B(bForALU), .cntrl(ALUOp), .result(aluOut), .negative, .zero, .overflow, .carry_out);
    
    mux64_2to1 shifterOut (.i0(aluOut), .i1(d1_lsr), .out(result), .select(lsrSel));
endmodule

