`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 08:45:05 PM
// Design Name: 
// Module Name: RAM_memory
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


module RAM_memory(out, addr, CS);
output[3:0] out;
input[3:0] addr;
input CS;
reg [3:0] out;
reg [3:0] ROM[3:0];
always @(posedge CS)
begin
ROM[0]=4'h5; ROM[1]=15;
ROM[2]=4'h1; ROM[3]=10;
ROM[4]=4'h1; ROM[5]=7;
ROM[6]=4'h1; ROM[7]=6;
ROM[8]=4'h1; ROM[9]=9;
ROM[10]=13; ROM[11]=8;
ROM[12]=10; ROM[13]=11;
ROM[14]=12; ROM[15]=11;
out=ROM[addr];
end

endmodule
