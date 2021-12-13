set cycle_time 7.6
create_clock -name clk -period $cycle_time             [get_ports clk]
set_dont_touch_network                                 [get_clocks clk]
set_fix_hold                                           [get_clocks clk]
set_clock_uncertainty       0.05    [get_clocks clk]
set_clock_latency   -source 0                          [get_clocks clk]
set_input_transition        0.05    [all_inputs]
set_clock_transition        0.05    [all_clocks]

set_input_delay [expr $cycle_time*0.5] -clock clk [get_ports {*_i}]
set_input_delay [expr $cycle_time*0.0] -clock clk [get_ports {rst}]
set_output_delay -max [expr $cycle_time*0.5] -clock clk [get_ports {*_o}]
set_output_delay -min 0 -clock clk [get_ports {*_o}]

set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

set_operating_conditions -min_library fast -min fast -max_library slow -max slow
#set_wire_load_model -name ZeroWireload -library tcbn28hpcplusbwp30p140hvtssg0p81v125c_ccs
set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA

set_max_area 0

set_dont_use { \
fast/DFFX* \
fast/DFFHQX* \
fast/DFFNSRX* \
fast/DFFQX* \
fast/DFFRX* \
fast/DFFRHQX* \
fast/DFFSX* \
fast/DFFSHQX* \
fast/DFFSRX* \
fast/DFFSRHQX2 \
fast/DFFSRHQX4 \
fast/DFFSRHQX8 \
fast/DFFTR* \
fast/EDFF* \
fast/SDF* \
fast/SEDF* \
fast/SMDF* \
slow/DFFX* \
slow/DFFHQX* \
slow/DFFNSRX* \
slow/DFFQX* \
slow/DFFRX* \
slow/DFFRHQX* \
slow/DFFSX* \
slow/DFFSHQX* \
slow/DFFSRX* \
slow/DFFSRHQX2 \
slow/DFFSRHQX4 \
slow/DFFSRHQX8 \
slow/DFFTR* \
slow/EDFF* \
slow/SDF* \
slow/SEDF* \
slow/SMDF* \
typical/DFFX* \
typical/DFFHQX* \
typical/DFFNSRX* \
typical/DFFQX* \
typical/DFFRX* \
typical/DFFRHQX* \
typical/DFFSX* \
typical/DFFSHQX* \
typical/DFFSRX* \
typical/DFFSRHQX2 \
typical/DFFSRHQX4 \
typical/DFFSRHQX8 \
typical/DFFTR* \
typical/EDFF* \
typical/SDF* \
typical/SEDF* \
typical/SMDF* \
}


check_design
check_timing
