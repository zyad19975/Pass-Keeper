`timescale 1ns / 1ps
module CAM_tp ;


    reg           clk;
    reg           rst;
    //Write bit to enable writing operation
    reg           write_enable;
    //Input data to be look up to
    reg [3 : 0]   din;
    //used as input data in case of write operation
    reg [3 : 0]   cmp_din;
    //write addres at writing operation
    reg [1 : 0]   write_addr;
    // This signal Indicates that a write operation is currently being executed. 
    wire          busy;
    //A matching address is found
    wire          match;
    //the matched address
    wire [1:0]    match_addr;


    cam #(
    // search data bus width
    .DATA_WIDTH(4),
    // memory size in log2(words)
    .ADDR_WIDTH(2)
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

     always 
        begin
        #50 
        clk = ~clk;
    end
    initial
		begin
        clk = 0;
        rst = 1;
        #100
        rst = 0;
        #50
        din = 4'b0011;
        write_addr = 2'b00;
        write_enable = 1;
        #100
        write_enable = 0;
        #100
        write_enable = 1;
        din = 4'b0101;
        write_addr = 2'b01;
         #100
        write_enable = 0;
        #100
        write_enable = 1;
        din = 4'b1011;
        write_addr = 2'b10;
         #100
        write_enable = 0;
        #100
        write_enable = 1;
        din = 4'b1111;
        write_addr = 2'b11;
        #100
        write_enable = 0;
        din = 4'b0011;
        #100
        din = 4'b1011;
        #100
        din = 4'b0101;
        #100
        din = 4'b0000;
        
        

    end


   

endmodule