

module Get_key( input clk,
            input rest,
            input  [127:0] local_key
            ,input [3:0] rount_no
            ,output  reg [127:0] key_round 
            , output reg done

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
        R_11 = 11;  
   ////////////////// ???? 
    reg[3:0] round_number  ;
    wire [127:0] keyout;
   
    reg [127:0] prev_key;
   keygen key(round_number,prev_key,keyout);
   /////////////////  ????? ????     

reg [3:0] state; 
//reg[3:0] round_number  ;
reg [127:0]keys[0:10];



always @(posedge clk, posedge rest)
begin
    if(rest) // go to state zero if rese
        begin
        done<=0;
        state<= 0;
        end
    else // otherwise update the states
        begin
        
                case (state) 
            R_0 : begin
                     keys[0]<=local_key;
                     state <= R_1; 
                    
                    end
                    
            R_1 : begin
                    prev_key =local_key;
                    round_number =1;
                  
                     state <= R_2;
                    end 
             R_2 : begin
                            keys[1] <= keyout;
                            prev_key <= keyout;
                            round_number<=2;
                            
                             state <= R_3;
                            end   
            R_3 : begin
                                  keys[2] =keyout;
                                    round_number<=3;
                                     prev_key =keyout;
                                     state = R_4;
                             end 
              R_4 : begin     
                              round_number<=4;                    
                              prev_key <=keyout;
                              keys[3] <=keyout;
                              state <= R_5;
                      end 
              R_5 : begin
                       round_number<=5;
                        prev_key <=keyout;
                        keys[4] <=keyout;
                        state <= R_6;
                end
                R_6 : begin
                       round_number<=6;
                        prev_key <=keyout;
                        keys[5] <=keyout;
                        state <= R_7;
                end
                   R_7 : begin
                       round_number<=7;
                        prev_key <=keyout;
                        keys[6] <=keyout;
                        state <= R_8;
                end              
                   R_8 : begin
                        round_number<=8;
                         prev_key <=keyout;
                         keys[7] <=keyout;
                         state <= R_9;
                 end                                         
                   R_9 : begin
                         round_number<=9;
                          prev_key <=keyout;
                          keys[8] <=keyout;
                          state <= R_10;
                  end  
                   R_10 : begin
                          round_number<=10;
                           prev_key <=keyout;
                           keys[9] <=keyout;
                           state <= R_11;
                           
                   end  
                    R_11 : begin
                            state <= R_11;
                            keys[10]  <= keyout;
                            key_round <= keys[rount_no];
                                   done<=1;                        
                                  end                                                                                       
            endcase
    end
end


endmodule