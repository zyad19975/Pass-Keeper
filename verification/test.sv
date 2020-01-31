`timescale 1ns / 1ps
`include "interface.sv"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\Cam_Top_level.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\erase_ram.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\Ram_block.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\encoder.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2020 07:29:52 PM
// Design Name: 
// Module Name: test
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
module Test(CAM_interface.TEST ta );
 bit [DATA_WIDTH-1:0] aa;
initial 
begin
        
         ta.finish <=0;
        ta.Rest <= 1;
        #10
        ta.Rest <= 0;
        for (int a=0;a<2**ADDR_WIDTH;a++)
        begin
                 ta.Writ_Enable <= 1;
                 aa=$urandom_range(0,2**DATA_WIDTH-1);
                 ta.Data_IN <= aa;
                 ta.WR_Addr <= a;
                 ta.mem[a] = aa;
                  #10
                 ta.Writ_Enable <= 0;
       end
       #15;
       ta.CMP_Din <=6;
       #20;
       ta.CMP_Din <=15;
       #15;
       ta.CMP_Din <=4;
        #20;
        ta.CMP_Din <=6;
        ta.finish <=1;
        
    end 
endmodule

module top();
    
    bit clk;
     logic Rest,Writ_Enable,Match,Busy;
            logic [DATA_WIDTH-1:0] Data_IN;
            logic [DATA_WIDTH-1:0] CMP_Din;
            logic [ADDR_WIDTH-1:0] WR_Addr;
            logic [ADDR_WIDTH-1:0] Match_Addr;
            bit [DATA_WIDTH-1:0] mem [0:2**ADDR_WIDTH-1];
    always
    begin 
    #5 clk=~clk;
    Rest <=CA.finish;
    Match_Addr <=CA.Match_Addr;
    Writ_Enable <=CA.Writ_Enable;
    Data_IN <=CA.Data_IN;
    WR_Addr <=CA.WR_Addr;
    Match <=CA.Match;
    CMP_Din <=CA.CMP_Din;
    mem <=CA.mem;
    end
    CAM_interface CA(clk);
    Test ta(CA);
    monitor M(CA);
   cam #(.DATA_WIDTH(4),.ADDR_WIDTH(2))
   cc(.clk(CA.Clk),
      .rst(CA.Rest),
      .write_enable(CA.Writ_Enable),
      .din(CA.Data_IN),
      .cmp_din(CA.CMP_Din),
      .write_addr(CA.WR_Addr),
      .busy(CA.Busy),
      .match(CA.Match),
      .match_addr(CA.Match_Addr)
      ); 
   
   
endmodule



module monitor (CAM_interface.MONITOR KO);
  
    //bit [DATA_WIDTH-1:0] mam [0:2**ADDR_WIDTH-1];
   
    int fd,a;
    initial 
    begin
    fd=$fopen("output10.txt","w");
    $fdisplay (fd, "ADDRESS     DATA");
    a=0;
    end
    always @(KO.Data_IN)
    begin
      
      
        $fdisplay (fd, "%0d     %0d",a,KO.mem[a]);
        a++;
        end  
        
        always @(KO.CMP_Din)
        begin
        if(KO.Match)
           $fdisplay (fd, "CMP=%0d    Addr= %0d",KO.CMP_Din, KO.Match_Addr);
          else 
           $fdisplay (fd, "CMP=%0d    Addr= NOT Found",KO.CMP_Din,);
        
        end
        always @(posedge KO.finish)
        $fclose(fd);
        
     endmodule
