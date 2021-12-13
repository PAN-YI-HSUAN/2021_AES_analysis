write -hierarchy -format ddc -output RISCV_syn.ddc

set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
change_names -hierarchy -rules verilog -verbose > change_names.verilog.rpt
change_names -hierarchy -rules asic_core_rules -verbose > change_names.tsmc.rpt

write -hierarchy -format verilog -output RISCV_syn.v
write_sdf -version 2.1 RISCV_syn.sdf
write_sdc -version 2.1 RISCV_syn.sdc
