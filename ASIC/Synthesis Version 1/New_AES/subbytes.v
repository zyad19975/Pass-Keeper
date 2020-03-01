
module subbytes ( in, out );
  input [127:0] in;
  output [127:0] out;
  wire   n1, n2;

  sbox_16 sb1 ( .in(in[127:120]), .out(out[127:120]) );
  sbox_15 sb2 ( .in(in[119:112]), .out(out[119:112]) );
  sbox_14 sb3 ( .in(in[111:104]), .out(out[111:104]) );
  sbox_13 sb4 ( .in(in[103:96]), .out(out[103:96]) );
  sbox_12 sb5 ( .in({in[95], n2, in[93:88]}), .out(out[95:88]) );
  sbox_11 sb6 ( .in(in[87:80]), .out(out[87:80]) );
  sbox_10 sb7 ( .in(in[79:72]), .out(out[79:72]) );
  sbox_9 sb8 ( .in(in[71:64]), .out(out[71:64]) );
  sbox_8 sb9 ( .in(in[63:56]), .out(out[63:56]) );
  sbox_7 sb10 ( .in(in[55:48]), .out(out[55:48]) );
  sbox_6 sb11 ( .in(in[47:40]), .out(out[47:40]) );
  sbox_5 sb12 ( .in(in[39:32]), .out(out[39:32]) );
  sbox_4 sb13 ( .in(in[31:24]), .out(out[31:24]) );
  sbox_3 sb14 ( .in(in[23:16]), .out(out[23:16]) );
  sbox_2 sb15 ( .in(in[15:8]), .out(out[15:8]) );
  sbox_1 sb16 ( .in(in[7:0]), .out(out[7:0]) );
  INVX0_HVT U1 ( .A(in[94]), .Y(n1) );
  INVX1_HVT U2 ( .A(n1), .Y(n2) );
endmodule

