package axi_lite_regs

import spinal.core._

object GenerateVerilog extends App {
  ProjectConfig.spinal.generateVerilog(AxiLiteRegs(Config()))
}
