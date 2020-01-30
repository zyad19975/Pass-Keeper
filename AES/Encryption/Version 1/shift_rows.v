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
	
	after shifting
	[15 11  7  3]
	[10  6  2 14]
	[5  1  13  9]
	[0  12  8  4]
*/

module shift_rows(
	input wire[127 : 0] in,
	output reg[127 : 0] out
	);
			 
	always @*
		begin
			out = {in[127:120], in[87:80], in[47:40], in[7:0], in[95:88], in[55:48], in[15:8], in[103:96], in[63:56], in[23:16], in[111:104], in[71:64], in[31:24], in[119:112], in[79:72], in[39:32]};
			
		end

endmodule

