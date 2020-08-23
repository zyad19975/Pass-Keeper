module tb ();
     
     reg clk , rest;
     reg  [127:0] plaintext1,local_key;
     wire [127:0]cipher_text ; 
     reg s;
     wire d,a;
	 reg [0:3]round_num;
	 reg [0:127] keyin;
	 wire[0:127] keyout;
    
	 inv_aes AS ( clk , rest ,s, plaintext1,local_key,cipher_text ,d,a);
     
	// keygen h (clk , round_num, keyin , keyout);
	
     always      #5 clk = ~clk;
     
     initial
         begin
             
             clk  = 0;
             rest = 1;
             s = 0 ;
             #50
             
             rest = 0 ;
             s=1;
			// keyin = 128'h 2b7e151628aed2a6abf7158809cf4f3c ;
             plaintext1 = 128'h 3925841d02dc09fbdc118597196a0b32 ;
             local_key  = 128'h 2b7e151628aed2a6abf7158809cf4f3c ; 
			 wait(d == 1);
			 wait(d == 0);
			 s = 0;
			 $display("plaintext1 = %h",plaintext1); 
			 $display("cipher_text = %h",cipher_text);	 
			 
			 #50
			 s= 1 ;
			 plaintext1 = 128'h 29C3505F5714231A02D73A0F6402299B ;
             local_key  = 128'h 2b7e151628aed2a6abf7158809cf4f3c ; 
			 wait(d == 1);
			 wait(d == 0);
			 $display("plaintext1 = %h",plaintext1); 
			 $display("cipher_text = %h",cipher_text);
			 s=0;
			 
         end
 endmodule
 
