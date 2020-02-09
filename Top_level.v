`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 08:37:47 PM
// Design Name: 
// Module Name: Top_level
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


module Top_level(
    input clk,
    input boot,
    input rst
    );
        //Write bit to enable writing operation
        wire           write_enable;
        //Input data to be look up to
        wire [3 : 0]   din;
        //used as input data in case of write operation
        wire [3 : 0]   cmp_din;
        //write addres at writing operation
        wire [3 : 0]   write_addr;
        // This signal Indicates that a write operation is currently being executed. 
        wire          busy;
        //A matching address is found
        wire          match;
        //the matched address
        wire [3 : 0]    match_addr;
    
    
        cam #(
        // search data bus width
        .DATA_WIDTH(4),
        // memory size in log2(words)
        .ADDR_WIDTH(4)
        )
        cam_inst(
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .din(din),
        .cmp_din(cmp_din),
        .write_addr(write_addr),
        .busy(busy),
        .match(match),
        .match_addr(match_addr)
        ); 
        
        
        wire FTC;
        HW_controller hw_inst(
            .clk(clk),
            .boot(boot),
            .busy(busy),
            .cam_write_en(write_enable),
            .flash_to_cam(FTC),
            .address_out(write_addr) //da el address ele mtwsl b flash w cam f nafs el wa2t
            );
         wire [3:0]flash_out;
        RAM_memory ram_inst(
        .out(flash_out),
        .addr(write_addr),
        .CS(clk));
    assign din = (FTC)? flash_out : 4'b0000;
endmodule
