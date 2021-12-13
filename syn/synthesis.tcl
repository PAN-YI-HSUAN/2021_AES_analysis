source syn_read.tcl
source syn_rule.tcl -verbose
compile -exact_map -map_effort high
check_design > check_design.rpt
check_timing
source syn_sdf.tcl -verbose
