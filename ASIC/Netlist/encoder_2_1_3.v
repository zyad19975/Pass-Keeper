
module encoder_2_1_3 ( input_unencoded, output_valid, output_encoded );
  input [1:0] input_unencoded;
  output output_valid, output_encoded;

  assign output_encoded = input_unencoded[1];

  OR2X1_HVT U1 ( .A1(input_unencoded[0]), .A2(input_unencoded[1]), .Y(
        output_valid) );
endmodule

