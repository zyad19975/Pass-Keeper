`timescale 1ns / 1ps
module CAM_tp ;


    reg           clk;
    reg           rst;
    reg           start;
    //Write bit to enable writing operation
    reg           write_enable;
    //Input data to be look up to
    reg [127 : 0]   din;
    //write addres at writing operation
    reg [5 : 0]   write_addr;
    //A matching address is found
    wire          match;
    //the matched address
    wire [5:0]    match_addr;


    cam #(
    // search data bus width
    .DATA_WIDTH(128),
    // memory size in log2(words)
    .ADDR_WIDTH(6),
    //slice width
    .SLICE_WIDTH(4)
    )
    cam_inst(
    .clk(clk),
    .rst(rst),
    .start(start),
    .write_enable(write_enable),
    .din(din),
    .write_addr(write_addr),
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
        start = 0;
        #100
        rst = 0;
        #50
        din = 128'h00000000000000000000000000000000;
        write_addr = 6'b000000;
        write_enable = 1;
        #100
        write_enable = 0;
        #100
        write_enable = 1;
        din = 128'h00000000000000000000000000000000;
        write_addr = 6'b000001;
        #100
        write_enable = 0;
        #100
        start = 1;
        din = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        #100
        din = 128'h0000_0000_0000_0000_0000_0000_0000_1111;
        #100
        start = 0;
        din = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        
        

    end


   

endmodule