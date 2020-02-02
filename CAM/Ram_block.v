
`timescale 1ns / 1ps

/*
 * Generic dual-port RAM
 */
module ram_dp #
(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 2        
)
(
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    write,
    input  wire                    erase,

    // port A
    input  wire [ADDR_WIDTH-1:0]   a_addr,
    input  wire [DATA_WIDTH-1:0]   a_din,


    // port B
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

integer i;
always@(posedge clk) begin

    if (rst)begin
    for (i = 0 ;i < (2**DATA_WIDTH) ; i = i+1 ) begin
    mem[i] = 0;     
    end
    end
end
always@(write or erase) begin
    if (write) begin
       
            mem[a_din][a_addr] <= 1'b0;
    end 
    else if (erase)  begin
            mem[a_din][a_addr] <= 1'b1;
    end
end

endmodule