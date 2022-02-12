//This module extends the sign of any size input address to 64 bits.
module signExtender #(parameter SIZE = 9) (addr, out) ;
	input logic [SIZE - 1 : 0] addr;
	output logic [63:0] out;
	
	//copying over the in addr.
	assign out[SIZE - 1:0] = addr;
	
	//Setting rest of out to the sign at front of address
	generate
		genvar j;
		for (j = SIZE; j < 64; j = j + 1) begin : extension
			assign out[j] = addr[SIZE - 1];
		end
	endgenerate
endmodule

module signExtender_testbench() ;
	logic [8 : 0] addr;
	logic [63:0] out;

	signExtender dut (.addr, .out);

	initial begin
		addr = 9'b101110000; #20;
		addr = 9'b010001111; #20;
		$stop; 
	end
endmodule
