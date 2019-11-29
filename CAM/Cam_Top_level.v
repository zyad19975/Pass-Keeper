
`timescale 1ns / 1ps

/*
 * Content Addressable Memory
 */
module cam #(
    // search data bus width
    parameter DATA_WIDTH = 64,

    // memory size in log2(words)
    parameter ADDR_WIDTH = 5,
    
    // CAM style (SRL, BRAM)
    //parameter CAM_STYLE = "BRAM",
    

)
(
    input  wire                     clk,
    input  wire                     rst,
    
    //Write bit to enable writing operation
    input  wire                     write_enable,

    //Input data to be look up to
    input wire [ADDR_WIDTH-1 : 0]   din,

    //used as input data in case of write operation
    input wire [ADDR_WIDTH-1 : 0]   cmp_din,

    //write addres at writing operation
    input wire [ADDR_WIDTH-1 : 0]   write_addr,

    // This signal Indicates that a write operation is currently being executed. 
    output wire                     busy,

    //A matching address is found
    output wire                     match,

    //the matched address
    output wire [ADDR_WIDTH-1:0]    match_addr
    );