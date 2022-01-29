//James Jhong
//Jean Kim
//EE469 Lab 2
//1/18/2022

`timescale 1ns/10ps

//This module is a 1 bit slice of the alu, a 8:1 mux.
//It can handle 4 operations, addition, subtraction, AND and OR.
//It has two inputs A and B. 
// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alu_1bit_slice(a, b, cin, co, control, out);
	//add or subtract, Cin, Cout, uses the 2 x 1 mux to determine which one
		
		input logic a, b, cin;
		input logic [2:0] control;
		output logic co, out;
		
		// First calculate all values according to control
		// Then push it through MUX8to1
		
		logic [7:0] result;
		logic [3:0] coResult;
		logic [1:0] coSelect;
		logic t1, t2, notb;

		or  #50 c18 (result[0], b, 1'b0);
		
		or  #50 c24 (result[1], 1'b0, 1'b0);
		
		fullAdder f1(.a(a), .b(b), .ci(cin), .co(coResult[2]), .sum(result[2]));

		not #50 c24 (notb, b);
		
		fullAdder f2(.a(a), .b(notb), .ci(cin), .co(coResult[3]), .sum(result[3]));	
		
		and #50 c3 (result[4], a, b);					// Bitwise and
		
		or  #50 c4 (result[5], a, b); 					// Bitwise or
		
		xor #50 c5 (result[6], a, b);					// Bitwise xor
		
		or  #50 c19 (result[7], 1'b0, 1'b0);
		
		or  #50 c6 (t1, control[1], control[0]);		// or control 1 and 0
		not #50 c7 (t2, control[2]);						// invert control[2]
		and #50 c8 (coSelect[1], t1, t2);				// Whether CO should matter
		
		or  #50 c21 (coSelect[0], control[0], 1'b0);
		or  #50 c22 (coResult[0], 1'b0, 1'b0);
		or  #50 c23 (coResult[1], 1'b0, 1'b0);
	
		multiplexor8to1 m1(.in(result), .out(out), .select(control)); 
		multiplexor4to1 m2(.in(coResult), .out(co), .select(coSelect));
		
endmodule

module alu1bit_test();
	
	logic a, b, cin;
	logic [2:0] control;
	logic co, out;
	
	alu_1bit_slice al1(a, b, cin, co, control, out);

	integer i;
		
	initial begin   
		a = 1'b0; b = 1'b0; cin = 1'b0;
		control = 3'b010;
		#1000;
		a = 1'b1; b = 1'b0; cin = 1'b0;
		#1000;
		a = 1'b0; b = 1'b1; cin = 1'b0;
		#1000;
		a = 1'b1; b = 1'b1; cin = 1'b0;
		#1000;
		/*
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b0; b = 1'b1; cin = 1'b0;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b1; b = 1'b0; cin = 1'b0;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b1; b = 1'b1; cin = 1'b0;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		
		a = 1'b0; b = 1'b0; cin = 1'b1;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b0; b = 1'b1; cin = 1'b1;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b1; b = 1'b0; cin = 1'b1;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end
		a = 1'b1; b = 1'b1; cin = 1'b1;
		for (i = 0; i < 6; i++) begin
			control = i;
			#200;
		end*/
	end  

endmodule
