package test

package axi_lite_regs

import scala.collection.mutable

import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axis.sim.{Axi4StreamMaster, Axi4StreamSlave}
import spinal.lib.bus.amba4.axilite.sim.AxiLite4Master

object TestBenchSim extends App {
  project.ProjectConfig.sim.compile(TestBench(project.Config())).doSim { dut =>
    val stream_master = Axi4StreamMaster(dut.io.i, dut.clockDomain)
    val stream_slave = Axi4StreamSlave(dut.io.o, dut.clockDomain)
    val axilite_master = AxiLite4Master(dut.io.axilite, dut.clockDomain)
    dut.clockDomain.forkStimulus(period = 10)
    dut.clockDomain.forkSimSpeedPrinter()
    dut.clockDomain.assertReset()

    waitUntil(dut.clockDomain.resetSim.toBoolean != (dut.clockDomain.config.resetActiveLevel == HIGH))

    def int2ByteList(x: Int): List[Byte] = {
      val arr = BigInt(x).toByteArray
      if (arr.length < 4) return (arr ++ (0 until 4 - arr.length).map(_ => 0.toByte)).toList
      return arr.slice(0, 4).toList
    }

    dut.io.axilite.w.strb #= 0xF
    axilite_master.write(0x080, int2ByteList(1))   // low threshold
    dut.io.axilite.w.strb #= 0xF
    axilite_master.write(0x084, int2ByteList(64))   // high threshold
    dut.io.axilite.w.strb #= 0xF
    axilite_master.write(0x100, int2ByteList(127))

    val thread_send = fork {
      var sent = 0
      (0 until 1026 * 1024 / 256).foreach { x =>
        val data = List.fill(256)(simRandom.nextInt(256).toByte)
        stream_master.send(data)
        sent += data.length
        print(s"send: $sent / ${1026 * 1024}\n")
      }
    }
    val thread_recv = fork {
      var received = 0
      while (received < 1026 * 1024) {
        received += stream_slave.recv().length
        print(s"recv: $received / ${1026 * 1024}\n")
      }
    }

    thread_recv.join()
    thread_send.join()
  }
}
