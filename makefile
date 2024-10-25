.PHONY: gen sim wave clean

gen:
	sbt "runMain axi_lite_regs.GenerateVerilog"

sim:
	sbt "runMain axi_lite_regs.AxiLiteRegsSim"

wave:
	gtkwave simGtkw/AxiLiteRegs.gtkw

clean:
	rm -r simWorkspace/*
