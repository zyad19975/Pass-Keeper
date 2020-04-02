`timescale 1ns / 1ps
module Hw_wrapper_tp();
    reg clk;
    reg go;
    reg rst;
    reg [127:0] master_key;
    reg [127:0] account;
    reg [127:0] password;
    reg [3:0]   max_address;
    wire [255:0] data_flash;
    wire[127:0] password_enc;
    wire [255:0] write_data_flash;
    wire [3:0] add_flash;
    wire done;
    wire flash_write;
    
    RAM_memory R2(
        .data(write_data_flash),
        .addr(add_flash),
        .we(flash_write),
        .clk(clk),
        .rst(rst),
        .q(data_flash)
    );
    Top_level R1(
        .clk(clk),
        .go(go),
        .rst(rst),
        .master_key(master_key),
        .account(account),
        .password(password),
        .data_flash(data_flash),
        .max_address(max_address),
        .password_enc(password_enc),
        .write_data_flash(write_data_flash),
        .add_flash(add_flash),
        .done(done),
        .flash_write(flash_write)
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
            master_key = 128'h00000000000000000000000000000000;
            password   = 128'h00000000000000000000000000000000;
            account    = 128'h00000000000000000000000000000000;
            max_address = 0;
            go = 0;
            #100
            rst = 0;
            master_key = 128'hf256847daea39da5d870adf569712360;
            password   = 128'hf256847daaa39da5d870adf569712360;
            account    = 128'h00000000000000000000000000000000;
            #500
            go = 1;
            #100
            go = 0;
            #1500
            account    = 128'haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
            go = 1;
            #100
            go = 0;
            #1500
            account    = 128'h00000000000000000000000000000000;
            go = 1;
            #100          
            go = 0;
                        
            end
endmodule
