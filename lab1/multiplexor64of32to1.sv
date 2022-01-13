module multiplexor64of32to1(in, out, select) ;
	input logic [4:0] select;
	input logic [][] in;
	output logic [63:0];
	//registers are aligned 32 x 64 bits of data
	//still incomplete;
	genvar i;
	generate
		for (int i = 0; i < 64; i++) begin
			multiplexor32to1 first_mux64x32to1 (in[][], out[i], select);
		end
	endgenerate
	
	genvar j;
	generate
		for (int j = 0; j < 64; j++) begin
			multiplexor32to1 second_mux64x32to1 (in[][], out[j], select);
		end
	endgenerate
	
endmodule
