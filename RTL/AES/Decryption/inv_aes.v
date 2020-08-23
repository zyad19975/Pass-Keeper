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

`timescale 1ns / 1ps
 
 module inv_aes(
     input clk , rest ,
     input start,
     input wire[127:0]plaintext1,
     input wire[127:0]local_key,
     output reg[127:0]cipher_text,
     output reg done, 
     output reg busy
     //output reg[127:0] keyout 
 );
 localparam [3:0] // 3 states are required for Moore
         R_0 = 0,
         R_1 = 1, 
         R_2 = 2,   
         R_3 = 3,   
         R_4 = 4,   
         R_5 = 5,   
         R_6 = 6,   
         R_7 = 7,   
         R_8 = 8,   
         R_9 = 9,   
         R_10 = 10,   
         R_11 = 11,  
         R_12=12,
         R_idel=13,
         wait_key = 14;
 
 reg [3:0] state ;
 reg last;
 reg  [3:0] rount_no ;
 wire [127:0]plaintext;
 wire [127:0] key_round;
 reg  [127:0] keys1;
 reg [127:0] adk_out;
 reg [127:0] adk_out1;
 wire done_k;
        // inv_add_round_keys adk_0(plaintext, keys, adk_out0);
     
          wire [127:0] out1;
          inv_round r1 (adk_out,last  , keys1,out1);          
 assign plaintext = plaintext1;
 
 
 Get_key as1(clk , rest , local_key , rount_no , key_round , done_k ); 
 
 
 reg flag;
 
 always @(posedge clk or posedge rest)
     begin
       
       if (rest)
           begin
             rount_no <= 10;
             last <= 0 ;
            state <= R_idel;
            busy <=0;
            done <=0;
            flag <=0;
            cipher_text<=0;
           end
      else if (start && done_k&& !busy&&!done )
      begin
         state <=R_11;
         rount_no <= 10;
         flag <=1;
         busy <=1;
         done <=0;
         last <= 0 ;
         end  
       else if (start && !done_k&& !busy &&!done) begin
            rount_no <= 10;
            state <= wait_key;
            busy <=1;
            done <=0;
            flag <=1;
            last <= 0 ;                  
       end
      else if (flag ) begin
                   
                           case (state)
                             wait_key: begin
                                if(done_k)begin
                                   state <= R_11;
                                end

                                  end
                                   R_idel : 
                                    begin
                                        done <= 0;
										busy <= 0;
										//$display("ideal state");
                                    end
                                    
                                    R_11 : begin
                                            state <=R_12;
                                            rount_no <=9;
                                            
                                            end  
                                    R_12: begin 
                                             
                                            adk_out <= key_round ^ plaintext;
                                            state <=R_0;
                                            rount_no <=8;
                                          end 
                                   R_0: begin 
                                         
                                            rount_no <=7;
                                            keys1 <= key_round;
                                            //adk_out <= adk_out1;
                                            state <=R_1;
                                         end
                                   R_1: begin 
                                           rount_no <=6;
                                           keys1 <= key_round;
                                           adk_out <= out1;
                                           state <=R_2;
                                         end
                                    R_2: begin 
                                            rount_no <=5;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_3;
                                         end   
                                   R_3: begin 
                                            rount_no <=4;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_4;
                                        end                                                                                 
                                    R_4: begin 
                                            rount_no <=3;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_5;
                                        end     
                                   R_5: begin 
                                            rount_no <=2;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_6;
                                         end 
                                   R_6: begin 
                                            rount_no <=1;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_7;
                                        end    
                                   R_7: begin 
                                            rount_no <=0;
                                            keys1 <= key_round;
                                            adk_out <= out1;
                                            state <=R_8;
                                        end  
                                    R_8: begin 
                                                        
                                        keys1 <= key_round;
                                        adk_out <= out1;
                                        state <=R_9;
                                        end   
                                    R_9: begin 
                                                           
                                        keys1 <= key_round;
                                        adk_out <= out1;
                                        last <=1;
                                        state <=R_10;
                                        end   
                                    R_10: begin 
                                        cipher_text <= out1;
                                        done <= 1;
                                        busy <= 0;
                                        state <= R_idel;
                                     end                      
                                                                                                                                                                                                                                                                                                                                                    
                           endcase    
           end
             
     end
                                    
 endmodule
