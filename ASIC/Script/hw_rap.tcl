set search_path ". ~/Desktop/Simple $search_path"
set search_path "~/Desktop/Project/Final/libs $search_path"
set search_path "~/Desktop/Simple/SAED32_EDK $search_path"
set search_path "~/Desktop/Simple/SAED32_EDK/lib/stdcell_rvt/db_nldm $search_path"
set target_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"
set link_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"
set search_path "~/Desktop/Simple/HW $search_path"

define_design_lib WORK -path ./work
#------------------------AES------------------------#
analyze -format verilog {aes.v shift_rows.v subbytes.v key_generation.v add_round_keys.v 
mixcolumns.v round.v sbox.v}
elaborate aes
link
#-------------------INVERSE-AES---------------------#
analyze -format verilog {inv_aes.v inv_shift_rows.v inv_subbytes.v generation_keys.v 
inv_add_round_keys.v inv_mixcolumns.v inv_round.v inv_sbox.v}
elaborate inv_aes
link
#------------------------CAM------------------------#
analyze -format verilog {encoder_2_1.v encoder.v Ram_block.v Cam_Top_level.v}
elaborate cam
link
#--------------------HW_WRAPPER-----------------------#
analyze -format verilog {RAM_memory.v reg_D.v cde.v FSM.v Top_level.v Hw_wrapper.v}
elaborate Hw_wrapper
link

current_design Hw_wrapper
#----------CHECK DESIGN FOR ERRORS AND WARNINGS-------------------#
check_design  > /home/cadence/Desktop/Simple/reports/check_design.rpt
#--------CREATE CLOCK AND LINK IT WITH TOP MODULE'S CLOCK--------#
create_clock "clk" -period 20 {Hw_wrapper/clk}
set_max_area 0
report_clock > /home/cadence/Desktop/Simple/reports/clock.rpt
compile 
report_timing > /home/cadence/Desktop/Simple/reports/timing.rpt
report_constraints -all > /home/cadence/Desktop/Simple/reports/constraints.rpt
report_area -hierarchy -physical > /home/cadence/Desktop/Simple/reports/area.rpt
report_power > /home/cadence/Desktop/Simple/reports/power.rpt
report_cell > /home/cadence/Desktop/Simple/reports/cell.rpt

write_file -format verilog -hierarchy > /home/cadence/Desktop/Simple/output/out.v

write_sdc /home/cadence/Desktop/Simple/output/top.sdc
write_sdf /home/cadence/Desktop/Simple/output/top.sdf
start_gui



