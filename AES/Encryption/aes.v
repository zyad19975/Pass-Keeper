
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

  
 

endmodule

