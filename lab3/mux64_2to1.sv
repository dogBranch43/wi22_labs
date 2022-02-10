module mux64_2to1(i0, i1, out, select) ;
    input logic [63:0] i0, i1;
    input logic select;
    output logic [63:0] out;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : muxchain
            multiplexor2to1 mI (.in({i0[i], i1[i]}), .out(out[i]), .select);
        end
    endgenerate
endmodule
