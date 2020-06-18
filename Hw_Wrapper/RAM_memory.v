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


module RAM_memory(
	input [255:0] data,
	input [3:0] addr,
	input we, clk,
	input rst,
	output  [255:0] q
);

	// Declare the RAM variable
	reg [255:0] ram[15:0];
	
	// Variable to hold the registered read address
	//reg [3:0] addr_reg;
	integer i;
	always @ (posedge clk)
	begin
	// Write
	   if (rst) begin 
	   for (i = 0 ;i < (16) ; i = i+1 ) begin
           ram[i] <= 0;     
           end
	   end
		if (we)
			ram[addr] <= data;
		
		//addr_reg <= addr;
		
	end
		
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr];
	
endmodule

