`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 08:16:46 PM
// Design Name: 
// Module Name: HW_controller
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


module HW_controller(
    input clk,
    input boot,
    input busy,
    output  cam_write_en,
    output reg flash_to_cam,
    output  [3:0] address_out, //da el address ele mtwsl b flash w cam f nafs el wa2t
    output  cam_rest
    );
    integer count=0;
   
    assign cam_rest = (count >= 3) ? 0 : 1;
    
    reg cam_write;
    integer address = 0;
    always@(posedge clk)
    begin
    count = count+1;
        if (boot)
        begin
         if ( count == 4 )
           cam_write <= 1; 
          else if ( count == 5 )
           begin
            cam_write <= 0;
            count = 3;
            end
            /*if(cam_write)
            begin
            cam_write <=0;
            end
            else if(busy == 0)
            begin
                flash_to_cam <= 1;
                cam_write <= 1;
            end*/

        end
        else
        begin
            flash_to_cam <= 0;
        end
        
    end
    always@(negedge busy)
    begin
        address = address + 1;
    end
    
    assign cam_write_en = (count >= 2) ? cam_write : 0;
    assign address_out = address;
endmodule