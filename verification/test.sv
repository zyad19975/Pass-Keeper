#include "Cam_Top_level.v"
parameter  CAM_Width 48 ;
parameter  CAM_Depth 48 ;

parameter width_j 2;


interface CAM_interface(input bit Clk)
	logic Rest,Writ_Enable,Match,Busy;
	logic [CAM_Width-1:0] Data_IN,CMP_Din;
	logic [width_j-1:0] Match_Add;
	logic [log(CAM_Depth)-1:0] WR_Addr;

 modport TEST ( output   Rest,
		         Writ_Enable,
			 Data_IN,
			 WR_Addr,
			 CMP_Din, 
		
		input 
			 Clk,
			 Match,
			 Busy,
			 Match_Addr);
  
modport DUT (   input    Rest,
		         Writ_Enable,
			 Data_IN,
			 WR_Addr,
			 CMP_Din,
			 Clk, 
		
		 output 
			
			 Match,
			 Busy,
			 Match_Addr);

modport MONITOR ( input  Rest,
		         Writ_Enable,
			 Data_IN,
			 WR_Addr,
			 CMP_Din,
			 Clk, 
                         Match,
			 Busy,
			 Match_Addr);

endinterface

module TEST (CAM_interface C1);
endmodule 

        