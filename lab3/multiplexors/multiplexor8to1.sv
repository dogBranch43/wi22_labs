//James Jhong
//Jean Kim
//EE469 Lab 2

//This is a 8:1 Mux built out of 4:1 Mux and a 2 to 1 mux 
`timescale 1ns/10ps
module multiplexor8to1(in, out, select);
	input logic [7:0] in;
	input logic [2:0] select;
	output logic out;
	
	logic [1:0] outputs;
	
	multiplexor4to1 m1 (in[3:0], outputs[0], select[1:0]);
	multiplexor4to1 m2 (in[7:4], outputs[1], select[1:0]);
	multiplexor2to1 m3 (outputs, out, select[2]);
	
endmodule
