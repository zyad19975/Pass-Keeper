module aes(
	input wire[127:0]plaintext,
	input wire[127:0]key,
  //  output reg[127:0] keyout,
    input clk,
    input reset,
  	output wire[127:0]cipher_text,
    output reg ready

 
);
  
  reg[3:0] round_number  ;
  wire [127:0] adk_out0;
  wire [127:0] keyout;
  wire[127:0] out;
  reg [127:0] adk_in;
  reg [127:0] key_round;
  
  
  add_round_keys adk_0(plaintext, key, adk_out0);
  round r1 (adk_in,round_number,key_round,keyout,out);
  assign cipher_text = out;

  always @(posedge clk)
    begin
      if( reset)
     begin
       round_number <= 0;
       ready <= 0;
       
      end
      else if(round_number < 10)
     begin
       
       if(round_number == 0)
             begin
           adk_in <= adk_out0;
           key_round <= key;
             end
           else
             begin
           adk_in <= out;
           key_round <=keyout;
           if(round_number == 10)
                 begin
                     ready <= 1;
                 end
             end
           
           round_number <= round_number + 1;

     end
      
  
    end
//add round key 

  
 

endmodule


/*.........................................AES...............................................*/


module add_round_keys(
	input wire[127 : 0] state,
	input wire[127 : 0] subkey,
//  output reg[127 : 0] out
    output [127 : 0] out
	);
	//always @*
	//	begin
		assign out = state ^ subkey;
	//	end
endmodule

/*...........................ADD ROUND KEY..............................................*/
`timescale 1ns / 1ps

module keygen(round_num,keyin,keyout);
	
	input wire [0:3] round_num;
	input wire [0:127]keyin;
	output reg [0:127] keyout;
	
	reg [0:31] block1 ,block2,block3,block4;
	wire [0:31] dummy;
	
	
	
	
	always @(keyin)	 
		begin
			block1 = keyin[0 : 31];					//		| b1 | b2 | b3 | b4 |
			block2 = keyin[32: 63];					//		| b1 | b2 | b3 | b4 |
			block3 = keyin[64: 95];					//		| b1 | b2 | b3 | b4 |
			block4 = keyin[96:127];					//		| b1 | b2 | b3 | b4 |	
		end
	
	
	
	
	// sboxing &shift	
	sbox a1(block4[8 :15],dummy [0 : 7]);
	sbox a2(block4[16:23],dummy [8 :15]);
	sbox a3(block4[24:31],dummy [16:23]);	  
	sbox a4(block4[0 : 7],dummy [24:31]);	  
	////////////
	
	always @*
		begin
			// assign output						  
			keyout[0  : 31] = block1 ^ dummy ^ rcon(round_num);
			keyout[32 : 63] = block1 ^ dummy ^ rcon(round_num)^ block2;
			keyout[64 : 95] = block1 ^ dummy ^ rcon(round_num)^ block3 ^ block2;
			keyout[96 :127] = block1 ^ dummy ^ rcon(round_num)^ block4 ^ block3 ^ block2;
			
		end
	
	
	
	
	function [0:31]	rcon;
		input	[0:3]	roundnum;
		case(roundnum)	
			4'h1: rcon=32'h01_00_00_00;
			4'h2: rcon=32'h02_00_00_00;
			4'h3: rcon=32'h04_00_00_00;
			4'h4: rcon=32'h08_00_00_00;
			4'h5: rcon=32'h10_00_00_00;
			4'h6: rcon=32'h20_00_00_00;
			4'h7: rcon=32'h40_00_00_00;
			4'h8: rcon=32'h80_00_00_00;
			4'h9: rcon=32'h1b_00_00_00;
			4'ha: rcon=32'h36_00_00_00;
			default: rcon=32'h00_00_00_00;
		endcase
		
	endfunction
	
	
endmodule
/*......................................KEY GENERATION...................................*/

module Mix_Column(input wire[127:0]in, output reg[127:0]out);
  function [7:0] mul_2(input [7:0] byte1);  // multiply by 2 "x" 
    begin 
      if(byte1[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_2 = byte1<<1;
      else
        mul_2 = (byte1<<1)^(8'h1b); // if MSB = 1, (SLL by 1) XOR 1B
    end
  endfunction

  function [7:0] mul_3(input [7:0] byte1); // multiply by 3 "x + 1"
    begin
      if(byte1[7]==1'b0)		// if MSB = 0, SLL by 1 XOR itself "byte"
        mul_3 = (byte1<<1)^(byte1);
      else
        mul_3 = (byte1<<1)^(byte1)^(8'h1b); // if MSB = 1, (SLL by 1) XOR 1B XOR itself "byte"
    end
  endfunction


  function [7:0] mix_column0(input [31:0] word); 	// 1st matrix's column 
    begin
      mix_column0 = word[7:0]^word[15:8]^mul_3(word[23:16])^mul_2(word[31:24]); // multiplying and adding with [02 03 01 01] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column1(input [31:0] word);	// 2nd matrix's column 
    begin
      mix_column1 = word[7:0]^mul_3(word[15:8])^mul_2(word[23:16])^word[31:24]; // multiplying and adding with [01 02 03 01] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column2(input [31:0] word);	// 3rd matrix's column 
    begin
      mix_column2 = mul_3(word[7:0])^mul_2(word[15:8])^word[23:16]^word[31:24];  // multiplying and adding with [01 01 02 03] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column3(input [31:0] word);	// 4th matrix's column 
    begin
      mix_column3 = mul_2(word[7:0])^word[15:8]^word[23:16]^mul_3(word[31:24]); // multiplying and adding with [03 01 01 02] over GF(2^8)
   end
  endfunction

  function [31:0] mix_column(input [31:0] word);	// output matrix 
    begin
      mix_column = {mix_column0(word),mix_column1(word),mix_column2(word),mix_column3(word)};
    end
  endfunction
  always @*
	  begin
 out = {mix_column(in[127:96]), mix_column(in[95:64]), mix_column(in[63:32]), mix_column(in[31:0])};
		   end
endmodule 

/*....................................MIX COLOMN.................................*/


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
  add_round_keys adk(round_num==10? sr_out : mc_out, kout, oout);  
	
	always@*
		begin
			keyout=kout;
			out =oout;
			
		end
	
	
	
endmodule
/*.........................................ROUND...................................*/
module sbox(
	input[7:0]in,
	output reg [7:0]out
	);


always @(in)
    case (in)
        8'h00: out=8'h63;
	    8'h01: out=8'h7c;
	    8'h02: out=8'h77;
	    8'h03: out=8'h7b;
	    8'h04: out=8'hf2;
	    8'h05: out=8'h6b;
	    8'h06: out=8'h6f;
	    8'h07: out=8'hc5;
	    8'h08: out=8'h30;
	    8'h09: out=8'h01;
	    8'h0a: out=8'h67;
	    8'h0b: out=8'h2b;
	    8'h0c: out=8'hfe;
	    8'h0d: out=8'hd7;
	    8'h0e: out=8'hab;
	    8'h0f: out=8'h76;
	    8'h10: out=8'hca;
	    8'h11: out=8'h82;
	    8'h12: out=8'hc9;
	    8'h13: out=8'h7d;
	    8'h14: out=8'hfa;
	    8'h15: out=8'h59;
	    8'h16: out=8'h47;
	    8'h17: out=8'hf0;
	    8'h18: out=8'had;
	    8'h19: out=8'hd4;
	    8'h1a: out=8'ha2;
	    8'h1b: out=8'haf;
	    8'h1c: out=8'h9c;
	    8'h1d: out=8'ha4;
	    8'h1e: out=8'h72;
	    8'h1f: out=8'hc0;
	    8'h20: out=8'hb7;
	    8'h21: out=8'hfd;
	    8'h22: out=8'h93;
	    8'h23: out=8'h26;
	    8'h24: out=8'h36;
	    8'h25: out=8'h3f;
	    8'h26: out=8'hf7;
	    8'h27: out=8'hcc;
	    8'h28: out=8'h34;
	    8'h29: out=8'ha5;
	    8'h2a: out=8'he5;
	    8'h2b: out=8'hf1;
	    8'h2c: out=8'h71;
	    8'h2d: out=8'hd8;
	    8'h2e: out=8'h31;
	    8'h2f: out=8'h15;
	    8'h30: out=8'h04;
	    8'h31: out=8'hc7;
	    8'h32: out=8'h23;
	    8'h33: out=8'hc3;
	    8'h34: out=8'h18;
	    8'h35: out=8'h96;
	    8'h36: out=8'h05;
	    8'h37: out=8'h9a;
	    8'h38: out=8'h07;
	    8'h39: out=8'h12;
	    8'h3a: out=8'h80;
	    8'h3b: out=8'he2;
	    8'h3c: out=8'heb;
	    8'h3d: out=8'h27;
	    8'h3e: out=8'hb2;
	    8'h3f: out=8'h75;
	    8'h40: out=8'h09;
	    8'h41: out=8'h83;
	    8'h42: out=8'h2c;
	    8'h43: out=8'h1a;
	    8'h44: out=8'h1b;
	    8'h45: out=8'h6e;
	    8'h46: out=8'h5a;
	    8'h47: out=8'ha0;
	    8'h48: out=8'h52;
	    8'h49: out=8'h3b;
	    8'h4a: out=8'hd6;
	    8'h4b: out=8'hb3;
	    8'h4c: out=8'h29;
	    8'h4d: out=8'he3;
	    8'h4e: out=8'h2f;
	    8'h4f: out=8'h84;
	    8'h50: out=8'h53;
	    8'h51: out=8'hd1;
	    8'h52: out=8'h00;
	    8'h53: out=8'hed;
	    8'h54: out=8'h20;
	    8'h55: out=8'hfc;
	    8'h56: out=8'hb1;
	    8'h57: out=8'h5b;
	    8'h58: out=8'h6a;
	    8'h59: out=8'hcb;
	    8'h5a: out=8'hbe;
	    8'h5b: out=8'h39;
	    8'h5c: out=8'h4a;
	    8'h5d: out=8'h4c;
	    8'h5e: out=8'h58;
	    8'h5f: out=8'hcf;
	    8'h60: out=8'hd0;
	    8'h61: out=8'hef;
	    8'h62: out=8'haa;
	    8'h63: out=8'hfb;
	    8'h64: out=8'h43;
	    8'h65: out=8'h4d;
	    8'h66: out=8'h33;
	    8'h67: out=8'h85;
	    8'h68: out=8'h45;
	    8'h69: out=8'hf9;
	    8'h6a: out=8'h02;
	    8'h6b: out=8'h7f;
	    8'h6c: out=8'h50;
	    8'h6d: out=8'h3c;
	    8'h6e: out=8'h9f;
	    8'h6f: out=8'ha8;
	    8'h70: out=8'h51;
	    8'h71: out=8'ha3;
	    8'h72: out=8'h40;
	    8'h73: out=8'h8f;
	    8'h74: out=8'h92;
	    8'h75: out=8'h9d;
	    8'h76: out=8'h38;
	    8'h77: out=8'hf5;
	    8'h78: out=8'hbc;
	    8'h79: out=8'hb6;
	    8'h7a: out=8'hda;
	    8'h7b: out=8'h21;
	    8'h7c: out=8'h10;
	    8'h7d: out=8'hff;
	    8'h7e: out=8'hf3;
	    8'h7f: out=8'hd2;
	    8'h80: out=8'hcd;
	    8'h81: out=8'h0c;
	    8'h82: out=8'h13;
	    8'h83: out=8'hec;
	    8'h84: out=8'h5f;
	    8'h85: out=8'h97;
	    8'h86: out=8'h44;
	    8'h87: out=8'h17;
	    8'h88: out=8'hc4;
	    8'h89: out=8'ha7;
	    8'h8a: out=8'h7e;
	    8'h8b: out=8'h3d;
	    8'h8c: out=8'h64;
	    8'h8d: out=8'h5d;
	    8'h8e: out=8'h19;
	    8'h8f: out=8'h73;
	    8'h90: out=8'h60;
	    8'h91: out=8'h81;
	    8'h92: out=8'h4f;
	    8'h93: out=8'hdc;
	    8'h94: out=8'h22;
	    8'h95: out=8'h2a;
	    8'h96: out=8'h90;
	    8'h97: out=8'h88;
	    8'h98: out=8'h46;
	    8'h99: out=8'hee;
	    8'h9a: out=8'hb8;
	    8'h9b: out=8'h14;
	    8'h9c: out=8'hde;
	    8'h9d: out=8'h5e;
	    8'h9e: out=8'h0b;
	    8'h9f: out=8'hdb;
	    8'ha0: out=8'he0;
	    8'ha1: out=8'h32;
	    8'ha2: out=8'h3a;
	    8'ha3: out=8'h0a;
	    8'ha4: out=8'h49;
	    8'ha5: out=8'h06;
	    8'ha6: out=8'h24;
	    8'ha7: out=8'h5c;
	    8'ha8: out=8'hc2;
	    8'ha9: out=8'hd3;
	    8'haa: out=8'hac;
	    8'hab: out=8'h62;
	    8'hac: out=8'h91;
	    8'had: out=8'h95;
	    8'hae: out=8'he4;
	    8'haf: out=8'h79;
	    8'hb0: out=8'he7;
	    8'hb1: out=8'hc8;
	    8'hb2: out=8'h37;
	    8'hb3: out=8'h6d;
	    8'hb4: out=8'h8d;
	    8'hb5: out=8'hd5;
	    8'hb6: out=8'h4e;
	    8'hb7: out=8'ha9;
	    8'hb8: out=8'h6c;
	    8'hb9: out=8'h56;
	    8'hba: out=8'hf4;
	    8'hbb: out=8'hea;
	    8'hbc: out=8'h65;
	    8'hbd: out=8'h7a;
	    8'hbe: out=8'hae;
	    8'hbf: out=8'h08;
	    8'hc0: out=8'hba;
	    8'hc1: out=8'h78;
	    8'hc2: out=8'h25;
	    8'hc3: out=8'h2e;
	    8'hc4: out=8'h1c;
	    8'hc5: out=8'ha6;
	    8'hc6: out=8'hb4;
	    8'hc7: out=8'hc6;
	    8'hc8: out=8'he8;
	    8'hc9: out=8'hdd;
	    8'hca: out=8'h74;
	    8'hcb: out=8'h1f;
	    8'hcc: out=8'h4b;
	    8'hcd: out=8'hbd;
	    8'hce: out=8'h8b;
	    8'hcf: out=8'h8a;
	    8'hd0: out=8'h70;
	    8'hd1: out=8'h3e;
	    8'hd2: out=8'hb5;
	    8'hd3: out=8'h66;
	    8'hd4: out=8'h48;
	    8'hd5: out=8'h03;
	    8'hd6: out=8'hf6;
	    8'hd7: out=8'h0e;
	    8'hd8: out=8'h61;
	    8'hd9: out=8'h35;
	    8'hda: out=8'h57;
	    8'hdb: out=8'hb9;
	    8'hdc: out=8'h86;
	    8'hdd: out=8'hc1;
	    8'hde: out=8'h1d;
	    8'hdf: out=8'h9e;
	    8'he0: out=8'he1;
	    8'he1: out=8'hf8;
	    8'he2: out=8'h98;
	    8'he3: out=8'h11;
	    8'he4: out=8'h69;
	    8'he5: out=8'hd9;
	    8'he6: out=8'h8e;
	    8'he7: out=8'h94;
	    8'he8: out=8'h9b;
	    8'he9: out=8'h1e;
	    8'hea: out=8'h87;
	    8'heb: out=8'he9;
	    8'hec: out=8'hce;
	    8'hed: out=8'h55;
	    8'hee: out=8'h28;
	    8'hef: out=8'hdf;
	    8'hf0: out=8'h8c;
	    8'hf1: out=8'ha1;
	    8'hf2: out=8'h89;
	    8'hf3: out=8'h0d;
	    8'hf4: out=8'hbf;
	    8'hf5: out=8'he6;
	    8'hf6: out=8'h42;
	    8'hf7: out=8'h68;
	    8'hf8: out=8'h41;
	    8'hf9: out=8'h99;
	    8'hfa: out=8'h2d;
	    8'hfb: out=8'h0f;
	    8'hfc: out=8'hb0;
	    8'hfd: out=8'h54;
	    8'hfe: out=8'hbb;
	    8'hff: out=8'h16;
	endcase

endmodule
/*.....................................SBOX.............................................*/

module shift_rows(
	input wire[127 : 0] in,
	output reg[127 : 0] out
	);
	
	//assume input is in the right order (consecutive 16 bytes -> 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
	// 4 by 4 matrix is as follows:
	/*
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
	always @*
		begin
			out = {in[127:120], in[87:80], in[47:40], in[7:0], in[95:88], in[55:48], in[15:8], in[103:96], in[63:56], in[23:16], in[111:104], in[71:64], in[31:24], in[119:112], in[79:72], in[39:32]};
			
		end
	/*
	// from bit 127 -> 96 (bits 15 -> 12) bit 15 is unchaged, bit 14 -> 10, bit 13 -> 5, bit 12 -> 0
	assign         out[127:120] = in[127:120];  
	assign         out[119:112] = in[87:80];
	assign         out[111:104] = in[47:40];
	assign         out[103:96] = in[7:0];
	
	// from bit 95 -> 64 (bits 11 -> 8) bit 11 is unchaged, bit 10 -> 6, bit 9 -> 1, bit 8 -> 12
	assign          out[95:88] = in[95:88];
	assign          out[87:80] = in[55:48];
	assign          out[79:72] = in[15:8];
	assign          out[71:64] = in[103:96];
	
	// from bit 56 -> 32 (bits 7 -> 4) bit 7 is unchaged, bit 6 -> 2, bit 5 -> 13, bit 4 -> 8
	assign          out[63:56] = in[63:56];
	assign          out[55:48] = in[23:16];
	assign          out[47:40] = in[111:104];
	assign          out[39:32] = in[71:64];
	
	// from bit 31 -> 0 (bits 3 -> 0) bit 3 is unchaged, bit 2 -> 14, bit 1 -> 9, bit 0 -> 4
	assign          out[31:24] = in[31:24];
	assign          out[23:16] = in[119:112];
	assign          out[15:8] = in[79:72];
	assign          out[7:0] = in[39:32]; 
	
	*/
endmodule
/*........................................SHIFT ROWS..................................*/


module subbytes(
	input wire[127 : 0] in,
	output reg [127 : 0] out
	);
	
	//we want to subsitute 16 bytes with another 16 bytes, so we will call sbox module 16 times
	
	wire [7:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16;
	
	sbox sb1(in[127:120], out1);
	sbox sb2(in[119:112], out2);
	sbox sb3(in[111:104], out3);
	sbox sb4(in[103:96], out4);
	sbox sb5(in[95:88], out5);
	sbox sb6(in[87:80], out6);
	sbox sb7(in[79:72], out7);
	sbox sb8(in[71:64], out8);
	sbox sb9(in[63:56], out9);
	sbox sb10(in[55:48], out10);
	sbox sb11(in[47:40], out11);
	sbox sb12(in[39:32], out12);
	sbox sb13(in[31:24], out13);
	sbox sb14(in[23:16], out14);
	sbox sb15(in[15:8], out15);
	sbox sb16(in[7:0], out16);
	always @*
		begin
			 out = {out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16};
		end
	
endmodule
/*................................SUB BYTES.......................................*/


