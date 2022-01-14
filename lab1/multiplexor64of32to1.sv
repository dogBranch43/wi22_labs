module multiplexor64of32to1(in, readData1, readData2, readRegister1, readRegister2) ;
	input logic [4:0] readRegister1, readRegister2;
	input logic [31:0][63:0] in;
	output logic [63:0] readData1, readData2;
	//registers are aligned 32 x 64 bits of data
	//still incomplete;
	logic [63:0][31:0] flipped;
	
	 genvar i, j;

    generate 
        for (i = 0; i < 64; i++) begin : outerFlip
            for (j = 0; j < 32; j++) begin : innerFlip
                flipped[i][j] = in[j][i];
            end
        end
    endgenerate

	 genvar k;
    generate
        for (k = 0; k < 64; k++) begin : makeChain
            multiplexor32to1 mp1 (flipped[k][31:0], readData1[k], readRegister1);
            multiplexor32to1 mp2 (flipped[k][31:0], readData2[k], readRegister2);
        end
    endgenerate
endmodule
