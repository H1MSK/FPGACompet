package adaptors

package axi_lite_regs

import scala.collection.mutable

import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axis.sim.{Axi4StreamMaster, Axi4StreamSlave}

object AxiStreamWidthAdaptorI32O8Sim extends App {
  project.ProjectConfig.sim.compile(AxiStreamWidthAdaptorI32O8()).doSim { dut =>
    val stream_master = Axi4StreamMaster(dut.io.i, dut.clockDomain)
    val stream_slave = Axi4StreamSlave(dut.io.o, dut.clockDomain)
    dut.clockDomain.forkStimulus(period = 10)
    dut.clockDomain.forkSimSpeedPrinter()
    dut.clockDomain.assertReset()

    waitUntil(dut.clockDomain.resetSim.toBoolean != (dut.clockDomain.config.resetActiveLevel == HIGH))

    (0 until 32).foreach { _ =>
      val data = List.fill((1 + simRandom.nextInt(15)) * 4)(simRandom.nextInt(256).toByte)
      val thread_send = fork {
        stream_master.send(data)
      }
      var recv: List[Byte] = null
      val thread_recv = fork {
        recv = stream_slave.recv()
      }
      thread_recv.join()
      thread_send.join()
      assert(recv.toList sameElements data)
    }
  }
}
