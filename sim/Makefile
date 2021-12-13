design = RISCV
pattern = 1
cycletime = 10.0
corner = max

DW_path = /usr/cad/synopsys/synthesis/2020.09-sp5/dw/sim_ver/
libVerilogFile = /usr/cad/designkit/digital/T13/CBDK_IC_Contest_v2.5/Verilog/tsmc13.v
# libVerilogFileEDFF = ../EDFF/Front_End/verilog/ERRDF.v

rtlsim:
	xrun RISCV_testfixture.v ../rtl/$(design).v ../rtl/sram_512x8.vp -y $(DW_path) +libext+.v +incdir+$(DW_path) +define+PATTERN=$(pattern) +define+CYCLE=$(cycletime) +xm64bit +notimingchecks
rtlsim-vcd:
	xrun RISCV_testfixture.v ../rtl/$(design).v ../rtl/sram_512x8.vp -y $(DW_path) +libext+.v +incdir+$(DW_path) +define+PATTERN=$(pattern) +define+VCD +define+CYCLE=$(cycletime) +access+r +xm64bit +notimingchecks
rtlsim-fsdb:
	xrun RISCV_testfixture.v ../rtl/$(design).v ../rtl/sram_512x8.vp -y $(DW_path) +libext+.v +incdir+$(DW_path) +define+PATTERN=$(pattern) +define+FSDB +define+CYCLE=$(cycletime) +access+r +xm64bit +notimingchecks
gatesim:
	xrun RISCV_testfixture.v ../synthesis/$(design)_syn.v -v $(libVerilogFile) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +xm64bit +xmsdfnowarn +xm$(corner)delays
gatesim-vcd:
	xrun RISCV_testfixture.v ../synthesis/$(design)_syn.v -v $(libVerilogFile) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +define+VCD +access+r +xm64bit +xmsdfnowarn +xm$(corner)delays
gatesim-fsdb:
	xrun RISCV_testfixture.v ../synthesis/$(design)_syn.v -v $(libVerilogFile) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +define+FSDB +access+r +xmsdfnowarn +xm$(corner)delays
# gatesim-edac:
# 	ncverilog RISCV_testfixture.v ../synthesis/$(design) -v $(libVerilogFile) -v $(libVerilogFileEDFF) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +define+EDAC +nc64bit +ncsdfnowarn +nc$(corner)delays +no_tchk_msg
# gatesim-edac-fsdb:
# 	ncverilog RISCV_testfixture.v ../synthesis/$(design) -v $(libVerilogFile) -v $(libVerilogFileEDFF) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +define+FSDB +define+EDAC +access+r +ncsdfnowarn +nc$(corner)delays +no_tchk_msg
# gatesim-edac-vcd:
# 	ncverilog RISCV_testfixture.v ../synthesis/$(design) -v $(libVerilogFile) -v $(libVerilogFileEDFF) +define+PATTERN=$(pattern) +define+SDF +define+CYCLE=$(cycletime) +define+VCD +define+EDAC +access+r +nc64bit +ncsdfnowarn +nc$(corner)delays +no_tchk_msg
clean:
	rm -rf ./xcelium.d
