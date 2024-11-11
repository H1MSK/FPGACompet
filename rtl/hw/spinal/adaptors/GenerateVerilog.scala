package adaptors

import spinal.core._

object GenerateVerilog extends App {
  project.ProjectConfig.spinal.generateVerilog(FakeTop())
}
