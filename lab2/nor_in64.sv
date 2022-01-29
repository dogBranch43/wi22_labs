//James Jhong
//Jean Kim
//EE469 Lab 2
//1/18/2022

//This module acts as a nor gate for 64 inputs, assuming the inputs come in as an array of bits
  `timescale 1ns/10ps
 module nor_in64(in ,zeroFlag) ;
	output logic zeroFlag;
	input logic [63 : 0] in;
	logic [15 : 0] temp;
	
	genvar i;
	generate
		for (i = 0; i < 64; i = i + 4) begin
			or #50 checkFour (temp[i / 4], in[i], in[i + 1], in[i + 2], in[i + 3]);
		end
	endgenerate
	
  logic [3:0] norCheck;
	nor #50 (norCheck[0],temp[0] ,temp[1] ,temp[2] ,temp[3]);
	nor #50 (norCheck[1],temp[4] ,temp[5] ,temp[6] ,temp[7]);
	nor #50 (norCheck[2],temp[8] ,temp[9] ,temp[10] ,temp[11]); 
	nor #50 (norCheck[3],temp[12] ,temp[13] ,temp[14] ,temp[15]);
	
	and #50 (zeroFlag, norCheck[0], norCheck[1], norCheck[2], norCheck[3]);
endmodule
