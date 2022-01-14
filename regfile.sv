module regfile(ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk) ;
	input logic [4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 		RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	
	logic [31:0][63:0] registers;
   logic [31:0] enableDecoders, curRead1Register, curRead2Register;
	assign registers[31] = 64'b0;
	
	//main method
	//regwrite and write register goes to the decoder
	
	//32 registers, 64 bits
	//the output from the decoder is the enable for the registers
	//write data goes to the registers
	
	//read register 1 and 2 goes to read data
	
	
	logic reset;
	//decoder
   decoder5to32 d1(.in(WriteRegister), .out(enableDecoders), .enable(RegWrite));
	
	//64x32:1 mux
	multiplexor64of32to1 chain64 (.in(registers), .readData1(ReadData1), .readData2(ReadData2), .readRegister1(ReadRegister1), .readRegister2(ReadRegister2));
	
    //registers
	genvar i,j;
   generate 
       for (i = 0; i < 32; i++) begin : register
           for  (j = 0; j < 64; j++) begin : multiplexor
					logic [1:0] temp;
					logic temp2;
					assign temp[1] = registers[i][j];	
					multiplexor2to1 m1(.in(temp), .out(temp2), .select(enableDecoders[i]));
               D_FF dff1(.q(temp2), .d(temp[0]), .reset, .clk);
           end
       end
   endgenerate
endmodule