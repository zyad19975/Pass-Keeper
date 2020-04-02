
module reg_D(input clk,
             input rst, 
             input enable, 
             input [127:0] in,
             output reg [127:0] out );


     always @(posedge clk )
     begin
        if(rst)
          out<=0;
        else if(enable)
          out <= in;
     end         
endmodule 