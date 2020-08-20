
module Hw_wrapper ( clk, go, rst, master_key, account, password, max_address, 
        done, password_enc, boot_done_signal );
  input [127:0] master_key;
  input [127:0] account;
  input [127:0] password;
  input [3:0] max_address;
  output [127:0] password_enc;
  input clk, go, rst;
  output done, boot_done_signal;
  wire   flash_write;
  wire   [255:0] data_flash;
  wire   [255:0] write_data_flash;
  wire   [3:0] add_flash;
  tri   clk;
  tri   rst;

  RAM_memory R2 ( .data(write_data_flash), .addr(add_flash), .we(flash_write), 
        .clk(clk), .rst(rst), .q(data_flash) );
  Top_level R1 ( .clk(clk), .go(go), .rst(rst), .master_key(master_key), 
        .account(account), .password(password), .data_flash(data_flash), 
        .max_address(max_address), .password_enc(password_enc), 
        .write_data_flash(write_data_flash), .add_flash(add_flash), .done(done), .flash_write(flash_write), .boot_done_signal(boot_done_signal) );
endmodule

