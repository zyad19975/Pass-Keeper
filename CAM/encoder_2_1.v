

module encoder_2_1
(
    input  wire [1:0]   input_unencoded,
    output wire         output_valid,
    output wire         output_encoded
);

assign output_valid = |input_unencoded;
assign output_encoded = input_unencoded[1];

endmodule
