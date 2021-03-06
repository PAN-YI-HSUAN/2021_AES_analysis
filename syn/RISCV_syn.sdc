###################################################################

# Created by write_sdc on Mon Aug  9 12:48:38 2021

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -power mW -voltage V       \
-current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_max_area 0
create_clock [get_ports clk]  -period 7.6  -waveform {0 3.8}
set_clock_latency -source 0  [get_clocks clk]
set_clock_uncertainty 0.05  [get_clocks clk]
set_clock_transition -max -rise 0.05 [get_clocks clk]
set_clock_transition -max -fall 0.05 [get_clocks clk]
set_clock_transition -min -rise 0.05 [get_clocks clk]
set_clock_transition -min -fall 0.05 [get_clocks clk]
set_input_delay -clock clk  3.8  [get_ports {src_i[1]}]
set_input_delay -clock clk  3.8  [get_ports {src_i[0]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[31]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[30]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[29]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[28]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[27]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[26]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[25]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[24]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[23]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[22]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[21]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[20]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[19]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[18]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[17]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[16]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[15]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[14]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[13]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[12]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[11]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[10]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[9]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[8]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[7]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[6]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[5]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[4]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[3]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[2]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[1]}]
set_input_delay -clock clk  3.8  [get_ports {a_I_i[0]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[31]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[30]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[29]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[28]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[27]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[26]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[25]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[24]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[23]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[22]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[21]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[20]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[19]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[18]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[17]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[16]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[15]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[14]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[13]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[12]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[11]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[10]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[9]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[8]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[7]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[6]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[5]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[4]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[3]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[2]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[1]}]
set_input_delay -clock clk  3.8  [get_ports {a_D_i[0]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[31]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[30]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[29]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[28]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[27]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[26]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[25]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[24]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[23]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[22]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[21]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[20]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[19]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[18]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[17]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[16]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[15]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[14]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[13]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[12]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[11]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[10]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[9]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[8]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[7]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[6]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[5]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[4]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[3]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[2]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[1]}]
set_input_delay -clock clk  3.8  [get_ports {d_I_i[0]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[31]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[30]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[29]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[28]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[27]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[26]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[25]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[24]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[23]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[22]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[21]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[20]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[19]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[18]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[17]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[16]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[15]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[14]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[13]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[12]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[11]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[10]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[9]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[8]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[7]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[6]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[5]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[4]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[3]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[2]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[1]}]
set_input_delay -clock clk  3.8  [get_ports {d_D_i[0]}]
set_input_delay -clock clk  0  [get_ports rst]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[31]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[31]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[30]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[30]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[29]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[29]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[28]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[28]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[27]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[27]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[26]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[26]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[25]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[25]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[24]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[24]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[23]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[23]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[22]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[22]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[21]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[21]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[20]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[20]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[19]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[19]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[18]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[18]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[17]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[17]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[16]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[16]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[15]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[15]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[14]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[14]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[13]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[13]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[12]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[12]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[11]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[11]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[10]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[10]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[9]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[9]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[8]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[8]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[7]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[7]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[6]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[6]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[5]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[5]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[4]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[4]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[3]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[3]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[2]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[2]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[1]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[1]}]
set_output_delay -clock clk  -max 3.8  [get_ports {q_o[0]}]
set_output_delay -clock clk  -min 0  [get_ports {q_o[0]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[31]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[31]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[30]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[30]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[29]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[29]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[28]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[28]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[27]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[27]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[26]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[26]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[25]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[25]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[24]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[24]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[23]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[23]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[22]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[22]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[21]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[21]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[20]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[20]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[19]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[19]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[18]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[18]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[17]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[17]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[16]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[16]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[15]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[15]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[14]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[14]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[13]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[13]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[12]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[12]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[11]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[11]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[10]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[10]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[9]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[9]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[8]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[8]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[7]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[7]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[6]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[6]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[5]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[5]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[4]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[4]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[3]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[3]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[2]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[2]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[1]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[1]}]
set_output_delay -clock clk  -max 3.8  [get_ports {det_a_o[0]}]
set_output_delay -clock clk  -min 0  [get_ports {det_a_o[0]}]
set_input_transition -max 0.05  [get_ports clk]
set_input_transition -min 0.05  [get_ports clk]
set_input_transition -max 0.05  [get_ports rst]
set_input_transition -min 0.05  [get_ports rst]
set_input_transition -max 0.05  [get_ports {src_i[1]}]
set_input_transition -min 0.05  [get_ports {src_i[1]}]
set_input_transition -max 0.05  [get_ports {src_i[0]}]
set_input_transition -min 0.05  [get_ports {src_i[0]}]
set_input_transition -max 0.05  [get_ports {a_I_i[31]}]
set_input_transition -min 0.05  [get_ports {a_I_i[31]}]
set_input_transition -max 0.05  [get_ports {a_I_i[30]}]
set_input_transition -min 0.05  [get_ports {a_I_i[30]}]
set_input_transition -max 0.05  [get_ports {a_I_i[29]}]
set_input_transition -min 0.05  [get_ports {a_I_i[29]}]
set_input_transition -max 0.05  [get_ports {a_I_i[28]}]
set_input_transition -min 0.05  [get_ports {a_I_i[28]}]
set_input_transition -max 0.05  [get_ports {a_I_i[27]}]
set_input_transition -min 0.05  [get_ports {a_I_i[27]}]
set_input_transition -max 0.05  [get_ports {a_I_i[26]}]
set_input_transition -min 0.05  [get_ports {a_I_i[26]}]
set_input_transition -max 0.05  [get_ports {a_I_i[25]}]
set_input_transition -min 0.05  [get_ports {a_I_i[25]}]
set_input_transition -max 0.05  [get_ports {a_I_i[24]}]
set_input_transition -min 0.05  [get_ports {a_I_i[24]}]
set_input_transition -max 0.05  [get_ports {a_I_i[23]}]
set_input_transition -min 0.05  [get_ports {a_I_i[23]}]
set_input_transition -max 0.05  [get_ports {a_I_i[22]}]
set_input_transition -min 0.05  [get_ports {a_I_i[22]}]
set_input_transition -max 0.05  [get_ports {a_I_i[21]}]
set_input_transition -min 0.05  [get_ports {a_I_i[21]}]
set_input_transition -max 0.05  [get_ports {a_I_i[20]}]
set_input_transition -min 0.05  [get_ports {a_I_i[20]}]
set_input_transition -max 0.05  [get_ports {a_I_i[19]}]
set_input_transition -min 0.05  [get_ports {a_I_i[19]}]
set_input_transition -max 0.05  [get_ports {a_I_i[18]}]
set_input_transition -min 0.05  [get_ports {a_I_i[18]}]
set_input_transition -max 0.05  [get_ports {a_I_i[17]}]
set_input_transition -min 0.05  [get_ports {a_I_i[17]}]
set_input_transition -max 0.05  [get_ports {a_I_i[16]}]
set_input_transition -min 0.05  [get_ports {a_I_i[16]}]
set_input_transition -max 0.05  [get_ports {a_I_i[15]}]
set_input_transition -min 0.05  [get_ports {a_I_i[15]}]
set_input_transition -max 0.05  [get_ports {a_I_i[14]}]
set_input_transition -min 0.05  [get_ports {a_I_i[14]}]
set_input_transition -max 0.05  [get_ports {a_I_i[13]}]
set_input_transition -min 0.05  [get_ports {a_I_i[13]}]
set_input_transition -max 0.05  [get_ports {a_I_i[12]}]
set_input_transition -min 0.05  [get_ports {a_I_i[12]}]
set_input_transition -max 0.05  [get_ports {a_I_i[11]}]
set_input_transition -min 0.05  [get_ports {a_I_i[11]}]
set_input_transition -max 0.05  [get_ports {a_I_i[10]}]
set_input_transition -min 0.05  [get_ports {a_I_i[10]}]
set_input_transition -max 0.05  [get_ports {a_I_i[9]}]
set_input_transition -min 0.05  [get_ports {a_I_i[9]}]
set_input_transition -max 0.05  [get_ports {a_I_i[8]}]
set_input_transition -min 0.05  [get_ports {a_I_i[8]}]
set_input_transition -max 0.05  [get_ports {a_I_i[7]}]
set_input_transition -min 0.05  [get_ports {a_I_i[7]}]
set_input_transition -max 0.05  [get_ports {a_I_i[6]}]
set_input_transition -min 0.05  [get_ports {a_I_i[6]}]
set_input_transition -max 0.05  [get_ports {a_I_i[5]}]
set_input_transition -min 0.05  [get_ports {a_I_i[5]}]
set_input_transition -max 0.05  [get_ports {a_I_i[4]}]
set_input_transition -min 0.05  [get_ports {a_I_i[4]}]
set_input_transition -max 0.05  [get_ports {a_I_i[3]}]
set_input_transition -min 0.05  [get_ports {a_I_i[3]}]
set_input_transition -max 0.05  [get_ports {a_I_i[2]}]
set_input_transition -min 0.05  [get_ports {a_I_i[2]}]
set_input_transition -max 0.05  [get_ports {a_I_i[1]}]
set_input_transition -min 0.05  [get_ports {a_I_i[1]}]
set_input_transition -max 0.05  [get_ports {a_I_i[0]}]
set_input_transition -min 0.05  [get_ports {a_I_i[0]}]
set_input_transition -max 0.05  [get_ports {a_D_i[31]}]
set_input_transition -min 0.05  [get_ports {a_D_i[31]}]
set_input_transition -max 0.05  [get_ports {a_D_i[30]}]
set_input_transition -min 0.05  [get_ports {a_D_i[30]}]
set_input_transition -max 0.05  [get_ports {a_D_i[29]}]
set_input_transition -min 0.05  [get_ports {a_D_i[29]}]
set_input_transition -max 0.05  [get_ports {a_D_i[28]}]
set_input_transition -min 0.05  [get_ports {a_D_i[28]}]
set_input_transition -max 0.05  [get_ports {a_D_i[27]}]
set_input_transition -min 0.05  [get_ports {a_D_i[27]}]
set_input_transition -max 0.05  [get_ports {a_D_i[26]}]
set_input_transition -min 0.05  [get_ports {a_D_i[26]}]
set_input_transition -max 0.05  [get_ports {a_D_i[25]}]
set_input_transition -min 0.05  [get_ports {a_D_i[25]}]
set_input_transition -max 0.05  [get_ports {a_D_i[24]}]
set_input_transition -min 0.05  [get_ports {a_D_i[24]}]
set_input_transition -max 0.05  [get_ports {a_D_i[23]}]
set_input_transition -min 0.05  [get_ports {a_D_i[23]}]
set_input_transition -max 0.05  [get_ports {a_D_i[22]}]
set_input_transition -min 0.05  [get_ports {a_D_i[22]}]
set_input_transition -max 0.05  [get_ports {a_D_i[21]}]
set_input_transition -min 0.05  [get_ports {a_D_i[21]}]
set_input_transition -max 0.05  [get_ports {a_D_i[20]}]
set_input_transition -min 0.05  [get_ports {a_D_i[20]}]
set_input_transition -max 0.05  [get_ports {a_D_i[19]}]
set_input_transition -min 0.05  [get_ports {a_D_i[19]}]
set_input_transition -max 0.05  [get_ports {a_D_i[18]}]
set_input_transition -min 0.05  [get_ports {a_D_i[18]}]
set_input_transition -max 0.05  [get_ports {a_D_i[17]}]
set_input_transition -min 0.05  [get_ports {a_D_i[17]}]
set_input_transition -max 0.05  [get_ports {a_D_i[16]}]
set_input_transition -min 0.05  [get_ports {a_D_i[16]}]
set_input_transition -max 0.05  [get_ports {a_D_i[15]}]
set_input_transition -min 0.05  [get_ports {a_D_i[15]}]
set_input_transition -max 0.05  [get_ports {a_D_i[14]}]
set_input_transition -min 0.05  [get_ports {a_D_i[14]}]
set_input_transition -max 0.05  [get_ports {a_D_i[13]}]
set_input_transition -min 0.05  [get_ports {a_D_i[13]}]
set_input_transition -max 0.05  [get_ports {a_D_i[12]}]
set_input_transition -min 0.05  [get_ports {a_D_i[12]}]
set_input_transition -max 0.05  [get_ports {a_D_i[11]}]
set_input_transition -min 0.05  [get_ports {a_D_i[11]}]
set_input_transition -max 0.05  [get_ports {a_D_i[10]}]
set_input_transition -min 0.05  [get_ports {a_D_i[10]}]
set_input_transition -max 0.05  [get_ports {a_D_i[9]}]
set_input_transition -min 0.05  [get_ports {a_D_i[9]}]
set_input_transition -max 0.05  [get_ports {a_D_i[8]}]
set_input_transition -min 0.05  [get_ports {a_D_i[8]}]
set_input_transition -max 0.05  [get_ports {a_D_i[7]}]
set_input_transition -min 0.05  [get_ports {a_D_i[7]}]
set_input_transition -max 0.05  [get_ports {a_D_i[6]}]
set_input_transition -min 0.05  [get_ports {a_D_i[6]}]
set_input_transition -max 0.05  [get_ports {a_D_i[5]}]
set_input_transition -min 0.05  [get_ports {a_D_i[5]}]
set_input_transition -max 0.05  [get_ports {a_D_i[4]}]
set_input_transition -min 0.05  [get_ports {a_D_i[4]}]
set_input_transition -max 0.05  [get_ports {a_D_i[3]}]
set_input_transition -min 0.05  [get_ports {a_D_i[3]}]
set_input_transition -max 0.05  [get_ports {a_D_i[2]}]
set_input_transition -min 0.05  [get_ports {a_D_i[2]}]
set_input_transition -max 0.05  [get_ports {a_D_i[1]}]
set_input_transition -min 0.05  [get_ports {a_D_i[1]}]
set_input_transition -max 0.05  [get_ports {a_D_i[0]}]
set_input_transition -min 0.05  [get_ports {a_D_i[0]}]
set_input_transition -max 0.05  [get_ports {d_I_i[31]}]
set_input_transition -min 0.05  [get_ports {d_I_i[31]}]
set_input_transition -max 0.05  [get_ports {d_I_i[30]}]
set_input_transition -min 0.05  [get_ports {d_I_i[30]}]
set_input_transition -max 0.05  [get_ports {d_I_i[29]}]
set_input_transition -min 0.05  [get_ports {d_I_i[29]}]
set_input_transition -max 0.05  [get_ports {d_I_i[28]}]
set_input_transition -min 0.05  [get_ports {d_I_i[28]}]
set_input_transition -max 0.05  [get_ports {d_I_i[27]}]
set_input_transition -min 0.05  [get_ports {d_I_i[27]}]
set_input_transition -max 0.05  [get_ports {d_I_i[26]}]
set_input_transition -min 0.05  [get_ports {d_I_i[26]}]
set_input_transition -max 0.05  [get_ports {d_I_i[25]}]
set_input_transition -min 0.05  [get_ports {d_I_i[25]}]
set_input_transition -max 0.05  [get_ports {d_I_i[24]}]
set_input_transition -min 0.05  [get_ports {d_I_i[24]}]
set_input_transition -max 0.05  [get_ports {d_I_i[23]}]
set_input_transition -min 0.05  [get_ports {d_I_i[23]}]
set_input_transition -max 0.05  [get_ports {d_I_i[22]}]
set_input_transition -min 0.05  [get_ports {d_I_i[22]}]
set_input_transition -max 0.05  [get_ports {d_I_i[21]}]
set_input_transition -min 0.05  [get_ports {d_I_i[21]}]
set_input_transition -max 0.05  [get_ports {d_I_i[20]}]
set_input_transition -min 0.05  [get_ports {d_I_i[20]}]
set_input_transition -max 0.05  [get_ports {d_I_i[19]}]
set_input_transition -min 0.05  [get_ports {d_I_i[19]}]
set_input_transition -max 0.05  [get_ports {d_I_i[18]}]
set_input_transition -min 0.05  [get_ports {d_I_i[18]}]
set_input_transition -max 0.05  [get_ports {d_I_i[17]}]
set_input_transition -min 0.05  [get_ports {d_I_i[17]}]
set_input_transition -max 0.05  [get_ports {d_I_i[16]}]
set_input_transition -min 0.05  [get_ports {d_I_i[16]}]
set_input_transition -max 0.05  [get_ports {d_I_i[15]}]
set_input_transition -min 0.05  [get_ports {d_I_i[15]}]
set_input_transition -max 0.05  [get_ports {d_I_i[14]}]
set_input_transition -min 0.05  [get_ports {d_I_i[14]}]
set_input_transition -max 0.05  [get_ports {d_I_i[13]}]
set_input_transition -min 0.05  [get_ports {d_I_i[13]}]
set_input_transition -max 0.05  [get_ports {d_I_i[12]}]
set_input_transition -min 0.05  [get_ports {d_I_i[12]}]
set_input_transition -max 0.05  [get_ports {d_I_i[11]}]
set_input_transition -min 0.05  [get_ports {d_I_i[11]}]
set_input_transition -max 0.05  [get_ports {d_I_i[10]}]
set_input_transition -min 0.05  [get_ports {d_I_i[10]}]
set_input_transition -max 0.05  [get_ports {d_I_i[9]}]
set_input_transition -min 0.05  [get_ports {d_I_i[9]}]
set_input_transition -max 0.05  [get_ports {d_I_i[8]}]
set_input_transition -min 0.05  [get_ports {d_I_i[8]}]
set_input_transition -max 0.05  [get_ports {d_I_i[7]}]
set_input_transition -min 0.05  [get_ports {d_I_i[7]}]
set_input_transition -max 0.05  [get_ports {d_I_i[6]}]
set_input_transition -min 0.05  [get_ports {d_I_i[6]}]
set_input_transition -max 0.05  [get_ports {d_I_i[5]}]
set_input_transition -min 0.05  [get_ports {d_I_i[5]}]
set_input_transition -max 0.05  [get_ports {d_I_i[4]}]
set_input_transition -min 0.05  [get_ports {d_I_i[4]}]
set_input_transition -max 0.05  [get_ports {d_I_i[3]}]
set_input_transition -min 0.05  [get_ports {d_I_i[3]}]
set_input_transition -max 0.05  [get_ports {d_I_i[2]}]
set_input_transition -min 0.05  [get_ports {d_I_i[2]}]
set_input_transition -max 0.05  [get_ports {d_I_i[1]}]
set_input_transition -min 0.05  [get_ports {d_I_i[1]}]
set_input_transition -max 0.05  [get_ports {d_I_i[0]}]
set_input_transition -min 0.05  [get_ports {d_I_i[0]}]
set_input_transition -max 0.05  [get_ports {d_D_i[31]}]
set_input_transition -min 0.05  [get_ports {d_D_i[31]}]
set_input_transition -max 0.05  [get_ports {d_D_i[30]}]
set_input_transition -min 0.05  [get_ports {d_D_i[30]}]
set_input_transition -max 0.05  [get_ports {d_D_i[29]}]
set_input_transition -min 0.05  [get_ports {d_D_i[29]}]
set_input_transition -max 0.05  [get_ports {d_D_i[28]}]
set_input_transition -min 0.05  [get_ports {d_D_i[28]}]
set_input_transition -max 0.05  [get_ports {d_D_i[27]}]
set_input_transition -min 0.05  [get_ports {d_D_i[27]}]
set_input_transition -max 0.05  [get_ports {d_D_i[26]}]
set_input_transition -min 0.05  [get_ports {d_D_i[26]}]
set_input_transition -max 0.05  [get_ports {d_D_i[25]}]
set_input_transition -min 0.05  [get_ports {d_D_i[25]}]
set_input_transition -max 0.05  [get_ports {d_D_i[24]}]
set_input_transition -min 0.05  [get_ports {d_D_i[24]}]
set_input_transition -max 0.05  [get_ports {d_D_i[23]}]
set_input_transition -min 0.05  [get_ports {d_D_i[23]}]
set_input_transition -max 0.05  [get_ports {d_D_i[22]}]
set_input_transition -min 0.05  [get_ports {d_D_i[22]}]
set_input_transition -max 0.05  [get_ports {d_D_i[21]}]
set_input_transition -min 0.05  [get_ports {d_D_i[21]}]
set_input_transition -max 0.05  [get_ports {d_D_i[20]}]
set_input_transition -min 0.05  [get_ports {d_D_i[20]}]
set_input_transition -max 0.05  [get_ports {d_D_i[19]}]
set_input_transition -min 0.05  [get_ports {d_D_i[19]}]
set_input_transition -max 0.05  [get_ports {d_D_i[18]}]
set_input_transition -min 0.05  [get_ports {d_D_i[18]}]
set_input_transition -max 0.05  [get_ports {d_D_i[17]}]
set_input_transition -min 0.05  [get_ports {d_D_i[17]}]
set_input_transition -max 0.05  [get_ports {d_D_i[16]}]
set_input_transition -min 0.05  [get_ports {d_D_i[16]}]
set_input_transition -max 0.05  [get_ports {d_D_i[15]}]
set_input_transition -min 0.05  [get_ports {d_D_i[15]}]
set_input_transition -max 0.05  [get_ports {d_D_i[14]}]
set_input_transition -min 0.05  [get_ports {d_D_i[14]}]
set_input_transition -max 0.05  [get_ports {d_D_i[13]}]
set_input_transition -min 0.05  [get_ports {d_D_i[13]}]
set_input_transition -max 0.05  [get_ports {d_D_i[12]}]
set_input_transition -min 0.05  [get_ports {d_D_i[12]}]
set_input_transition -max 0.05  [get_ports {d_D_i[11]}]
set_input_transition -min 0.05  [get_ports {d_D_i[11]}]
set_input_transition -max 0.05  [get_ports {d_D_i[10]}]
set_input_transition -min 0.05  [get_ports {d_D_i[10]}]
set_input_transition -max 0.05  [get_ports {d_D_i[9]}]
set_input_transition -min 0.05  [get_ports {d_D_i[9]}]
set_input_transition -max 0.05  [get_ports {d_D_i[8]}]
set_input_transition -min 0.05  [get_ports {d_D_i[8]}]
set_input_transition -max 0.05  [get_ports {d_D_i[7]}]
set_input_transition -min 0.05  [get_ports {d_D_i[7]}]
set_input_transition -max 0.05  [get_ports {d_D_i[6]}]
set_input_transition -min 0.05  [get_ports {d_D_i[6]}]
set_input_transition -max 0.05  [get_ports {d_D_i[5]}]
set_input_transition -min 0.05  [get_ports {d_D_i[5]}]
set_input_transition -max 0.05  [get_ports {d_D_i[4]}]
set_input_transition -min 0.05  [get_ports {d_D_i[4]}]
set_input_transition -max 0.05  [get_ports {d_D_i[3]}]
set_input_transition -min 0.05  [get_ports {d_D_i[3]}]
set_input_transition -max 0.05  [get_ports {d_D_i[2]}]
set_input_transition -min 0.05  [get_ports {d_D_i[2]}]
set_input_transition -max 0.05  [get_ports {d_D_i[1]}]
set_input_transition -min 0.05  [get_ports {d_D_i[1]}]
set_input_transition -max 0.05  [get_ports {d_D_i[0]}]
set_input_transition -min 0.05  [get_ports {d_D_i[0]}]
