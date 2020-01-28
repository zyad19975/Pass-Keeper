/*
* ------Substitute Bytes Module------
Inputs :
	1- in -128 bit wire- (State)
Outputs : 
	1- out -128 bit register- (output)
 	   
Description :
	-In this module, every byte from the input is substituted with
	 another byte using the sbox
*/

module inv_subbytes(
	input wire[127 : 0] in,
	output reg [127 : 0] out
	);
	
	//we want to subsitute 16 bytes with another 16 bytes, so we will call sbox module 16 times
	
	wire [7:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16;
	
	inv_sbox sb1(in[127:120], out1);
	inv_sbox sb2(in[119:112], out2);
	inv_sbox sb3(in[111:104], out3);
	inv_sbox sb4(in[103:96], out4);
	inv_sbox sb5(in[95:88], out5);
	inv_sbox sb6(in[87:80], out6);
	inv_sbox sb7(in[79:72], out7);
	inv_sbox sb8(in[71:64], out8);
	inv_sbox sb9(in[63:56], out9);
	inv_sbox sb10(in[55:48], out10);
	inv_sbox sb11(in[47:40], out11);
	inv_sbox sb12(in[39:32], out12);
	inv_sbox sb13(in[31:24], out13);
	inv_sbox sb14(in[23:16], out14);
	inv_sbox sb15(in[15:8], out15);
	inv_sbox sb16(in[7:0], out16);
	always @*
		begin
			 out = {out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16};
		end
	
endmodule

