/*
* ------AES Top Module------
Inputs :
	1- PlainText -128 bit wire- (which is sometimes refered to as State)
	2- Key  -128 bit wire-
Outputs : 
	1- CipherText -128 bit register- 
	2- keyout -128 bit- the final key that have passed by all the shifts 
	   (used for testing in AES decryption) 
 	   
Description :
	-AES Top Module consists of an initial ADD inv_round Key, 9 similar inv_rounds
	 and a last inv_round
	-The output of each inv_round (state and keyout) is the input of the next inv_round
*/

module inv_aes(
	input wire[127:0]plaintext,
	input wire[127:0]key,
	output reg[127:0]cipher_text,
	output reg[127:0] keyout 
);


//add inv_round key 
wire [127:0] adk_out0;
inv_add_round_keys adk_0(plaintext, key, adk_out0);

//inv_round 1
wire [127:0] keyout1;
wire [127:0] out1;
inv_round r1 (adk_out0,4'h1,key,keyout1,out1);

//inv_round 2dd
wire [127:0] keyout2;
wire [127:0] out2;
inv_round r2 (out1,4'h2,keyout1,keyout2,out2);

//inv_round 3
wire [127:0] keyout3;
wire [127:0] out3;
inv_round r3 (out2,4'h3,keyout2,keyout3,out3);

//inv_round 4
wire [127:0] keyout4;
wire [127:0] out4;
inv_round r4 (out3,4'h4,keyout3,keyout4,out4);

//inv_round 5
wire [127:0] keyout5;
wire [127:0] out5;
inv_round r5 (out4,4'h5,keyout4,keyout5,out5);

//inv_round 6
wire [127:0] keyout6;
wire [127:0] out6;
inv_round r6 (out5,4'h6,keyout5,keyout6,out6);

//inv_round 7
wire [127:0] keyout7;
wire [127:0] out7;
inv_round r7 (out6,4'h7,keyout6,keyout7,out7);

//inv_round 8
wire [127:0] keyout8;
wire [127:0] out8;
inv_round r8 (out7,4'h8,keyout7,keyout8,out8);
//inv_round 9
wire [127:0] keyout9;
wire [127:0] out9;
inv_round r9 (out8,4'h9,keyout8,keyout9,out9);

//inv_round 10
wire [127:0] keyout10;
wire [127:0] out10;

inv_last_round r10(out9,4'ha,keyout9,keyout10,out10);
always @*
begin
keyout=keyout10;
cipher_text=out10;
end
//

endmodule
