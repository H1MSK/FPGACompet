package adaptors

import spinal.core._

object GenerateVerilog extends App {
  ProjectConfig.spinal.generateVerilog(AxiStreamWidthAdaptorI8O32())
  ProjectConfig.spinal.generateVerilog(AxiStreamWidthAdaptorI32O8())
}
