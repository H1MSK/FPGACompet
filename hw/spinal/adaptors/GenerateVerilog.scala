package adaptors

import spinal.core._

object GenerateVerilog extends App {
  ProjectConfig.spinal.generateVerilog(FakeTop())
}
