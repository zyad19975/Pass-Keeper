/*
------Shift Rows Module------
inputs :
	1- in -128 bit wire- (state)
outputs : 
	1- out -128 bit register- (output)
Description :
	- assume input is in the right order (consecutive 16 bytes -> 
	15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0) 4 by 4 
	matrix is as follows:
	
	before shifting
	[15 11  7  3]
	[14 10  6  2]
	[13  9  5  1]
	[12  8  4  0]
	
	[[127 : 120] [95 : 88]  [63 : 56]  [31 : 24]]
	[[119 : 112] [87 : 80]  [55 : 48]  [23 : 16]]
	[[111 : 104] [79 : 72]  [47 : 40]  [15 : 8] ]
	[[103 : 96]  [71 : 64]  [39 : 32]  [7 : 0]  ]
	
	after shifting
	[15 11  7  3]
	[2  14 10  6]
	[5  1  13  9]
	[8  4  0  12]
	
	[[127 : 120] [95 : 88]   [63 : 56]   [31 : 24]]
	[[23 : 16]   [119 : 112] [87 : 80]   [55 : 48]]
	[[47 : 40]   [15 : 8]    [111 : 104] [79 : 72]]
	[[71 : 64]   [39 : 32]   [7 : 0]    [103 : 96]]

*/

`timescale 1ns / 1ps

module inv_shift_rows(
	input wire[127 : 0] in,
	output reg[127 : 0] out
	);
			 
	always @*
		begin
			out = {in[127:120], in[23:16], in[47:40], in[71:64], in[95:88], in[119:112], in[15:8], in[39:32], in[63:56], in[87:80], in[111:104], in[7:0], in[31:24], in[55:48], in[79:72], in[103:96]};			
		end

endmodule


