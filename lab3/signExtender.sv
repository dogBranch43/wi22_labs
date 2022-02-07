//This module extends the sign of an input address to 64 bits.
module signExtender #(parameter SIZE = 9) (addr, out) ;
	input logic [SIZE - 1 : 0] addr;
	output logic [63:0] out;
	
	logic [64 - SIZE - 1 : 0] signExtend;
	assign out[SIZE - 1:0] = addr;
	
	//Setting rest of input to the sign at front of address
	generate
		genvar j;
		for (j = SIZE; j < 64; j = j + 1) begin : extension
			assign out[j] = addr[SIZE -1];
		end
	endgenerate
endmodule
