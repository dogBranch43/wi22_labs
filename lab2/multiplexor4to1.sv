`timescale 1ns/10ps
module multiplexor4to1(in, out, select);
	input logic [3:0] in;
	input logic [1:0] select;
	output logic out;
	
	logic [1:0] outputs;
	
	multiplexor2to1 m2 (in[1:0] , outputs[0], select[0]);
	multiplexor2to1 m1 (in[3:2], outputs[1], select[0]);
	multiplexor2to1 m3 (outputs, out, select[1]);
	
endmodule

module mux4_1_testbench();     
  logic [3:0]  in;  
  logic [1:0] select;
  logic  out;      
       
  mux4_1 dut (in, out, select);      
     
  integer i;   
  initial begin   
    for(i=0; i<4; i++) begin   
      in[3:0]= i; select[1:0] = i; #10;
    end   
  end   
endmodule   
 