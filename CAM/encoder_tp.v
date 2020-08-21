`timescale 1ns / 1ps

module enc_tp();

    reg [15:0] input_unencoded;
    reg clk;
    wire output_valid;
    wire [3:0 ]output_encoded;
encoder #(
    .WIDTH (16)

)
inst (
    .clk(clk),
    .input_unencoded(input_unencoded),
    .output_valid(output_valid),
    .output_encoded(output_encoded)
);
     always 
        begin
        #50 
        clk = ~clk;
    end
initial
begin
clk = 0;
input_unencoded = 16'h1000; 
end
endmodule