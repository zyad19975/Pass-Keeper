`timescale 1ns / 1ps

/*
erase ram block used to check the last data saved in the write addr to erase it
*/

module erase_ram #
(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 2        
)
(
    input    wire                    clk,
    input    wire                    rst,
    input    wire                    write,
    output   wire                    erase,

    input    wire [ADDR_WIDTH-1:0]    addr,
    output   wire [DATA_WIDTH-1:0]    Data_out,
    input    wire [DATA_WIDTH-1:0]    Data_in
);

reg [(DATA_WIDTH-1):0]  mem [(ADDR_WIDTH)-1:0];
reg [DATA_WIDTH-1:0] Data_out_reg;
reg erase_reg;

//reseting the memory
integer i;
always@(rst) begin

for (i = 0 ;i < (ADDR_WIDTH) ; i = i+1 ) begin
    mem[i] = 0; 
end
end

always@(posedge clk)begin
    
    if (write) begin 
        Data_out_reg <= mem[addr];
        mem[addr] <= Data_in; 
        erase_reg <= 1'b1;
    end else begin
        erase_reg <= 1'b0;
    end

end

assign erase = erase_reg;
assign Data_out = Data_out_reg;

endmodule