/*
------Round Module------
inputs: 
	1- in -128 bit wire- (State)
	2- round_num -128 bit wire- (Round Number)
	3- keyin -128 bit wire- (input key)
output: 
	1- keyout -128 bit register- (output of this round and input to the next round)
	2- out -128 bit register- (output of this round and input to the next round)
Description:
	- the input passes by these modules in order:
	  key generation, substitute bytes, shift rows,
	  mix columns, add round key
	
*/
module round (
	input wire [127:0]in,
	input wire[3:0]round_num,
	input wire [127:0]keyin,
	output reg [127:0]keyout, 
	output reg[127:0]out
	);
	
	wire [127:0]sb_out, sr_out, mc_out,  kout,oout;
	
	keygen x(round_num, keyin, kout); 	 
	
	subbytes sb(in, sb_out);
	shift_rows sr(sb_out, sr_out);
	Mix_Column mc(sr_out, mc_out);
	add_round_keys adk(mc_out, kout, oout);  
	
	always@*
		begin
			keyout=kout;
			out =oout;
			
		end
	
	
	
endmodule

