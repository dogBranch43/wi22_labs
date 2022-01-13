module decoder5to32(in, out, enable) ;
	input logic enable;
	input logic [4:0] in;
	output logic [31:0] out;
	
	logic[1:0] enablerSwitch;
	
	decoder1to2  enabler (in[4], enablerSwitch[1:0], enable);
	decoder4to16 d2 (in[3:2], out[31:16], enablerSwitch[1]);
	decoder4to16 d3 (in[1:0], out[15:0], enablerSwitch[0]);


endmodule

module decoder5to32_testbench();
	logic [4:0] in;
	logic  enable;
	logic [31:0] out;
	
	decoder5to32 dut (in, out, enable);
	
	initial begin
		integer i;
		enable = 1;
		for (int i = 0; i < 32; i++) begin
			in[4:0] = i;
			#15;
		end
	end
	
//	initial begin
//		integer j;
//		enable = 1;
//		for (int j = 0; j < 32; j++) begin
//			in = j;
//			#15;
//		end
//	end
//	
endmodule
