
module encoder_WIDTH16 ( clk, input_unencoded, output_valid, output_encoded );
  input [15:0] input_unencoded;
  output [3:0] output_encoded;
  input clk;
  output output_valid;
  wire   n23, n24, n25, n26, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19;
  wire   [7:0] encoded;
  wire   [7:0] out;

  DFFX1_HVT \output_encoded_reg[3]  ( .D(n26), .CLK(clk), .Q(output_encoded[3]) );
  DFFX1_HVT \output_encoded_reg[2]  ( .D(n25), .CLK(clk), .Q(output_encoded[2]) );
  DFFX1_HVT \output_encoded_reg[1]  ( .D(n24), .CLK(clk), .Q(output_encoded[1]) );
  DFFX1_HVT \output_encoded_reg[0]  ( .D(n23), .CLK(clk), .Q(output_encoded[0]) );
  encoder_2_1_0 \slice[0].enc_inst  ( .input_unencoded(input_unencoded[1:0]), 
        .output_valid(encoded[0]), .output_encoded(out[0]) );
  encoder_2_1_7 \slice[2].enc_inst  ( .input_unencoded(input_unencoded[3:2]), 
        .output_valid(encoded[1]), .output_encoded(out[1]) );
  encoder_2_1_6 \slice[4].enc_inst  ( .input_unencoded(input_unencoded[5:4]), 
        .output_valid(encoded[2]), .output_encoded(out[2]) );
  encoder_2_1_5 \slice[6].enc_inst  ( .input_unencoded(input_unencoded[7:6]), 
        .output_valid(encoded[3]), .output_encoded(out[3]) );
  encoder_2_1_4 \slice[8].enc_inst  ( .input_unencoded(input_unencoded[9:8]), 
        .output_valid(encoded[4]), .output_encoded(out[4]) );
  encoder_2_1_3 \slice[10].enc_inst  ( .input_unencoded(input_unencoded[11:10]), .output_valid(encoded[5]), .output_encoded(out[5]) );
  encoder_2_1_2 \slice[12].enc_inst  ( .input_unencoded(input_unencoded[13:12]), .output_valid(encoded[6]), .output_encoded(out[6]) );
  encoder_2_1_1 \slice[14].enc_inst  ( .input_unencoded(input_unencoded[15:14]), .output_valid(encoded[7]), .output_encoded(out[7]) );
  AO21X1_HVT U3 ( .A1(output_encoded[3]), .A2(n1), .A3(n2), .Y(n26) );
  NAND4X0_HVT U4 ( .A1(n3), .A2(n4), .A3(n5), .A4(n6), .Y(n25) );
  NAND3X0_HVT U5 ( .A1(n7), .A2(n8), .A3(n9), .Y(n4) );
  NAND2X0_HVT U6 ( .A1(output_encoded[2]), .A2(n1), .Y(n3) );
  AO221X1_HVT U7 ( .A1(n10), .A2(n5), .A3(output_encoded[1]), .A4(n1), .A5(
        encoded[7]), .Y(n24) );
  AO21X1_HVT U8 ( .A1(n11), .A2(n7), .A3(encoded[5]), .Y(n10) );
  AO21X1_HVT U9 ( .A1(encoded[1]), .A2(n12), .A3(encoded[3]), .Y(n11) );
  MUX21X1_HVT U10 ( .A1(output_encoded[0]), .A2(n13), .S0(output_valid), .Y(
        n23) );
  INVX0_HVT U11 ( .A(n1), .Y(output_valid) );
  NOR4X0_HVT U12 ( .A1(n9), .A2(n2), .A3(encoded[0]), .A4(encoded[1]), .Y(n1)
         );
  NAND4X0_HVT U13 ( .A1(n7), .A2(n8), .A3(n5), .A4(n6), .Y(n2) );
  OR2X1_HVT U14 ( .A1(encoded[3]), .A2(encoded[2]), .Y(n9) );
  MUX21X1_HVT U15 ( .A1(out[7]), .A2(n14), .S0(n6), .Y(n13) );
  INVX0_HVT U16 ( .A(encoded[7]), .Y(n6) );
  MUX21X1_HVT U17 ( .A1(out[6]), .A2(n15), .S0(n5), .Y(n14) );
  INVX0_HVT U18 ( .A(encoded[6]), .Y(n5) );
  MUX21X1_HVT U19 ( .A1(out[5]), .A2(n16), .S0(n8), .Y(n15) );
  INVX0_HVT U20 ( .A(encoded[5]), .Y(n8) );
  MUX21X1_HVT U21 ( .A1(out[4]), .A2(n17), .S0(n7), .Y(n16) );
  INVX0_HVT U22 ( .A(encoded[4]), .Y(n7) );
  MUX21X1_HVT U23 ( .A1(n18), .A2(out[3]), .S0(encoded[3]), .Y(n17) );
  MUX21X1_HVT U24 ( .A1(out[2]), .A2(n19), .S0(n12), .Y(n18) );
  INVX0_HVT U25 ( .A(encoded[2]), .Y(n12) );
  MUX21X1_HVT U26 ( .A1(out[0]), .A2(out[1]), .S0(encoded[1]), .Y(n19) );
endmodule

