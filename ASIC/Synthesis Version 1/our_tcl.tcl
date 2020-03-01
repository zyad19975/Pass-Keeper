#License
export SNPSLMD_LICENSE_FILE=/usr/synopsys/lic/Working/synopsys_new.dat

#Init
dc_shell -64

# set search path variable
set search_path ". ~/Desktop/Project/Final/AES $search_path"
set search_path "~/Desktop/Project/Final/libs $search_path"
set search_path "~/Desktop/Project/SAED32_EDK $search_path"
set search_path "~/Desktop/Project/SAED32_EDK/lib/stdcell_rvt/db_nldm $search_path"

#prepare libraries
set target_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"
set link_library "/home/cadence/Desktop/synthesis_1/saed32hvt_ss0p7vn40c.db"

# Read the design files
read_verilog trial.v

# create timing constraints
create_clock "clk" -period 24

#clock constraints => run.tcl

set_input_delay 4 -clock clk [get_ports reset]
set_input_delay 4 -clock clk [get_ports plaintext*]
set_input_delay 4 -clock clk [get_ports key*]
set_output_delay 3.5 -clock clk [get_ports cipher_text*]
set_output_delay 3.5 -clock clk [get_ports ready]

set_clock_uncertainty 0.5 clk
set_clock_transition 0.25 clk

set_clock_latency 0.8 -source -early clk
set_clock_latency 0.9 -source -late  clk

set_clock_latency 1.2 -rise clk
set_clock_latency 0.9 -fall clk

set_critical_range  2  aes

# area constraints
set_max_area 0

report_clock > /home/cadence/Desktop/Project/Final/reports/clock.rpt
compile 
report_timing > /home/cadence/Desktop/Project/Final/reports/timing.rpt
report_constraints -all > /home/cadence/Desktop/Project/Final/reports/constraints.rpt

#report_timing -nworst 6

report_area -hierarchy -physical > /home/cadence/Desktop/Project/Final/reports/area.rpt
report_power > /home/cadence/Desktop/Project/Final/reports/power.rpt
report_cell > /home/cadence/Desktop/Project/Final/reports/cell.rpt

write_file -format verilog -hierarchy > /home/cadence/Desktop/Project/Final/output/top.v
write_sdc /home/cadence/Desktop/Project/Final/output/top.sdc.sdc
