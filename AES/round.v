module round (
	input [127:0]in,
	input [127:0]round_num,
	input [127:0]keyin,
	input [127:0]keyout, 
	output [127:0]out
);

wire sb_out, sr_out, mc_out, out4;
keygen(round_num, keyin, keyout);
subbytes sb(in, sb_out);
shift_rows sr(sb_out, sr_out);
Mix_Column mc(sr_out, mc_out);
add_round_keys adk(mc_out, key, out);

endmodule

