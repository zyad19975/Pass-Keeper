
`timescale 1ns / 1ps

`include "erase_ram.v"
`include "Ram_block.v"
`include "encoder.v"

/*
 * Content Addressable Memory
 */
module cam #(
    // search data bus width
    parameter DATA_WIDTH = 4,

    // memory size in log2(words)
    parameter ADDR_WIDTH = 2
    

)
(
    input  wire                     clk,
    input  wire                     rst,
    
    //Write bit to enable writing operation
    input  wire                     write_enable,

    //Input data to be look up to
    input wire [DATA_WIDTH-1 : 0]   din,

    //used as input data in case of write operation
    input wire [DATA_WIDTH-1 : 0]   cmp_din,

    //write addres at writing operation
    input wire [ADDR_WIDTH-1 : 0]   write_addr,

    // This signal Indicates that a write operation is currently being executed. 
    output wire                     busy,

    //A matching address is found
    output wire                     match,

    //the matched address
    output wire [ADDR_WIDTH-1:0]    match_addr
    );


wire busy_signal;
assign busy = busy_signal;

wire [DATA_WIDTH-1 : 0] Data_select;
assign Data_select = (write_enable)? cmp_din : din;


wire [DATA_WIDTH-1 : 0] Data_Write_select;
wire [DATA_WIDTH-1 : 0] Data_Write_erase;
assign Data_Write_select = (write_enable)? Data_Write_erase : din;

wire [(2**ADDR_WIDTH)-1:0] match_addr_unencoded;

erase_ram #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)        
)
erase_ram_inst(
    .clk(clk),
    .rst(rst),
    .write(write_enable),
    .erase(busy_signal),

    .addr(write_addr),
    .Data_out(Data_Write_erase),
    .Data_in(din)
);


ram_dp #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)       
)
ram_dp_inst(
    .clk(clk),
    .rst(rst),
    .write(write_enable),
    .erase(busy_signal),

    // port A
    .a_addr(write_addr),
    .a_din(Data_Write_select),


    // port B
    .b_din(Data_select),
    .b_dout(match_addr_unencoded)
);

encoder #(
            .WIDTH(2**ADDR_WIDTH),
            .LSB_PRIORITY("HIGH")
        )
        encoder_inst1 (
            .input_unencoded(match_addr_unencoded),
            .output_valid(match),
            .output_encoded(match_addr)
        );

endmodule