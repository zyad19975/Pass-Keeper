interface wrapper_intf(input logic clk,rst);
  logic [127:0] account;
  logic [127:0] password;
  logic [127:0] master_key;
  logic go;
  logic [127:0] password_enc;
  logic boot_done_signal;
  logic done;
  



    modport  DRIVER (
    output account,
    output password,
    output master_key,
    output go,
    input  password_enc,
    input  boot_done_signal,
    input  done
  );
    
endinterface