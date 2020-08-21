
module encoder_WIDTH16 ( clk, input_unencoded, output_valid, output_encoded );
  input [15:0] input_unencoded;
  output [3:0] output_encoded;
  input clk;
  output output_valid;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n2, n3, n4, n5, n6, n7, n8;
  wire   [7:0] encoded;
  wire   [7:0] out;

  DFFX1_HVT \output_encoded_reg[3]  ( .D(n26), .CLK(clk), .Q(output_encoded[3]) );
  DFFX1_HVT \output_encoded_reg[2]  ( .D(n25), .CLK(clk), .Q(output_encoded[2]) );
  DFFX1_HVT \output_encoded_reg[1]  ( .D(n24), .CLK(clk), .Q(output_encoded[1]) );
  DFFX1_HVT \output_encoded_reg[0]  ( .D(n23), .CLK(clk), .Q(output_encoded[0]) );
  NOR4X1_HVT U3 ( .A1(n20), .A2(n22), .A3(encoded[0]), .A4(encoded[1]), .Y(n9)
         );
  AO22X1_HVT U12 ( .A1(output_encoded[0]), .A2(n9), .A3(n10), .A4(output_valid), .Y(n23) );
  AO22X1_HVT U13 ( .A1(out[7]), .A2(encoded[7]), .A3(n11), .A4(n2), .Y(n10) );
  AO22X1_HVT U14 ( .A1(out[6]), .A2(encoded[6]), .A3(n12), .A4(n3), .Y(n11) );
  AO22X1_HVT U15 ( .A1(out[5]), .A2(encoded[5]), .A3(n13), .A4(n4), .Y(n12) );
  AO22X1_HVT U16 ( .A1(out[4]), .A2(encoded[4]), .A3(n14), .A4(n5), .Y(n13) );
  AO22X1_HVT U17 ( .A1(out[3]), .A2(encoded[3]), .A3(n15), .A4(n6), .Y(n14) );
  AO22X1_HVT U18 ( .A1(out[2]), .A2(encoded[2]), .A3(n16), .A4(n7), .Y(n15) );
  AO22X1_HVT U19 ( .A1(out[1]), .A2(encoded[1]), .A3(out[0]), .A4(n8), .Y(n16)
         );
  AO221X1_HVT U20 ( .A1(n17), .A2(n3), .A3(output_encoded[1]), .A4(n9), .A5(
        encoded[7]), .Y(n24) );
  AO21X1_HVT U21 ( .A1(n18), .A2(n5), .A3(encoded[5]), .Y(n17) );
  AO21X1_HVT U22 ( .A1(encoded[1]), .A2(n7), .A3(encoded[3]), .Y(n18) );
  AO221X1_HVT U23 ( .A1(n19), .A2(n20), .A3(output_encoded[2]), .A4(n9), .A5(
        n21), .Y(n25) );
  AND2X1_HVT U24 ( .A1(n5), .A2(n4), .Y(n19) );
  AO21X1_HVT U25 ( .A1(output_encoded[3]), .A2(n9), .A3(n22), .Y(n26) );
  OR3X1_HVT U26 ( .A1(encoded[4]), .A2(encoded[5]), .A3(n21), .Y(n22) );
  NAND2X0_HVT U27 ( .A1(n2), .A2(n3), .Y(n21) );
  NAND2X0_HVT U28 ( .A1(n6), .A2(n7), .Y(n20) );
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
  INVX0_HVT U4 ( .A(n9), .Y(output_valid) );
  INVX0_HVT U5 ( .A(encoded[7]), .Y(n2) );
  INVX0_HVT U6 ( .A(encoded[6]), .Y(n3) );
  INVX0_HVT U7 ( .A(encoded[5]), .Y(n4) );
  INVX0_HVT U8 ( .A(encoded[4]), .Y(n5) );
  INVX0_HVT U9 ( .A(encoded[3]), .Y(n6) );
  INVX0_HVT U10 ( .A(encoded[2]), .Y(n7) );
  INVX0_HVT U11 ( .A(encoded[1]), .Y(n8) );
endmodule

