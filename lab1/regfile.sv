module regfile(ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk) ;
	input logic [4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 		RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	
	//main method
	//regwrite and write register goes to the decoder
	
	//32 registers, 64 bits
	//the output from the decoder is the enable for the registers
	//write data goes to the registers
	
	//read register 1 and 2 goes to read data
	

	

	
endmodule
