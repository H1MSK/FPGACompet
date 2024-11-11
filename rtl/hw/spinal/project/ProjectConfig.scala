package project

import spinal.core._
import spinal.core.sim._

object ProjectConfig {
  def spinal = SpinalConfig(
    targetDirectory = "hw/gen",
    oneFilePerComponent = true,
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = LOW,
      resetKind = ASYNC
    ),
    onlyStdLogicVectorAtTopLevelIo = true
  )

  def sim = SimConfig.withConfig(spinal).withFstWave
}
