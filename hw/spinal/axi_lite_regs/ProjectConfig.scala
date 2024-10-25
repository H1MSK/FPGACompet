package axi_lite_regs

import spinal.core._
import spinal.core.sim._

object ProjectConfig {
  def spinal = SpinalConfig(
    targetDirectory = "hw/gen",
    oneFilePerComponent = true,
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = HIGH
    ),
    onlyStdLogicVectorAtTopLevelIo = true
  )

  def sim = SimConfig.withConfig(spinal).withFstWave
}
