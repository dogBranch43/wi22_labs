
`timescale 1ps / 1ps

module decoder1to2(in, out, enable) ;
	input logic in, enable;
	output logic [1:0] out;
	wire invertedIn;
	
	not #50 interal1 (invertedIn, in); //in = ~invertedIn;
	and #50 interal2 (out[0], invertedIn, enable); //out[0] = in & enable;
	and #50 interal3 (out[1], in, enable); //out[1] = invertedIn & enable
	
endmodule

module decoder1to2_testbench();
	logic in, enable;
	logic [1:0] out;
	
	decoder1to2 dut (in, out, enable);
	
	initial begin
		in = 0; enable = 0; #20;
		enable = 1; #20;
		in = 1; #20;
		enable = 0; #20;
	end
endmodule
