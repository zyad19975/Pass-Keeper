
`timescale 1ns / 1ps

/*
 * Generic dual-port RAM
 */
module ram_dp #
(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4       
)
(
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    write,


    // port A
    input  wire [ADDR_WIDTH-1:0]   a_addr,
    input  wire [DATA_WIDTH-1:0]   a_din,


    // port B
    input  wire [DATA_WIDTH-1:0]        b_din,
    output reg [(2**ADDR_WIDTH)-1:0]   b_dout
);

//main BRAM memory
reg [(2**ADDR_WIDTH)-1:0] mem [(2**DATA_WIDTH-1):0];


// Port B
reg [(2**ADDR_WIDTH)-1:0]   b_dout_reg;



integer i;

always@(negedge clk) begin
    if (rst)begin
        for (i = 0 ;i < (2**DATA_WIDTH) ; i = i+1 ) begin
            mem[i] = 0;     
        end
    end
    else if (write) begin
            mem[a_din][a_addr] <= 1'b1;
    end 
    b_dout <= mem[b_din];

end

endmodule