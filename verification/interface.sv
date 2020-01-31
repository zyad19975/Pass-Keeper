`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2020 09:08:42 PM
// Design Name: 
// Module Name: interface
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


parameter  DATA_WIDTH =4 ;
parameter  ADDR_WIDTH = 2 ;


interface CAM_interface(input bit Clk);

	logic Rest,Writ_Enable,Match,Busy;
	logic [DATA_WIDTH-1:0] Data_IN;
	logic [DATA_WIDTH-1:0] CMP_Din;
        logic [ADDR_WIDTH-1:0] WR_Addr;
	logic [ADDR_WIDTH-1:0] Match_Addr;
	bit [DATA_WIDTH-1:0] mem [0:2**ADDR_WIDTH-1];
	logic finish;
	 
	/*clocking cd @(posedge Clk);
	  output Rest,
	        Writ_Enable,
	        Data_IN,
	        WR_Addr,
           CMP_Din,
             mem;
	  
	 
	 endclocking*/
	 modport TEST(output Rest,
                         Writ_Enable,
                         Data_IN,
                         WR_Addr,
                         CMP_Din,
                         mem,
                         finish,
	    input 
                    Match,
                     Busy,
                    Match_Addr );
         modport MONITOR ( 
                 input Clk,
                        Rest,
                        Writ_Enable,
                        Data_IN,
                        WR_Addr,
                        CMP_Din,
                        Match,
                        Busy,
                         Match_Addr,
                         mem,
                         finish);                                                
                   endinterface
						  
	 
	/* modport TEST ( output   Rest,
                             Writ_Enable,
                             Data_IN,
                             
           
                    input 
                               Clk,
                               Match,
                               Busy,
                               Match_Addr );*/
                               
    /* modport DUT (  input    Clk,
                              Rest,
                              Writ_Enable,
                              Data_IN,
                              CMP_Din,
                              WR_Addr,
     
     
     output 
                               Busy,                                          
                               Match,
                               Match_Addr 
     
     
     
                     ); */
                                
     
