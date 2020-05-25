`timescale 1ns / 1ps
module Hw_wrapper_tp();

    reg clk;
    reg go;
    reg rst;
    reg [127:0] master_key;
    reg [127:0] account;
    reg [127:0] password;
    reg [3:0]   max_address;
    wire[127:0] password_enc;
    wire done;
    

    Hw_wrapper hw(
    .clk(clk),
    .go(go),
    .rst(rst),
    .master_key(master_key),
    .account(account),
    .password(password),
    .max_address(max_address),
    .done(done),
    .password_enc(password_enc)
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
            master_key = 128'h5468617473206D79204B756E67204675;
            password   = 128'h54776F204F6E65204E696E652054776F;
            account    = 128'h00000000000000000000000000000000;
            #500
            go = 1;
            #100
            go = 0;
            #3000
            account    = 128'h00000000000000000000000000000000;
            go = 1;
            #100
            go = 0;
            /*#1500
            account    = 128'h00000000000000000000000000000000;
            go = 1;
            #100          
            go = 0;*/
                        
            end
endmodule
