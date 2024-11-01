package test

import spinal.core._
import project.Config

object GenerateVerilog extends App {
  project.ProjectConfig.spinal.generateVerilog(TestBench(Config())).mergeRTLSource("top")
}
