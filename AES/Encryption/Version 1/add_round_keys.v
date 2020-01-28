/*
* ------ADD Round Key Module------
Inputs :
	1- State -128 bit wire- (Plaintext after passing by n modules)
	2- subkey  -128 bit wire- (specific key for each round)
Outputs : 
	1- out -128 bit register- (output)
 	   
Description :
	-In this module, the state is ored with the subkey
*/
module add_round_keys(
	input wire[127 : 0] state,
	input wire[127 : 0] subkey,
	output reg[127 : 0] out
	);
	always @*
		begin
			out = state ^ subkey;
		end
endmodule

