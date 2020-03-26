
`timescale 1ns / 1ps

/*
 * Content Addressable Memory
 */
module cam #(
    // search data bus width
    parameter DATA_WIDTH = 4,

    // memory size in log2(words)
    parameter ADDR_WIDTH = 2,

    parameter SLICE_WIDTH = 4
    

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

localparam SLICE_COUNT = (DATA_WIDTH + SLICE_WIDTH - 1) / SLICE_WIDTH;


wire busy_signal;
assign busy = busy_signal;

wire [DATA_WIDTH-1 : 0] Data_select;
assign Data_select = (write_enable)? cmp_din : din;


wire [DATA_WIDTH-1 : 0] Data_Write_select;
wire [DATA_WIDTH-1 : 0] Data_Write_erase;
assign Data_Write_select = (write_enable)? Data_Write_erase : din;

wire [(2**ADDR_WIDTH)-1:0] match_addr_unencoded;
wire [(2**ADDR_WIDTH)-1:0] match_addr_unencoded_raw [SLICE_COUNT : 0];

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

genvar slice_ind;
generate
for (slice_ind = 0; slice_ind < SLICE_COUNT; slice_ind = slice_ind + 1) begin : slice

localparam start = slice_ind*SLICE_WIDTH;
localparam W = slice_ind == SLICE_COUNT-1 ? DATA_WIDTH-SLICE_WIDTH*slice_ind : SLICE_WIDTH;

ram_dp #(
    .DATA_WIDTH (SLICE_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)       
)
ram_dp_inst(
    .clk(clk),
    .rst(rst),
    .write(write_enable),
    .erase(busy_signal),

    // port A
    .a_addr(write_addr),
    .a_din(Data_Write_select[start +: W]),


    // port B
    .b_din(Data_select[start +: W]),
    .b_dout(match_addr_unencoded_raw[slice_ind])
);
end
endgenerate
encoder #(
            .WIDTH(2**ADDR_WIDTH),
            .LSB_PRIORITY("HIGH")
        )
        encoder_inst1 (
            .input_unencoded(match_addr_unencoded),
            .output_valid(match),
            .output_encoded(match_addr)
        );
assign match_addr_unencoded = match_addr_unencoded_raw[0] & match_addr_unencoded_raw[1] & match_addr_unencoded_raw[2] & match_addr_unencoded_raw[3] & match_addr_unencoded_raw[4] & match_addr_unencoded_raw[5] & match_addr_unencoded_raw[6] & match_addr_unencoded_raw[7] & match_addr_unencoded_raw[8] & match_addr_unencoded_raw[9] & match_addr_unencoded_raw[10] & match_addr_unencoded_raw[11] & match_addr_unencoded_raw[12] & match_addr_unencoded_raw[13] & match_addr_unencoded_raw[14] & match_addr_unencoded_raw[15] & match_addr_unencoded_raw[16] & match_addr_unencoded_raw[17] & match_addr_unencoded_raw[18] & match_addr_unencoded_raw[19] & match_addr_unencoded_raw[20]& match_addr_unencoded_raw[21] & match_addr_unencoded_raw[22]& match_addr_unencoded_raw[23]& match_addr_unencoded_raw[24]& match_addr_unencoded_raw[25]& match_addr_unencoded_raw[26]& match_addr_unencoded_raw[27]& match_addr_unencoded_raw[28]& match_addr_unencoded_raw[29]& match_addr_unencoded_raw[30]& match_addr_unencoded_raw[31];
endmodule