//James Jhong
//Jean Kim
//EE469 Lab 2

//This is a 8:1 Mux built out of 4:1 Mux and a 2 to 1 mux 
module mux_8to1(in, out, select) ;
	input logic [7:0] in;
	input logic [2:0] select;
	output logic out;
	
	logic[1:0] temp;
	multiplexor4to1 m1(.in(in[3:0]),.out(select[1:0]),.select(temp[0]));
	multiplexor4to1 m2(.in(in[7:4]),.out(select[1:0]),.select(temp[1]));
	multiplexor2to1 m3(.in(temp),.out(out),.select(select[2]));
	
endmodule
