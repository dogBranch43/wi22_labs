`timescale 1ps / 1ps
// Takes in two read data and read register values to send into a 32 mux.
module multiplexor64of32to1(in, readData1, readData2, readRegister1, readRegister2) ;
	input logic [4:0] readRegister1, readRegister2;
	input logic [31:0][63:0] in;
	output logic [63:0] readData1, readData2;
	//registers are aligned 32 x 64 bits of data
	//still incomplete;
	logic [63:0][31:0] flipped;
	
	
    always_comb begin
        for (integer i = 0; i < 32; i++) begin
            for (integer j = 0; j < 64; j++) begin
                flipped[j][i] = in[i][j];
            end
        end
    end

	 genvar k;
    generate
        for (k = 0; k < 64; k++) begin : makeChain
			  multiplexor32to1 mp1 (.in(flipped[k]), .out(readData1[k]), .select(readRegister1));
			  multiplexor32to1 mp2 (.in(flipped[k]), .out(readData2[k]), .select(readRegister2));
        end
    endgenerate
endmodule
