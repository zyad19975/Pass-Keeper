`timescale 1ns / 1ps
module Hw_wrapper_tp();
    reg clk;
    reg go;
    reg rst;
    reg [127:0] master_key;
    reg [15:0] account;
    reg [15:0] password;
    reg [15:0]   max_address;
    
    wire [31:0] data_flash;
    wire[15:0] password_enc;
    wire [31:0] write_data_flash;
    wire [3:0] add_flash;
    wire done;
    wire flash_write;
    
    RAM_memory R2(
        .data(write_data_flash),
        .addr(add_flash),
        .we(flash_write),
        .clk(clk),
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
            max_address = 0;
            #100
            rst = 0;
            master_key = 128'hf256847daea39da5d870adf56971236;
            password   = 16'h1236;
            account    = 16'h0000;
            #500
            go = 1;
            #200
            go = 0;
            end
endmodule
