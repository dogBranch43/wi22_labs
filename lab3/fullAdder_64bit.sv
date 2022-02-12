//this module is a 64 bit adder comprised of 64 1 bit full Adders
`timescale 10ns/1ps
module fullAdder_64bit(a, b, out) ;
	input  logic [63:0] a, b;
	output logic [63:0] out;
	logic [63:0] carries;
	
	fullAdder first(.a(a[0]), .b(b[0]), .ci(1'b0), .co(carries[0]), .sum(out[0]));
	
	genvar i;
	generate
		for (i = 1; i < 64; i++) begin : singlebit
			fullAdder a1 (.a(a[i]), .b(b[i]), .ci(carries[i - 1]), .co(carries[i]), .sum(out[i]));
		end
	endgenerate
endmodule

module fullAdder_64bit_testbench() ;
	logic [63:0] a, b;
	logic [63:0] out;

	fullAdder_64bit dut (.*);

	initial begin
		a <= 64'd0; b <=64'd4; #10;
		$stop;
	end


endmodule
