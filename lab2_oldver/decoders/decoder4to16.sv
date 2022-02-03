`timescale 1ps / 1ps
module decoder4to16(in, out, enable) ;
//4 to 16 decoder can be made from 5 2 to 4 decoders
//	input logic enable;
//	input logic [3:0] in;
//	output logic [15:0] out;
//	
//	logic[3:0] enablerSwitch;
//	
//	decoder2to4 enabler (.in(in[3:2]), .out(enablerSwitch[3:0]), .enable(enable));
//	decoder2to4 d1 (.in(in[1:0]), .out(out[3:0]),   .enable(enablerSwitch[0]));
//	decoder2to4 d2 (.in(in[1:0]), .out(out[7:4]),   .enable(enablerSwitch[1]));
//	decoder2to4 d3 (.in(in[1:0]), .out(out[11:8]), .enable(enablerSwitch[2]));
//	decoder2to4 d4 (.in(in[1:0]), .out(out[15:12]),.enable(enablerSwitch[3]));

	input logic [2:0] in;
	input logic enable;
	output logic [7:0] out;
	
	wire [1:0] enablerSwitches;
	
	decoder1to2 d1(.in(in[2]), .out(enablerSwitches[1:0]), .enable(enable));
	decoder2to4 d2(.in(in[1:0]),.out(out[3:0]),.enable(enablerSwitches[0]));
	decoder2to4 d3(.in(in[1:0]),.out(out[7:4]),.enable(enablerSwitches[1]));
	
endmodule

//module decoder4to16_testbench();
//	logic [3:0] in;
//	logic  enable;
//	logic [15:0] out;
//	
//	decoder4to16 dut (in, out, enable);
//	
//	initial begin
//		integer i;
//		enable = 0;
//		for (int i = 0; i < 16; i++) begin
//			in = i;
//			#15;
//		end
//	end
//	
//	initial begin
//		integer j;
//		enable = 1;
//		for (int j = 0; j < 16; j++) begin
//			in = j;
//			#15;
//		end
//	end
//	
//endmodule
