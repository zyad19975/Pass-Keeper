module add_round_keys(
	input [127 : 0] state,
	input [127 : 0] subkey,
	output [127 : 0] out
	);

assign out = state ^ subkey;

endmodule

