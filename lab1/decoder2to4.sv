module decoder2to4(in, out, enable) ;
	input logic enable;
	input logic [1:0] in;
	output logic [3:0]out;
	
	decoder1to2 d1(in[0], out[1:0], enable);
	decoder1to2 d2 (in[1], out[3:2], enable);
	
endmodule

module decoder2to4_testbench();
	logic [1:0] in;
	logic  enable;
	logic [3:0] out;
	
	decoder2to4 dut (in, out, enable);
	
	initial begin
		in[1] = 0; in[0] = 0; enable = 0; #20;
		enable = 1; #20;
		in[0] = 1; enable = 0; #20;
		in[1] = 1; in[0] = 1; enable = 1; #20;
		enable = 0; #20;
	end
endmodule
