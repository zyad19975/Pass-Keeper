`timescale 1ns / 1ps
module FSM(
    input   clk,
    input   rst,
    input   match,
    input   go,
    input   enc_done,
    input   dec_done,
    input   [3:0] max_add,
    output reg  cam_start,
    output reg  start_dec,
    output reg  start_enc,
    output reg  boot_load_reg,
    output reg  cam_write_en,
    output reg  flash_write_en,
    output reg  flash_or_acc_sel,
    output reg  flash_or_acc_reg,
    output reg  pass_enc_reg,
    output reg  new_old_pass_sel,
    output reg  plain_reg,
    output reg  out_reg,
    output reg  flash_acc_reg,
    output reg  flash_pass_reg,
    output reg  local_master_sel,
    output reg  local_master_reg,
    output reg  done,
    output reg  [3:0] address_out, //da el address ele mtwsl b flash w cam f nafs el wa2t
    output reg  boot_done_signal
    );
    
    reg [4:0] currentstate;
    reg [4:0] nextstate;
    parameter start = 0,            boot = 1,               load_cam = 2;
    parameter busy_cam = 3,         boot_done = 4,          idle = 5;
    parameter add_icrement = 6,     go_state = 7,           check_match = 8;
    parameter matched = 9,          decrypt_start = 10,     encrypt_master = 11;
    parameter wait_enc = 12,        not_matched = 13,       encrypt_load = 14; 
    parameter wait_encrypt = 15,    falsh_write = 16,       out = 17;
    parameter wait_dec = 18;


    always @(posedge clk, posedge rst)
    begin
        
        if(rst) // go to state zero if rese
            begin
            currentstate <= start;
            end
        else // otherwise update the states
            begin
            currentstate <= nextstate;
            end
    end
    
    always@(currentstate,match,go,enc_done,dec_done,max_add,cam_start)
    begin
        
        case(currentstate)
            start:
            begin
                address_out <= 0;
                boot_load_reg <= 0;
                start_enc <=0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                cam_start <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                boot_done_signal <=0;
                nextstate <= boot;
            end


            boot:
            begin
                boot_load_reg <= 0;
                start_enc <=0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                cam_start <=0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                boot_done_signal <=0;
                if (address_out < max_add) begin
                    nextstate <=load_cam;
                end else begin
                    nextstate <=boot_done;
                end

            end


            load_cam:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 1;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 1;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=0; 
                cam_start <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                boot_done_signal <=0;
                nextstate <= busy_cam;
            end


            busy_cam:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                start_enc <=0;                 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                boot_done_signal <=0;
                nextstate <= boot;
                address_out <= address_out +1;
            end


            boot_done:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                boot_done_signal <=1;
                nextstate <= idle;
            end


            idle:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=0; 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                if(go)
                begin
                    nextstate <= go_state;
                end
                
            end

            go_state:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 1;
                flash_or_acc_reg <= 1;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                cam_start <=0;
                start_dec <=0; 
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                nextstate <= check_match;
            end


            check_match:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                cam_start <=1;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                if (match) begin
                    nextstate <= matched;
                end else begin
                    nextstate <= not_matched;
                end
            end


            matched:
            begin
                boot_load_reg <= 1;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 1;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                start_enc <=0;
                cam_start <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                nextstate <= decrypt_start;
            end


            decrypt_start:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 1;
                plain_reg <= 0;
                start_dec <=1; 
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                 nextstate <= wait_dec;
                
            end
            
            wait_dec:
            begin
            boot_load_reg <= 0;
            cam_write_en <= 0;
            flash_write_en <= 0;
            flash_or_acc_sel <= 0;
            flash_or_acc_reg <= 0;
            pass_enc_reg <= 0;
            new_old_pass_sel <= 1;
            plain_reg <= 1;
            start_dec <=0; 
            start_enc <=0;
            out_reg <= 0;
            flash_acc_reg <= 0;
            flash_pass_reg <= 0;
            local_master_sel <= 0;
            local_master_reg <= 0;
            done <= 0;
            
            if (dec_done) begin
                nextstate <= encrypt_master;
            end
            
            end


            encrypt_master:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0; 
                start_enc <=1;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 1;
                local_master_reg <= 1;
                done <= 0;
                nextstate <= wait_enc;
            end


            wait_enc:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <= 0; 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                if (enc_done) begin
                    nextstate <= out;
                end
            end


            not_matched:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 1;
                cam_start <=0;
                start_dec <=0;
                start_enc <=0; 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 1;
                done <= 0;
                nextstate <= encrypt_load;
            end


            encrypt_load:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=1; 
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                nextstate <= wait_encrypt;
 
            end


            wait_encrypt:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 1;
                flash_pass_reg <= 1;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                if (enc_done) begin
                nextstate <= falsh_write;
                end
            end


            falsh_write:
            begin
                
                boot_load_reg <= 0;
                cam_write_en <= 1;
                flash_write_en <= 1;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 1;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=0;
                out_reg <= 0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                nextstate <=  add_icrement;
            end
          
            add_icrement:
                begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;  
                out_reg <= 0;
                start_dec <=0;
                start_enc <=0;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 0;
                nextstate <=  encrypt_master;
                address_out <= address_out + 1;
            end
            
            out:
            begin
                boot_load_reg <= 0;
                cam_write_en <= 0;
                flash_write_en <= 0;
                flash_or_acc_sel <= 0;
                flash_or_acc_reg <= 0;
                pass_enc_reg <= 0;
                new_old_pass_sel <= 0;
                plain_reg <= 0;
                start_dec <=0;
                start_enc <=0;  
                out_reg <= 1;
                flash_acc_reg <= 0;
                flash_pass_reg <= 0;
                local_master_sel <= 0;
                local_master_reg <= 0;
                done <= 1;
                nextstate <= idle;
            end
            default:
            begin
                 address_out <= 0;
                 boot_load_reg <= 0;
                 start_enc <=0;
                 cam_write_en <= 0;
                 flash_write_en <= 0;
                 flash_or_acc_sel <= 0;
                 flash_or_acc_reg <= 0;
                 pass_enc_reg <= 0;
                 new_old_pass_sel <= 0;
                 plain_reg <= 0;
                 start_dec <=0;
                 cam_start <=0;
                 out_reg <= 0;
                 flash_acc_reg <= 0;
                 flash_pass_reg <= 0;
                 local_master_sel <= 0;
                 local_master_reg <= 0;
                 done <= 0;
                 boot_done_signal <=0;
                 nextstate <= boot;                
            end
        endcase

            
    end


endmodule
