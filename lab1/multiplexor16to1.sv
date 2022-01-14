module multiplexor16to1(in, out, select);
	input logic [15:0] in;
	input logic [3:0] select;
	output logic out;
	
	
	logic [3:0] outputs;
	
	multiplexor4to1 m1 (in[3:0], outputs[0], select[1:0]);
	multiplexor4to1 m2 (in[7:4], outputs[1], select[1:0]);
	multiplexor4to1 m3 (in[11:8], outputs[2], select[1:0]);
	multiplexor4to1 m4 (in[15:12], outputs[3], select[1:0]);
	multiplexor4to1 m5 (outputs, out, select[3:2]);
	
endmodule

module mux16_1_testbench();     
  logic [15:0]  in;  
  logic [3:0] select;
  logic  out;      
       
  mux16_1 dut (in, out, select);      
     
  integer i;   
  initial begin   
    for(i=0; i<16; i++) begin   
      in[15:0]= i; select[3:0] = i; #10;
    end   
  end   
endmodule  