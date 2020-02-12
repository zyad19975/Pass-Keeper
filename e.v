`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2020 01:24:43 AM
// Design Name: 
// Module Name: e
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



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
