*module tb ();
     
     reg clk , rest;
     reg  [127:0] plaintext1,local_key;
     wire [127:0]cipher_text ; 
     reg s;
     wire d,a;
     inv_aes AS ( clk , rest ,s, plaintext1,local_key,cipher_text ,d,a);
     
     always      #5 clk = ~clk;
     
     initial
         begin
             
             clk  = 0;
             rest = 1;
             s=0;
             #5
             
             rest = 0 ;
             s=1;
             plaintext1 = 128'h 54776F204F6E65204E696E652054776F ;
             local_key  = 128'h 5468617473206D79204B756E67204675 ;
         end
 endmodule