module keygen(round_num,key,keyout);
    
   input [3:0] round_num;
   input [127:0]key;
   output [127:0] keyout;
   
   wire [31:0] word0,word1,word2,word3,sb_out;
         
               
       assign word0 = key[127:96];
       assign word1 = key[95:64];
       assign word2 = key[63:32];
       assign word3 = key[31:0];
       
           
       sbox sb1(word3[23:16],sb_out[31:24]);
       sbox sb2(word3[15:8],sb_out[23:16]);
       sbox sb3(word3[7:0],sb_out[15:8]);
       sbox sb4(word3[31:24],sb_out[7:0]);

       assign keyout[127:96]= word0 ^ sb_out ^ rcon(round_num);
       assign keyout[95:64] = word0 ^ sb_out ^ rcon(round_num)^ word1;
       assign keyout[63:32] = word0 ^ sb_out ^ rcon(round_num)^ word1 ^ word2;
       assign keyout[31:0]  = word0 ^ sb_out ^ rcon(round_num)^ word1 ^ word2 ^ word3;
       
   
       
       
       
     function [31:0]	rcon;
      input	[3:0]	rc;
      case(rc)	
         4'h0: rcon=32'h01_00_00_00;
         4'h1: rcon=32'h02_00_00_00;
         4'h2: rcon=32'h04_00_00_00;
         4'h3: rcon=32'h08_00_00_00;
         4'h4: rcon=32'h10_00_00_00;
         4'h5: rcon=32'h20_00_00_00;
         4'h6: rcon=32'h40_00_00_00;
         4'h7: rcon=32'h80_00_00_00;
         4'h8: rcon=32'h1b_00_00_00;
         4'h9: rcon=32'h36_00_00_00;
         default: rcon=32'h00_00_00_00;
       endcase

     endfunction

endmodule
