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
	input wire[127:0]plaintext1,
	input wire[127:0]key,
	output reg[127:0]cipher_text,
	output reg[127:0] keyout 
);
wire [0:127]keys[0:10];
wire[127:0]plaintext;
assign keys[0]=128'h2b7e151628aed2a6abf7158809cf4f3c;
assign plaintext=128'h3925841d02dc09fbdc118597196a0b32;

inv_keygen as1(4'h1,keys[0],keys[1]);
inv_keygen as2(4'h2,keys[1],keys[2]);
inv_keygen as3(4'h3,keys[2],keys[3]);
inv_keygen as4(4'h4,keys[3],keys[4]);
inv_keygen as5(4'h5,keys[4],keys[5]);
inv_keygen as6(4'h6,keys[5],keys[6]);
inv_keygen as7(4'h7,keys[6],keys[7]);
inv_keygen as8(4'h8,keys[7],keys[8]);
inv_keygen as9(4'h9,keys[8],keys[9]);
inv_keygen as10(4'ha,keys[9],keys[10]);
//add inv_round key 
wire [127:0] adk_out0;
inv_add_round_keys adk_0(plaintext, keys[10-0], adk_out0);

//inv_round 1

wire [127:0] out1;
inv_round r1 (adk_out0,0,keys[10-1],out1);

//inv_round 2dd

wire [127:0] out2;
inv_round r2 (out1,0,keys[10-2],out2);

//inv_round 3

wire [127:0] out3;
inv_round r3 (out2,0,keys[10-3],out3);

//inv_round 4

wire [127:0] out4;
inv_round r4 (out3,0,keys[10-4],out4);

//inv_round 5

wire [127:0] out5;
inv_round r5 (out4,0,keys[10-5],out5);

//inv_round 6

wire [127:0] out6;
inv_round r6 (out5,0,keys[10-6],out6);

//inv_round 7

wire [127:0] out7;
inv_round r7 (out6,0,keys[10-7],out7);

//inv_round 8
wire [127:0] out8;
inv_round r8 (out7,0,keys[10-8],out8);
//inv_round 9

wire [127:0] out9;
inv_round r9 (out8,0,keys[10-9],out9);

//inv_round 10

wire [127:0] out10;
inv_round r10 (out9,1,keys[10-10],out10);

always @*
begin
cipher_text=out10;
end


endmodule
