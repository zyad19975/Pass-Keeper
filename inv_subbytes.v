
module inv_subbytes ( in, out );
  input [127:0] in;
  output [127:0] out;


  inv_sbox_0 sb1 ( .in(in[127:120]), .out(out[127:120]) );
  inv_sbox_15 sb2 ( .in(in[119:112]), .out(out[119:112]) );
  inv_sbox_14 sb3 ( .in(in[111:104]), .out(out[111:104]) );
  inv_sbox_13 sb4 ( .in(in[103:96]), .out(out[103:96]) );
  inv_sbox_12 sb5 ( .in(in[95:88]), .out(out[95:88]) );
  inv_sbox_11 sb6 ( .in(in[87:80]), .out(out[87:80]) );
  inv_sbox_10 sb7 ( .in(in[79:72]), .out(out[79:72]) );
  inv_sbox_9 sb8 ( .in(in[71:64]), .out(out[71:64]) );
  inv_sbox_8 sb9 ( .in(in[63:56]), .out(out[63:56]) );
  inv_sbox_7 sb10 ( .in(in[55:48]), .out(out[55:48]) );
  inv_sbox_6 sb11 ( .in(in[47:40]), .out(out[47:40]) );
  inv_sbox_5 sb12 ( .in(in[39:32]), .out(out[39:32]) );
  inv_sbox_4 sb13 ( .in(in[31:24]), .out(out[31:24]) );
  inv_sbox_3 sb14 ( .in(in[23:16]), .out(out[23:16]) );
  inv_sbox_2 sb15 ( .in(in[15:8]), .out(out[15:8]) );
  inv_sbox_1 sb16 ( .in(in[7:0]), .out(out[7:0]) );
endmodule

