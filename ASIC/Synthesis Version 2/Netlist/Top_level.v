
module Top_level ( clk, go, rst, master_key, account, password, data_flash, 
        max_address, password_enc, write_data_flash, add_flash, done, 
        flash_write, boot_done_signal );
  input [127:0] master_key;
  input [127:0] account;
  input [127:0] password;
  input [255:0] data_flash;
  input [3:0] max_address;
  output [127:0] password_enc;
  output [255:0] write_data_flash;
  output [3:0] add_flash;
  input clk, go, rst;
  output done, flash_write, boot_done_signal;
  wire   flash_pass_reg, flash_acc_reg, flash_or_acc_reg, flash_or_acc_sel,
         pass_enc_reg, new_old_pass_sel, plain_reg, local_master_reg,
         local_master_sel, out_reg, write_en, boot_lood, match,
         ready_encryption, start_dec, dec_done, start_enc, cam_start;
  wire   [3:0] write_add;

  cde L1 ( .clk(clk), .rst(rst), .cam_start(cam_start), .pass(password), 
        .start_dec(start_dec), .start_enc(start_enc), .master_key(master_key), 
        .account(account), .data_flash(data_flash), .flash_pass_reg(
        flash_pass_reg), .flash_acc_reg(flash_acc_reg), .flash_or_acc_reg(
        flash_or_acc_reg), .flash_or_acc_sel(flash_or_acc_sel), .pass_enc_reg(
        pass_enc_reg), .new_old_pass_sel(new_old_pass_sel), .plain_reg(
        plain_reg), .local_master_reg(local_master_reg), .local_master_sel(
        local_master_sel), .out_reg(out_reg), .write_en(write_en), .write_add(
        write_add), .boot_lood(boot_lood), .match(match), .dec_done(dec_done), 
        .ready_encryption(ready_encryption), .write_data_flash(
        write_data_flash), .add_flash(add_flash), .final_output(password_enc)
         );
  FSM L2 ( .clk(clk), .rst(rst), .match(match), .go(go), .enc_done(
        ready_encryption), .dec_done(dec_done), .max_add(max_address), 
        .cam_start(cam_start), .start_dec(start_dec), .start_enc(start_enc), 
        .boot_load_reg(boot_lood), .cam_write_en(write_en), .flash_write_en(
        flash_write), .flash_or_acc_sel(flash_or_acc_sel), .flash_or_acc_reg(
        flash_or_acc_reg), .pass_enc_reg(pass_enc_reg), .new_old_pass_sel(
        new_old_pass_sel), .plain_reg(plain_reg), .out_reg(out_reg), 
        .flash_acc_reg(flash_acc_reg), .flash_pass_reg(flash_pass_reg), 
        .local_master_sel(local_master_sel), .local_master_reg(
        local_master_reg), .done(done), .address_out(write_add), 
        .boot_done_signal(boot_done_signal) );
endmodule

