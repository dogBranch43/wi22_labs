
`timescale 1ps / 1ps

module multiplexor2to1 (in, out, select) ;
	input logic select;
	input logic [1:0] in;
	output logic out;
	
	logic invertedSelect, result1, result2;
	
	not #50 inv (invertedSelect, select);
	and #50 step1 (result1, in[0], invertedSelect);
	and #50 step2 (result2, in[1], select);
	or #50 step3 (out, result1, result2);
	
endmodule

module multiplexor2to1_testbench();   
  logic [1:0] in;
  logic select;  
  logic out;   
     
  mulitiplexor2to1 dut (in, out, select);   
   
  initial begin   
    select=0; in[0]=0; in[1]=0; #10;    
    select=0; in[0]=0; in[1]=1; #10;    
    select=0; in[0]=1; in[1]=0; #10;    
    select=0; in[0]=1; in[1]=1; #10;    
    select=1; in[0]=0; in[1]=0; #10;    
    select=1; in[0]=0; in[1]=1; #10;    
    select=1; in[0]=1; in[1]=0; #10;    
    select=1; in[0]=1; in[1]=1; #10;    
  end   
endmodule 