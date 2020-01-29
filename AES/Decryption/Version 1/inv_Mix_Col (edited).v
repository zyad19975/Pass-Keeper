module inv_Mix_Col(input[127:0]in, output[127:0]out);

  function [7:0] mul_2(input [7:0] byte);  // multiply by 2 "x" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_2 = byte<<1;
      else
        mul_2 = (byte<<1)^(8'h1b); // if MSB = 1, SLL by 1 XOR 1B
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

  
   function [7:0] mul_4(input [7:0] byte);  // multiply by 4 "x^2" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_4 = byte<<1;
      else
        mul_4 = (byte<<1)^(8'h1b)^mul_2(byte)^mul_2(byte); // if MSB = 1, SLL by 1 XOR 1B XOR x2
    end
  endfunction

function [7:0] mul_8(input [7:0] byte);  // multiply by 8 "x^3" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_8 = byte<<1;
      else
        mul_8 = (byte<<1)^(8'h1b)^mul_2(byte)^mul_2(byte)^mul_2(byte); // if MSB = 1, SLL by 1 XOR 1B XOR x3
    end
  endfunction
  
  function [7:0] mul_9(input [7:0] byte);  // multiply by 9 "x^3+1" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_9 = byte<<1;
      else
        mul_9 = (byte<<1)^(8'h1b)^mul_8(byte)^byte; // if MSB = 1, SLL by 1 XOR 1B XOR x3 XOR "byte"
    end
  endfunction
  
  function [7:0] mul_11(input [7:0] byte);  // multiply by 11 "x^3+x+1" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_11 = byte<<1;
      else
        mul_11 = (byte<<1)^(8'h1b)^mul_8(byte)^mul_2(byte)^byte; // if MSB = 1, SLL by 1 XOR 1B XOR x3 XOR x XOR "byte"
    end
  endfunction

  function [7:0] mul_13(input [7:0] byte);  // multiply by 13 "x^3+x^2+1" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_13 = byte<<1;
      else
        mul_13 = (byte<<1)^(8'h1b)^mul_8(byte)^mul_4(byte)^byte; // if MSB = 1, SLL by 1 XOR 1B XOR x3 XOR x2 XOR "byte"
    end
  endfunction
  
  function [7:0] mul_14(input [7:0] byte);  // multiply by 13 "x^3+x^2+x" 
    begin 
      if(byte[7]==1'b0)		// if MSB = 0, SLL by 1
        mul_14 = byte<<1;
      else
        mul_14 = (byte<<1)^(8'h1b)^mul_8(byte)^mul_4(byte)^mul_2(byte); // if MSB = 1, SLL by 1 XOR 1B XOR x3 XOR x2
    end
  endfunction


  function [7:0] mix_column0(input [31:0] word); 	// 1st matrix's column 
    begin
      mix_column0 = mul_14(word[7:0])^mul_11(word[15:8])^mul_13(word[23:16])^mul_9(word[31:24]); // multiplying and adding with [0E 0B 0D 09] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column1(input [31:0] word);	// 2nd matrix's column 
    begin
      mix_column1 = mul_9(word[7:0])^mul_14(word[15:8])^mul_11(word[23:16])^mul_13(word[31:24]); // multiplying and adding with [09 0E 0B 0D] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column2(input [31:0] word);	// 3rd matrix's column 
    begin
      mix_column2 = mul_13(word[7:0])^mul_9(word[15:8])^mul_14(word[23:16])^mul_11(word[31:24]);  // multiplying and adding with [0D 09 0E 0B] over GF(2^8)
    end
  endfunction

  function [7:0] mix_column3(input [31:0] word);	// 4th matrix's column 
    begin
      mix_column3 = mul_11(word[7:0])^mul_13(word[15:8])^mul_9(word[23:16])^mul_14(word[31:24]); // multiplying and adding with [0B 0D 09 0E] over GF(2^8)
   end
  endfunction

  function [0:31] mix_column(input [0:31] word);	// output matrix 
    begin
      mix_column = {mix_column0(word),mix_column1(word),mix_column2(word),mix_column3(word)};
    end
  endfunction

assign out = {mix_column(in[127:96]), mix_column(in[95:64]), mix_column(in[63:32]), mix_column(in[31:0])};
endmodule


