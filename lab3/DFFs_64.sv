module DFFs_64(clk, rst, in, out);
    input logic [63:0] in;
    input logic clk, rst;
    output logic [63:0] out;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : dfs
            D_FF dI (.q(out[i]), .d(in[i]), .reset(rst), .clk(clk));
        end
    endgenerate

endmodule
