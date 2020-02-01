
`timescale 1ns / 1ps


interface CAM_interface #(
 parameter DATA_WIDTHa =4 ,
 parameter ADDR_WIDTHa = 2 
    
)

(input bit Clk);
        
	logic Rest,Writ_Enable,Match,Busy;
	logic [DATA_WIDTHa-1:0] Data_IN;
	logic [DATA_WIDTHa-1:0] CMP_Din;
        logic [ADDR_WIDTHa-1:0] WR_Addr;
	logic [ADDR_WIDTHa-1:0] Match_Addr;
	bit [DATA_WIDTHa-1:0] mem [0:2**ADDR_WIDTHa-1];
	logic finish;
	
	 modport TEST 
                         (output Rest,
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
						  
 	               
     

