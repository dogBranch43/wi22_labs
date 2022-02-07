//this module is a 64 bit adder comprised of 64 1 bit full Adders
module fullAdder_64bit() ;
	input logic [63:0] a, b;
	output logic [63:0] out;
	logic [63:0] carries;
	
	fullAdder first(.a, .b, .cin(1'b0), .cout(carries[0]), .sum(out[0]));
	
	genvar i;
	generate
		for (i = 1; i < 64; i++) begin : bit
			fullAdder a1 (.a, .b, .cin(carries[i - 1]), .cout(carries[i]), .sum(out[i]));
		end
	endgenerate
endmodule
