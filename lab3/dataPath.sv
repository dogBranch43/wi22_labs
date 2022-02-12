//This module is the dataPath module, which handles using the
//ALU file and register file to perform operations based on input instructions
//and then accessing the memory accordingly. 

module dataPath(clk, instruction, Reg2Loc, RegWrite,  MemWrite, MemToReg, ALUSrc,
                                                        ALUOp, zero, negative, overflow, carry_out, result) ;
	input logic clk, Reg2Loc, RegWrite, MemWrite, MemToReg, ALUSrc;
    input logic [2 : 0] ALUOp;
    input logic [31 : 0] instruction;
    output logic zero, negative, overflow, carry_out;
	output logic [63:0] ALUResult;
    //Calling the control signal module from the main would give the signals needed for this method and the reg file. 
    
    logic [63 : 0] d1, d2, writeData, DAddr9, Imm12;
    logic [4: 0] regout;
    logic [63 : 0] bForALU;
    logic [63 : 0] aluOther;

    /* 
    Need Reg2Loc Mux
    Need 1 sign extend
    Need Alusrc mux
    MemToReg mux
    */
    multiplexor2to1 dAddrOrImm12 (.in({}), .out(), .select()));
    multiplexor2to1 mToR(.in({}), .out(), .select());
    multiplexor2to1 aluSCRmux(.in({d2, aluOther}), .out(bForALU), .select(ALUSrc));

    multiplexor2to1 r2loc(.in({}), .out(), .select());
    multiplexor2to1 shifter(.in({}), .out(), .select());

    signExtender daddr9(.in(insturctions[20:12]), .out(DAddr9));
    zeroExtender #(12) imm12(.in(instruction[21:10]), .out(Imm12), .sign());

    regfile rf (.ReadData1(d1), .ReadData2(), .WriteData(), 
					 .ReadRegister1(instruction[9:5]), .ReadRegister2(regout), .WriteRegister(instruction[4:0]),
					 .RegWrite, .clk);

	alu(.A(d1), .B(bForALU), .cntrl(ALUOp), .result(ALUResult), .negative, .zero, .overflow, .carry_out);

endmodule
