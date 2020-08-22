`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

interface Hard_interface (input bit clk );
    logic go;
    logic rst;
    logic [127:0] master_key;
    logic [127:0] account;
    logic [127:0] password;
    logic [127:0] password_enc;
    logic done;
	logic boot_done;
    
                    
    modport test(   output go,
                           rst,
                           master_key,
                           account,
                           password,
                    input  password_enc,
						   done,
						   boot_done
                           );
                    

    modport monit(    input    go,
                               rst,
                               master_key,
                               account,
                               password,
                               password_enc,
                               done,
							   boot_done
                               ); 
                                                    
                                   
endinterface
