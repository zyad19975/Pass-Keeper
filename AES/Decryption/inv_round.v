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
`timescale 1ns / 1ps

module inv_round (
	input wire [127:0]in,
	input wire last,
	input wire [127:0]keyin,
	output reg[127:0]out
	);
	
	wire [127:0]sb_out, sr_out, mc_out,  kout,oout;
	
	assign kout=keyin;
	
	inv_shift_rows sr(in, sr_out);
	always @(sr_out)begin

end
	inv_subbytes sb(sr_out, sb_out);
		always @(sb_out)begin

end
	inv_add_round_keys adk(sb_out, kout, oout);
			always @(oout)begin

end

	inv_Mix_Column mc(oout, mc_out);  
			always @(mc_out)begin

end
	always@*
		begin
			if (last==0)
			begin 
			out =mc_out;
			end
			else 
				begin 
			out =oout;
			end
			
		end

			
endmodule


