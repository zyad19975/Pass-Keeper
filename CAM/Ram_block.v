
`timescale 1ns / 1ps

/*
 * Generic dual-port RAM
 */
module ram_dp #
(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 5
)
(
    input  wire                    clk,
    input  wire                    write,
    input  wire                    erase,

    // port A
    input  wire [ADDR_WIDTH-1:0]   a_addr,
    input  wire [DATA_WIDTH-1:0]   a_din,


    // port B
    input  wire [ADDR_WIDTH-1:0]        b_addr,
    input  wire [DATA_WIDTH-1:0]        b_din,
    output wire [(2**ADDR_WIDTH)-1:0]   b_dout
);

//main BRAM memory
reg [(2**ADDR_WIDTH)-1:0] mem [(2**DATA_WIDTH-1):0];


// Port B
reg [(2**ADDR_WIDTH)-1:0]   b_dout_reg;
assign b_dout = b_dout_reg;

always@(posedge clk) begin
    
    b_dout_reg <= mem[b_din];

end


always@(posedge clk) begin

    if (write) begin
        if (erase) begin
            mem[b_din] <= {(2**ADDR_WIDTH){1'b0}};
        end else begin
            mem[a_din][a_addr] <= 1'b1;
        end
    end

end

endmodule