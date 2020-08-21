set search_path ". ~/Desktop/Simple $search_path"
set search_path "~/Desktop/Project/Final/libs $search_path"
set search_path "~/Desktop/Simple/SAED32_EDK $search_path"
set search_path "~/Desktop/Simple/SAED32_EDK/lib/stdcell_rvt/db_nldm $search_path"


set target_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"
set link_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"


define_design_lib WORK -path ./work

##
read_verilog /home/cadence/Desktop/Simple/HW/aes.v
read_verilog /home/cadence/Desktop/Simple/HW/shift_rows.v
read_verilog /home/cadence/Desktop/Simple/HW/subbytes.v
read_verilog /home/cadence/Desktop/Simple/HW/key_generation.v
read_verilog /home/cadence/Desktop/Simple/HW/add_round_keys.v
read_verilog /home/cadence/Desktop/Simple/HW/mixcolumns.v
read_verilog /home/cadence/Desktop/Simple/HW/round.v
read_verilog /home/cadence/Desktop/Simple/HW/sbox.v
##
read_verilog /home/cadence/Desktop/Simple/HW/inv_aes.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_sbox.v
read_verilog /home/cadence/Desktop/Simple/HW/generation_keys.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_add_round_keys.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_round.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_mixcolumns.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_shift_rows.v
read_verilog /home/cadence/Desktop/Simple/HW/inv_subbytes.v
##
analyze -format verilog {encoder_2_1.v encoder.v Ram_block.v Cam_Top_level.v}
elaborate cam
##
read_verilog /home/cadence/Desktop/Simple/HW/RAM_memory.v
read_verilog /home/cadence/Desktop/Simple/HW/reg_D.v
read_verilog /home/cadence/Desktop/Simple/HW/cde.v
read_verilog /home/cadence/Desktop/Simple/HW/FSM.v
read_verilog /home/cadence/Desktop/Simple/HW/Top_level.v
read_verilog /home/cadence/Desktop/Simple/HW/Hw_wrapper.v
link

#analyze -library WORK -format verilog {/home/cadence/Desktop/Simple/HW/Hw_wrapper.v}
#elaborate Hw_wrapper -architecture verilog -library WORK

current_design Hw_wrapper
link

###############

check_design  > /home/cadence/Desktop/Simple/reports/check_design.rpt

##############
create_clock "clk" -period 10 {Hw_wrapper/clk}

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
