`timescale 1ps / 1ps
module decoder2to4(in, out, enable) ;
	input logic enable;
	input logic [1:0] in;
	output logic [3:0]out;
	
	wire inInv0, inInv1;
	not #50 n1 (inInv0, in[0]);
	not #50 n2 (inInv1, in[1]);
	
	and #50 a1 (out[0],inInv0,inInv1,enable); 
	and #50 a2 (out[1],in[0],inInv1,enable);
	and #50 a3 (out[2],inInv0,in[1],enable);
	and #50 a4 (out[3],in[1],in[0],enable);
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
