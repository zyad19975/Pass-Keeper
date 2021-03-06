`timescale 1ns / 1ps
`include "inter.sv"

`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\Cam_Top_level.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\erase_ram.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\Ram_block.v"
`include "C:\Users\Emad\Documents\GitHub\GraduationProject_2019_2020\CAM\encoder.v"


parameter DATA_WIDTH =4;
parameter ADDR_WIDTH = 2;


module Test(CAM_interface.TEST ta );
 bit [DATA_WIDTH:0] random_value;
initial 
begin
        #10
         ta.finish <=0;
        ta.Rest <= 1;
        #10
        ta.Rest <= 0;
        #10
        for (int a=0;a<2**ADDR_WIDTH;a++)// write into Cam
        begin
                #10
                 ta.Writ_Enable <= 1;
                 random_value=$urandom_range(0,2**DATA_WIDTH-1);
                 ta.Data_IN <= random_value;
                 ta.WR_Addr <= a;
                 ta.mem[a] = random_value;
                  #10
                 ta.Writ_Enable <= 0;     
       end 
       
        // read from cam
    #10
       ta.Data_IN <=15;
       #10
       ta.Data_IN <=4;
       #10
       ta.Data_IN <=13;
        #10
      ta.Data_IN <=0;
       #10
       ta.Data_IN <=6;
       #10
      
       
       /////////////////read and write
        #10;
        ta.Writ_Enable <= 1;
        ta.Data_IN <= 9;
        ta.WR_Addr <= 2;
        ta.mem[2] = 9;
        
        ta.CMP_Din <=15;
        #10
        ta.CMP_Din <=7;
        #10
       ta.CMP_Din <=4;
        #20
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
    Busy <=CA.Busy;
    end
    CAM_interface #(.DATA_WIDTHa(DATA_WIDTH),.ADDR_WIDTHa(ADDR_WIDTH)) CA(clk);
    Test ta(CA);
    monitor M(CA);
   cam #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))
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
      
    always @(posedge KO.Writ_Enable) // write 
        begin
           if(a<=2**ADDR_WIDTH-1)
                 begin
                         $fdisplay (fd, "%0d       |     %0d",a,KO.mem[a]);
                       a++;  
                 end
            else 
             updata();
              
        end
        
        
      always  @(negedge KO.Clk)
      begin
      if(2**ADDR_WIDTH <=a)
        if (KO.Match)
           if( KO.Writ_Enable  ) // read with write 
               $fdisplay (fd, "CMP_Din=%0d    Addr= %0d  Writ_Enable=1  ",KO.CMP_Din, KO.Match_Addr);
            // read  only 
            else 
              $fdisplay (fd, "Data_IN=%0d    Addr= %0d  Writ_Enable=0 ",KO.Data_IN, KO.Match_Addr);      
        
         else if(!KO.Match)
            if( KO.Writ_Enable  ) // read with write 
                        $fdisplay (fd, "CMP_Din=%0d    NOt Found ",KO.CMP_Din);
                     // read  only 
                     else 
                       $fdisplay (fd, "Data_IN=%0d   NOt Found  ",KO.Data_IN); 
             
        end
        
        
        always @(posedge KO.finish)
        $fclose(fd);
        
        task updata;
          $fdisplay (fd, "  Updata & New Memory     ");
        for(int i=0;i<2**ADDR_WIDTH;i++)
          begin 
             $fdisplay (fd, "%0d       |     %0d ",i,KO.mem[i]);
          end
        endtask
     endmodule