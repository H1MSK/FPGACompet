.PHONY: gen sim wave

gen:
	sbt "runMain axi_lite_regs.GenerateVerilog"

sim:
	sbt "runMain axi_lite_regs.AxiLiteRegsSim"

wave:
	gtkwave simGtkw/AxiLiteRegs.gtkw
