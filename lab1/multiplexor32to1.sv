module multiplexor32to1(in, out, select);
	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	
	logic[1:0] outputs;
	
	multiplexor16to1 m1 (in[15:0], outputs[0], select[3:0]);
	multiplexor16to1 m2 (in[31:16], outputs[1], select[3:0]);
	multiplexor2to1 m3 (outputs, out, select[4]);
endmodule

module mux32_1_testbench();     
  logic [31:0]  in;  
  logic [4:0] select;
  logic  out;      
       
  mux32_1 dut (in, out, select);      
     
  integer i;   
  initial begin   
    for(i=0; i<32; i++) begin   
      in[31:0]= i; select[4:0] = i; #10;
    end   
  end   
endmodule  