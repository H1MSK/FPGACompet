package axi_lite_regs

import spinal.core._

object GenerateVerilog extends App {
  project.ProjectConfig.spinal.generateVerilog(AxiLiteRegs(project.Config()))
}
