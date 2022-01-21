//James Jhong
//Jean Kim
//EE469 Lab 2
//1/18/2022

//This module is a 1 bit slice of the alu, a 4:1 mux.
//It can handle 4 operations, addition, subtraction, AND and OR.
//It has two inputs A and B. 

module alu_1bit_slice(a, b, cin, co, control, out);
    //add or subtract, Cin, Cout, uses the 2 x 1 mux to determine which one

        input logic a, b, cin;
        input logic [2:0] control;
        output logic co, out;

        // First calculate all values according to control
        // Then push it through MUX8to1

        logic [7:0] result;
        logic [3:0] coResult;
        logic [1:0] coSelect, t1, t2;

        assign result[0] = b;                                            // Pass B

        // Sum and Sub should calc with cin
        or  #50 c1 (result[1], a, b);                        // Sum
        xor #50 c2 (result[2], a, b);                        // Sub

        and #50 c3 (result[3], a, b);                        // Bitwise and
        or  #50 c4 (result[4], a, b);                     // Bitwise or
        xor #50 c5 (result[5], a, b);                        // Bitwise xor
        assign result[6] = 1'b0;
        assign result[7] = 1'b0;

        // CO when Sum
        and #50 c6 (coResult[0], a, b);
        // CO when Sub
        //coResult[1]


        or  #50 c6 (t1, control[1], control[0]);        // or control 1 and 0
        not #50 c7 (t2, control[2]);                        // invert control[2]
        and #50 c8 (coSelect[1], t1, t2);                // Whether CO should matter

        assign coSelect[0] = 1'b0;
        assign coResult[2] = 1'b0;
        assign coResult[3] = 1'b0;

        multiplxor8to1 m1(.in(result), .select(control), .out(out)); 
        multiplexor4to1 m2(.in(coResult), .out(co), .select(coSelect));
		  //carryout logic needed still
endmodule
