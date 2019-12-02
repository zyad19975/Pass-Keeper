module Mix_Column();
  function [7:0] mul_2(input [7:0] byte);  // multiply by 2 "x" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_2 = byte<<1;
      else
        mul_2 = (byte<<1)^(8'h1b); // if MSB = 1, (SLL by 1) XOR 1B
    end
  endfunction

  function [7:0] mul_3(input [7:0] byte); // multiply by 3 "x + 1"
    begin
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1 XOR itself "byte"
        mul_3 = (byte<<1)^(byte);
      else
        mul_3 = (byte<<1)^(byte)^(8'h1b); // if MSB = 1, (SLL by 1) XOR 1B XOR itself "byte"
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

  function [0:31] mix_column(input [0:31] word);	// output matrix 
    begin
      mix_column = {mix_column0(word),mix_column1(word),mix_column2(word),mix_column3(word)};
    end
  endfunction

endmodule 
