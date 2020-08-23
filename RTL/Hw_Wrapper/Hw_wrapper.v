`timescale 1ns / 1ps
module Hw_wrapper(

    input clk,
    input go,
    input rst,
    input [127:0] master_key,
    input [127:0] account,
    input [127:0] password,
    input [3:0]   max_address,
    output done,
    output[127:0] password_enc,
    output boot_done_signal
);
    
    wire [255:0] data_flash;
    wire [255:0] write_data_flash;
    wire [3:0] add_flash;
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
        .flash_write(flash_write),
        .boot_done_signal(boot_done_signal)
        );     
endmodule