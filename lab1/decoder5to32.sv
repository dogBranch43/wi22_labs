`timescale 1ps / 1ps
module decoder5to32(in, out, enable) ;
	input logic enable;
	input logic [4:0] in;
	output logic [31:0] out;
	
	wire [3:0] enablerSwitch;
	
	decoder2to4 enabler (.in(in[4:3]), .out(enablerSwitch[3:0]), .enable(enable));
	decoder4to16 d2 (.in(in[2:0]), .out(out[7:0]), .enable(enablerSwitch[0]));
	decoder4to16 d3 (.in(in[2:0]), .out(out[15:8]),  .enable(enablerSwitch[1]));
	decoder4to16 d4 (.in(in[2:0]), .out(out[23:16]), .enable(enablerSwitch[2]));
	decoder4to16 d5 (.in(in[2:0]), .out(out[31:24]),  .enable(enablerSwitch[3]));

endmodule

module decoder5to32_testbench();
	logic [4:0] in;
	logic  enable;
	logic [31:0] out;
	
	decoder5to32 dut (.in, .out, .enable);
	
	initial begin
		integer i;
		enable = 1;
		for (int i = 0; i < 32; i++) begin
			in[4:0] = i;
			#15;
		end
	end
	
endmodule
