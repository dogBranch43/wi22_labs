module zeroExtender #(parameter SIZE = 9)(addr, out) ;
    input logic [SIZE - 1 : 0] addr;
    output logic [63 : 0] out;

    assign out[SIZE - 1 : 0] = addr;

    genvar i;
    generate
        for (i = SIZE; i < 64; i++) begin : extend
            assign out[i] = 0;
        end
    endgenerate
endmodule
