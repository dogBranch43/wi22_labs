module register_dff_en(d, q, en, clock, reset) ;
	input logic clock, reset, en, d;
	output logic q;
	
	logic [1 : 0] muxInput;
					logic temp2;
					assign temp = registers[i][j];	
					assign muxInput[1] = WriteData[j];
					assign muxInput[0] = temp;
					multiplexor2to1 m1(.in(muxInput), .out(temp2), .select(enableDecoders[i]));
               D_FF dff1 (.q(temp), .d(temp2), .reset(1'b0), .clk(clk));


endmodule
