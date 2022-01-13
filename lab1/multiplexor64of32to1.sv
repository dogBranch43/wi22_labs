module multiplexor64of32to1(in, readData1, readData2, select) ;
	input logic [4:0] select;
	input logic [63:0][31:0] in;
	output logic [63:0] readData1, readData2;
	//registers are aligned 32 x 64 bits of data
	//still incomplete;
	genvar i;
	generate
		for (int i = 0; i < 64; i++) begin
			multiplexor32to1 first_mux64x32to1 (in[63:0][31:0], readData1[i], select);
		end
	endgenerate
	
	genvar j;
	generate
		for (int j = 0; j < 64; j++) begin
			multiplexor32to1 second_mux64x32to1 (in[63:0][31:0], readData2[j], select);
		end
	endgenerate
	
endmodule
