###################################################################

# Created by write_sdc on Thu Mar  1 08:16:01 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_max_area 0
create_clock [get_ports clk]  -period 24  -waveform {0 12}
set_clock_latency -rise 1.2  [get_clocks clk]
set_clock_latency -fall 0.9  [get_clocks clk]
set_clock_latency -source -early 0.8  [get_clocks clk]
set_clock_latency -source -late 0.9  [get_clocks clk]
set_clock_uncertainty 0.5  [get_clocks clk]
set_clock_transition -max -rise 0.25 [get_clocks clk]
set_clock_transition -max -fall 0.25 [get_clocks clk]
set_clock_transition -min -rise 0.25 [get_clocks clk]
set_clock_transition -min -fall 0.25 [get_clocks clk]
set_input_delay -clock clk  4  [get_ports reset]
set_input_delay -clock clk  4  [get_ports {plaintext[127]}]
set_input_delay -clock clk  4  [get_ports {plaintext[126]}]
set_input_delay -clock clk  4  [get_ports {plaintext[125]}]
set_input_delay -clock clk  4  [get_ports {plaintext[124]}]
set_input_delay -clock clk  4  [get_ports {plaintext[123]}]
set_input_delay -clock clk  4  [get_ports {plaintext[122]}]
set_input_delay -clock clk  4  [get_ports {plaintext[121]}]
set_input_delay -clock clk  4  [get_ports {plaintext[120]}]
set_input_delay -clock clk  4  [get_ports {plaintext[119]}]
set_input_delay -clock clk  4  [get_ports {plaintext[118]}]
set_input_delay -clock clk  4  [get_ports {plaintext[117]}]
set_input_delay -clock clk  4  [get_ports {plaintext[116]}]
set_input_delay -clock clk  4  [get_ports {plaintext[115]}]
set_input_delay -clock clk  4  [get_ports {plaintext[114]}]
set_input_delay -clock clk  4  [get_ports {plaintext[113]}]
set_input_delay -clock clk  4  [get_ports {plaintext[112]}]
set_input_delay -clock clk  4  [get_ports {plaintext[111]}]
set_input_delay -clock clk  4  [get_ports {plaintext[110]}]
set_input_delay -clock clk  4  [get_ports {plaintext[109]}]
set_input_delay -clock clk  4  [get_ports {plaintext[108]}]
set_input_delay -clock clk  4  [get_ports {plaintext[107]}]
set_input_delay -clock clk  4  [get_ports {plaintext[106]}]
set_input_delay -clock clk  4  [get_ports {plaintext[105]}]
set_input_delay -clock clk  4  [get_ports {plaintext[104]}]
set_input_delay -clock clk  4  [get_ports {plaintext[103]}]
set_input_delay -clock clk  4  [get_ports {plaintext[102]}]
set_input_delay -clock clk  4  [get_ports {plaintext[101]}]
set_input_delay -clock clk  4  [get_ports {plaintext[100]}]
set_input_delay -clock clk  4  [get_ports {plaintext[99]}]
set_input_delay -clock clk  4  [get_ports {plaintext[98]}]
set_input_delay -clock clk  4  [get_ports {plaintext[97]}]
set_input_delay -clock clk  4  [get_ports {plaintext[96]}]
set_input_delay -clock clk  4  [get_ports {plaintext[95]}]
set_input_delay -clock clk  4  [get_ports {plaintext[94]}]
set_input_delay -clock clk  4  [get_ports {plaintext[93]}]
set_input_delay -clock clk  4  [get_ports {plaintext[92]}]
set_input_delay -clock clk  4  [get_ports {plaintext[91]}]
set_input_delay -clock clk  4  [get_ports {plaintext[90]}]
set_input_delay -clock clk  4  [get_ports {plaintext[89]}]
set_input_delay -clock clk  4  [get_ports {plaintext[88]}]
set_input_delay -clock clk  4  [get_ports {plaintext[87]}]
set_input_delay -clock clk  4  [get_ports {plaintext[86]}]
set_input_delay -clock clk  4  [get_ports {plaintext[85]}]
set_input_delay -clock clk  4  [get_ports {plaintext[84]}]
set_input_delay -clock clk  4  [get_ports {plaintext[83]}]
set_input_delay -clock clk  4  [get_ports {plaintext[82]}]
set_input_delay -clock clk  4  [get_ports {plaintext[81]}]
set_input_delay -clock clk  4  [get_ports {plaintext[80]}]
set_input_delay -clock clk  4  [get_ports {plaintext[79]}]
set_input_delay -clock clk  4  [get_ports {plaintext[78]}]
set_input_delay -clock clk  4  [get_ports {plaintext[77]}]
set_input_delay -clock clk  4  [get_ports {plaintext[76]}]
set_input_delay -clock clk  4  [get_ports {plaintext[75]}]
set_input_delay -clock clk  4  [get_ports {plaintext[74]}]
set_input_delay -clock clk  4  [get_ports {plaintext[73]}]
set_input_delay -clock clk  4  [get_ports {plaintext[72]}]
set_input_delay -clock clk  4  [get_ports {plaintext[71]}]
set_input_delay -clock clk  4  [get_ports {plaintext[70]}]
set_input_delay -clock clk  4  [get_ports {plaintext[69]}]
set_input_delay -clock clk  4  [get_ports {plaintext[68]}]
set_input_delay -clock clk  4  [get_ports {plaintext[67]}]
set_input_delay -clock clk  4  [get_ports {plaintext[66]}]
set_input_delay -clock clk  4  [get_ports {plaintext[65]}]
set_input_delay -clock clk  4  [get_ports {plaintext[64]}]
set_input_delay -clock clk  4  [get_ports {plaintext[63]}]
set_input_delay -clock clk  4  [get_ports {plaintext[62]}]
set_input_delay -clock clk  4  [get_ports {plaintext[61]}]
set_input_delay -clock clk  4  [get_ports {plaintext[60]}]
set_input_delay -clock clk  4  [get_ports {plaintext[59]}]
set_input_delay -clock clk  4  [get_ports {plaintext[58]}]
set_input_delay -clock clk  4  [get_ports {plaintext[57]}]
set_input_delay -clock clk  4  [get_ports {plaintext[56]}]
set_input_delay -clock clk  4  [get_ports {plaintext[55]}]
set_input_delay -clock clk  4  [get_ports {plaintext[54]}]
set_input_delay -clock clk  4  [get_ports {plaintext[53]}]
set_input_delay -clock clk  4  [get_ports {plaintext[52]}]
set_input_delay -clock clk  4  [get_ports {plaintext[51]}]
set_input_delay -clock clk  4  [get_ports {plaintext[50]}]
set_input_delay -clock clk  4  [get_ports {plaintext[49]}]
set_input_delay -clock clk  4  [get_ports {plaintext[48]}]
set_input_delay -clock clk  4  [get_ports {plaintext[47]}]
set_input_delay -clock clk  4  [get_ports {plaintext[46]}]
set_input_delay -clock clk  4  [get_ports {plaintext[45]}]
set_input_delay -clock clk  4  [get_ports {plaintext[44]}]
set_input_delay -clock clk  4  [get_ports {plaintext[43]}]
set_input_delay -clock clk  4  [get_ports {plaintext[42]}]
set_input_delay -clock clk  4  [get_ports {plaintext[41]}]
set_input_delay -clock clk  4  [get_ports {plaintext[40]}]
set_input_delay -clock clk  4  [get_ports {plaintext[39]}]
set_input_delay -clock clk  4  [get_ports {plaintext[38]}]
set_input_delay -clock clk  4  [get_ports {plaintext[37]}]
set_input_delay -clock clk  4  [get_ports {plaintext[36]}]
set_input_delay -clock clk  4  [get_ports {plaintext[35]}]
set_input_delay -clock clk  4  [get_ports {plaintext[34]}]
set_input_delay -clock clk  4  [get_ports {plaintext[33]}]
set_input_delay -clock clk  4  [get_ports {plaintext[32]}]
set_input_delay -clock clk  4  [get_ports {plaintext[31]}]
set_input_delay -clock clk  4  [get_ports {plaintext[30]}]
set_input_delay -clock clk  4  [get_ports {plaintext[29]}]
set_input_delay -clock clk  4  [get_ports {plaintext[28]}]
set_input_delay -clock clk  4  [get_ports {plaintext[27]}]
set_input_delay -clock clk  4  [get_ports {plaintext[26]}]
set_input_delay -clock clk  4  [get_ports {plaintext[25]}]
set_input_delay -clock clk  4  [get_ports {plaintext[24]}]
set_input_delay -clock clk  4  [get_ports {plaintext[23]}]
set_input_delay -clock clk  4  [get_ports {plaintext[22]}]
set_input_delay -clock clk  4  [get_ports {plaintext[21]}]
set_input_delay -clock clk  4  [get_ports {plaintext[20]}]
set_input_delay -clock clk  4  [get_ports {plaintext[19]}]
set_input_delay -clock clk  4  [get_ports {plaintext[18]}]
set_input_delay -clock clk  4  [get_ports {plaintext[17]}]
set_input_delay -clock clk  4  [get_ports {plaintext[16]}]
set_input_delay -clock clk  4  [get_ports {plaintext[15]}]
set_input_delay -clock clk  4  [get_ports {plaintext[14]}]
set_input_delay -clock clk  4  [get_ports {plaintext[13]}]
set_input_delay -clock clk  4  [get_ports {plaintext[12]}]
set_input_delay -clock clk  4  [get_ports {plaintext[11]}]
set_input_delay -clock clk  4  [get_ports {plaintext[10]}]
set_input_delay -clock clk  4  [get_ports {plaintext[9]}]
set_input_delay -clock clk  4  [get_ports {plaintext[8]}]
set_input_delay -clock clk  4  [get_ports {plaintext[7]}]
set_input_delay -clock clk  4  [get_ports {plaintext[6]}]
set_input_delay -clock clk  4  [get_ports {plaintext[5]}]
set_input_delay -clock clk  4  [get_ports {plaintext[4]}]
set_input_delay -clock clk  4  [get_ports {plaintext[3]}]
set_input_delay -clock clk  4  [get_ports {plaintext[2]}]
set_input_delay -clock clk  4  [get_ports {plaintext[1]}]
set_input_delay -clock clk  4  [get_ports {plaintext[0]}]
set_input_delay -clock clk  4  [get_ports {key[127]}]
set_input_delay -clock clk  4  [get_ports {key[126]}]
set_input_delay -clock clk  4  [get_ports {key[125]}]
set_input_delay -clock clk  4  [get_ports {key[124]}]
set_input_delay -clock clk  4  [get_ports {key[123]}]
set_input_delay -clock clk  4  [get_ports {key[122]}]
set_input_delay -clock clk  4  [get_ports {key[121]}]
set_input_delay -clock clk  4  [get_ports {key[120]}]
set_input_delay -clock clk  4  [get_ports {key[119]}]
set_input_delay -clock clk  4  [get_ports {key[118]}]
set_input_delay -clock clk  4  [get_ports {key[117]}]
set_input_delay -clock clk  4  [get_ports {key[116]}]
set_input_delay -clock clk  4  [get_ports {key[115]}]
set_input_delay -clock clk  4  [get_ports {key[114]}]
set_input_delay -clock clk  4  [get_ports {key[113]}]
set_input_delay -clock clk  4  [get_ports {key[112]}]
set_input_delay -clock clk  4  [get_ports {key[111]}]
set_input_delay -clock clk  4  [get_ports {key[110]}]
set_input_delay -clock clk  4  [get_ports {key[109]}]
set_input_delay -clock clk  4  [get_ports {key[108]}]
set_input_delay -clock clk  4  [get_ports {key[107]}]
set_input_delay -clock clk  4  [get_ports {key[106]}]
set_input_delay -clock clk  4  [get_ports {key[105]}]
set_input_delay -clock clk  4  [get_ports {key[104]}]
set_input_delay -clock clk  4  [get_ports {key[103]}]
set_input_delay -clock clk  4  [get_ports {key[102]}]
set_input_delay -clock clk  4  [get_ports {key[101]}]
set_input_delay -clock clk  4  [get_ports {key[100]}]
set_input_delay -clock clk  4  [get_ports {key[99]}]
set_input_delay -clock clk  4  [get_ports {key[98]}]
set_input_delay -clock clk  4  [get_ports {key[97]}]
set_input_delay -clock clk  4  [get_ports {key[96]}]
set_input_delay -clock clk  4  [get_ports {key[95]}]
set_input_delay -clock clk  4  [get_ports {key[94]}]
set_input_delay -clock clk  4  [get_ports {key[93]}]
set_input_delay -clock clk  4  [get_ports {key[92]}]
set_input_delay -clock clk  4  [get_ports {key[91]}]
set_input_delay -clock clk  4  [get_ports {key[90]}]
set_input_delay -clock clk  4  [get_ports {key[89]}]
set_input_delay -clock clk  4  [get_ports {key[88]}]
set_input_delay -clock clk  4  [get_ports {key[87]}]
set_input_delay -clock clk  4  [get_ports {key[86]}]
set_input_delay -clock clk  4  [get_ports {key[85]}]
set_input_delay -clock clk  4  [get_ports {key[84]}]
set_input_delay -clock clk  4  [get_ports {key[83]}]
set_input_delay -clock clk  4  [get_ports {key[82]}]
set_input_delay -clock clk  4  [get_ports {key[81]}]
set_input_delay -clock clk  4  [get_ports {key[80]}]
set_input_delay -clock clk  4  [get_ports {key[79]}]
set_input_delay -clock clk  4  [get_ports {key[78]}]
set_input_delay -clock clk  4  [get_ports {key[77]}]
set_input_delay -clock clk  4  [get_ports {key[76]}]
set_input_delay -clock clk  4  [get_ports {key[75]}]
set_input_delay -clock clk  4  [get_ports {key[74]}]
set_input_delay -clock clk  4  [get_ports {key[73]}]
set_input_delay -clock clk  4  [get_ports {key[72]}]
set_input_delay -clock clk  4  [get_ports {key[71]}]
set_input_delay -clock clk  4  [get_ports {key[70]}]
set_input_delay -clock clk  4  [get_ports {key[69]}]
set_input_delay -clock clk  4  [get_ports {key[68]}]
set_input_delay -clock clk  4  [get_ports {key[67]}]
set_input_delay -clock clk  4  [get_ports {key[66]}]
set_input_delay -clock clk  4  [get_ports {key[65]}]
set_input_delay -clock clk  4  [get_ports {key[64]}]
set_input_delay -clock clk  4  [get_ports {key[63]}]
set_input_delay -clock clk  4  [get_ports {key[62]}]
set_input_delay -clock clk  4  [get_ports {key[61]}]
set_input_delay -clock clk  4  [get_ports {key[60]}]
set_input_delay -clock clk  4  [get_ports {key[59]}]
set_input_delay -clock clk  4  [get_ports {key[58]}]
set_input_delay -clock clk  4  [get_ports {key[57]}]
set_input_delay -clock clk  4  [get_ports {key[56]}]
set_input_delay -clock clk  4  [get_ports {key[55]}]
set_input_delay -clock clk  4  [get_ports {key[54]}]
set_input_delay -clock clk  4  [get_ports {key[53]}]
set_input_delay -clock clk  4  [get_ports {key[52]}]
set_input_delay -clock clk  4  [get_ports {key[51]}]
set_input_delay -clock clk  4  [get_ports {key[50]}]
set_input_delay -clock clk  4  [get_ports {key[49]}]
set_input_delay -clock clk  4  [get_ports {key[48]}]
set_input_delay -clock clk  4  [get_ports {key[47]}]
set_input_delay -clock clk  4  [get_ports {key[46]}]
set_input_delay -clock clk  4  [get_ports {key[45]}]
set_input_delay -clock clk  4  [get_ports {key[44]}]
set_input_delay -clock clk  4  [get_ports {key[43]}]
set_input_delay -clock clk  4  [get_ports {key[42]}]
set_input_delay -clock clk  4  [get_ports {key[41]}]
set_input_delay -clock clk  4  [get_ports {key[40]}]
set_input_delay -clock clk  4  [get_ports {key[39]}]
set_input_delay -clock clk  4  [get_ports {key[38]}]
set_input_delay -clock clk  4  [get_ports {key[37]}]
set_input_delay -clock clk  4  [get_ports {key[36]}]
set_input_delay -clock clk  4  [get_ports {key[35]}]
set_input_delay -clock clk  4  [get_ports {key[34]}]
set_input_delay -clock clk  4  [get_ports {key[33]}]
set_input_delay -clock clk  4  [get_ports {key[32]}]
set_input_delay -clock clk  4  [get_ports {key[31]}]
set_input_delay -clock clk  4  [get_ports {key[30]}]
set_input_delay -clock clk  4  [get_ports {key[29]}]
set_input_delay -clock clk  4  [get_ports {key[28]}]
set_input_delay -clock clk  4  [get_ports {key[27]}]
set_input_delay -clock clk  4  [get_ports {key[26]}]
set_input_delay -clock clk  4  [get_ports {key[25]}]
set_input_delay -clock clk  4  [get_ports {key[24]}]
set_input_delay -clock clk  4  [get_ports {key[23]}]
set_input_delay -clock clk  4  [get_ports {key[22]}]
set_input_delay -clock clk  4  [get_ports {key[21]}]
set_input_delay -clock clk  4  [get_ports {key[20]}]
set_input_delay -clock clk  4  [get_ports {key[19]}]
set_input_delay -clock clk  4  [get_ports {key[18]}]
set_input_delay -clock clk  4  [get_ports {key[17]}]
set_input_delay -clock clk  4  [get_ports {key[16]}]
set_input_delay -clock clk  4  [get_ports {key[15]}]
set_input_delay -clock clk  4  [get_ports {key[14]}]
set_input_delay -clock clk  4  [get_ports {key[13]}]
set_input_delay -clock clk  4  [get_ports {key[12]}]
set_input_delay -clock clk  4  [get_ports {key[11]}]
set_input_delay -clock clk  4  [get_ports {key[10]}]
set_input_delay -clock clk  4  [get_ports {key[9]}]
set_input_delay -clock clk  4  [get_ports {key[8]}]
set_input_delay -clock clk  4  [get_ports {key[7]}]
set_input_delay -clock clk  4  [get_ports {key[6]}]
set_input_delay -clock clk  4  [get_ports {key[5]}]
set_input_delay -clock clk  4  [get_ports {key[4]}]
set_input_delay -clock clk  4  [get_ports {key[3]}]
set_input_delay -clock clk  4  [get_ports {key[2]}]
set_input_delay -clock clk  4  [get_ports {key[1]}]
set_input_delay -clock clk  4  [get_ports {key[0]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[127]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[126]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[125]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[124]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[123]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[122]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[121]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[120]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[119]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[118]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[117]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[116]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[115]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[114]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[113]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[112]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[111]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[110]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[109]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[108]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[107]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[106]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[105]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[104]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[103]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[102]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[101]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[100]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[99]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[98]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[97]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[96]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[95]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[94]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[93]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[92]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[91]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[90]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[89]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[88]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[87]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[86]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[85]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[84]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[83]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[82]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[81]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[80]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[79]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[78]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[77]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[76]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[75]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[74]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[73]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[72]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[71]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[70]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[69]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[68]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[67]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[66]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[65]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[64]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[63]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[62]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[61]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[60]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[59]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[58]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[57]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[56]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[55]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[54]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[53]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[52]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[51]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[50]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[49]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[48]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[47]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[46]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[45]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[44]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[43]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[42]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[41]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[40]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[39]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[38]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[37]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[36]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[35]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[34]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[33]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[32]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[31]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[30]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[29]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[28]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[27]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[26]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[25]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[24]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[23]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[22]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[21]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[20]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[19]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[18]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[17]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[16]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[15]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[14]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[13]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[12]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[11]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[10]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[9]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[8]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[7]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[6]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[5]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[4]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[3]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[2]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[1]}]
set_output_delay -clock clk  3.5  [get_ports {cipher_text[0]}]
set_output_delay -clock clk  3.5  [get_ports ready]