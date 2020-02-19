`timescale 1ns / 1ps
module FSM(
    input   clk,
    input   rst,
    input   match,
    input   go,
    input   enc_done,
    input   [3:0] mac_add,
    output  boot_load_reg,
    output  cam_write_en,
    output  flash_write_en,
    output  flash_or_acc_sel,
    output  flash_or_acc_reg,
    output  pass_enc_reg,
    output  new_old_pass_sel,
    output  plain_reg,
    output  key_reg,
    output  out_reg,
    output  flash_acc_reg,
    output  flash_pass_reg,
    output  local_master_sel,
    output  local_master_reg,
    output  [3:0] address_out, //da el address ele mtwsl b flash w cam f nafs el wa2t
    );


endmodule