`timescale 1ns / 1ps
module CAM_tp ;


    reg           clk;
    reg           rst;
    //Write bit to enable writing operation
    reg           write_enable;
    //Input data to be look up to
    reg [127 : 0]   din;
    //used as input data in case of write operation
    reg [127 : 0]   cmp_din;
    //write addres at writing operation
    reg [5 : 0]   write_addr;
    // This signal Indicates that a write operation is currently being executed. 
    wire          busy;
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
        din = 128'haaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa;
        write_addr = 6'b000000;
        write_enable = 1;
        #100
        write_enable = 0;
        #100
        write_enable = 1;
        din = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        write_addr = 6'b000001;
        #100
        write_enable = 0;
        #100
        din = 128'haaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa;
        #100
        din = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        #100
        din = 128'h0000_0000_0000_0000_0000_0000_0000_1111;
        
        

    end


   

endmodule