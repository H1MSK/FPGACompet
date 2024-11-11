package axi_lite_regs

import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axilite.sim.AxiLite4Master

object AxiLiteRegsSim extends App {
  def bigInt2Bytes(x: BigInt): List[Byte] = {
    val bytes = List.fill(4)(0.toByte)
    val bytes_rev = bytes.zipWithIndex.map { case (b, i) => (x >> (8 * i)) & 0xff }
    bytes_rev.map(_.toByte)
  }

  def bytes2BigInt(bytes: List[Byte]): BigInt = {
    BigInt(bytes.sliding(4, 4).map(_.reverse).flatten.toArray)
  }

  def controlTest(axilite_master: AxiLite4Master, dut: AxiLiteRegs): Unit = {
    var f_start_test_finished = false
    val randomizer = fork {
      dut.io.in_ip_output_last #= false
      while (!f_start_test_finished) {
        dut.io.in_ip_output_valid.randomize()
        dut.io.in_ip_output_ready.randomize()
        dut.clockDomain.waitSampling()
      }
      dut.io.in_ip_output_valid #= false
      dut.io.in_ip_output_ready #= false
    }

    // Test f_start

    // Default status is all 0
    dut.io.axilite.ar.prot #= 0
    axilite_master.readSingle(dut.M_STAT.addr)(bytes => {
      assert(
        bytes.length == 4 && bytes2BigInt(bytes) == 0x00,
        s"Default status is all 0, but get ${bytes2BigInt(bytes)}"
      )
    })

    waitUntil(axilite_master.idle)

    // Write f_start to enable ip
    assert(dut.io.out_busy.toBoolean == false, "out_busy should be deasserted")
    dut.io.axilite.aw.prot #= 0
    dut.io.axilite.w.strb #= (BigInt(1) << widthOf(dut.io.axilite.w.strb)) - 1
    axilite_master.writeSingle(dut.M_CTRL.addr, bigInt2Bytes(0x01)) {
      assert(dut.io.out_busy.toBoolean == true, "out_busy should be asserted")
    }

    waitUntil(axilite_master.idle)

    // status is still 0, ip is running
    assert(dut.io.out_busy.toBoolean == true, "out_busy should be asserted")
    dut.io.axilite.ar.prot #= 0
    axilite_master.readSingle(dut.M_STAT.addr)(bytes => {
      assert(bytes.length == 4 && bytes2BigInt(bytes) == 0x00, s"status should be 0, but get ${bytes2BigInt(bytes)}")
    })

    waitUntil(axilite_master.idle)

    // when ip output fired the last data, status is 1, and out_busy is deasserted
    dut.io.in_ip_output_last #= true
    dut.clockDomain.waitSamplingWhere(dut.io.in_ip_output_valid.toBoolean && dut.io.in_ip_output_ready.toBoolean)
    assert(dut.io.out_busy.toBoolean == true, "out_busy should be asserted")
    dut.io.in_ip_output_last #= false
    dut.clockDomain.waitSampling()
    assert(dut.io.out_busy.toBoolean == false, "out_busy should be deasserted")
    dut.clockDomain.waitSampling()

    // read status
    dut.io.axilite.ar.prot #= 0
    axilite_master.readSingle(dut.M_STAT.addr)(bytes => {
      assert(bytes.length == 4 && bytes2BigInt(bytes) == 1, s"Status should be 1, but get ${bytes2BigInt(bytes)}")
    })
    waitUntil(axilite_master.idle)

    // AccessMode == RC, should reset after first read
    dut.io.axilite.ar.prot #= 0
    axilite_master.readSingle(dut.M_STAT.addr)(bytes => {
      assert(bytes.length == 4 && bytes2BigInt(bytes) == 0, s"Status should be 0, but get ${bytes2BigInt(bytes)}")
    })
    waitUntil(axilite_master.idle)

    f_start_test_finished = true
    randomizer.join()
  }

  def coeffTest(axilite_master: AxiLite4Master, dut: AxiLiteRegs) = {
    (0 until 128).foreach(iter => {
      val pos = simRandom.nextInt(dut.config.blurCoeffCount)
      val dat = BigInt(simRandom.nextInt(1 << dut.config.blurCoeffWidth))

      dut.io.axilite.w.strb #= (BigInt(1) << widthOf(dut.io.axilite.w.strb)) - 1
      axilite_master.writeSingle(dut.M_COEFF(pos).addr, bigInt2Bytes(dat)) {
        assert(
          dut.io.out_coeff(pos).toInt == dat,
          s"read back failed on port, expected $dat, got ${dut.io.out_coeff(pos).toInt}"
        )
        dut.io.axilite.ar.prot #= 0
        axilite_master.readSingle(dut.M_COEFF(pos).addr) { bytes =>
          assert(
            bytes.length == 4 && bytes2BigInt(bytes) == dat,
            s"read back failed on axi, expected $dat, got ${bytes2BigInt(bytes)}"
          )
        }
      }
      waitUntil(axilite_master.idle)
    })
  }

  def thresTest(axilite_master: AxiLite4Master, dut: AxiLiteRegs) = {
    (0 until 64).foreach(iter => {
      val pos = simRandom.nextInt(2)
      val dat = BigInt(simRandom.nextInt(1 << dut.config.thresholdWidth))

      dut.io.axilite.w.strb #= (BigInt(1) << widthOf(dut.io.axilite.w.strb)) - 1
      axilite_master.writeSingle(dut.M_THRES(pos).addr, bigInt2Bytes(dat)) {
        assert(
          dut.io.out_thres(pos).toInt == dat,
          s"read back failed on port, expected $dat, got ${dut.io.out_thres(pos).toInt}"
        )
        dut.io.axilite.ar.prot #= 0
        axilite_master.readSingle(dut.M_THRES(pos).addr) { bytes =>
          assert(
            bytes.length == 4 && bytes2BigInt(bytes) == dat,
            s"read back failed on axi, expected $dat, got ${bytes2BigInt(bytes)}"
          )
        }
      }
      waitUntil(axilite_master.idle)
    })
  }

  project.ProjectConfig.sim.compile(AxiLiteRegs(project.Config())).doSim { dut =>
    val axilite_master = AxiLite4Master(dut.io.axilite, dut.clockDomain)
    dut.clockDomain.forkStimulus(period = 10)
    dut.clockDomain.forkSimSpeedPrinter()
    dut.clockDomain.assertReset()

    waitUntil(dut.clockDomain.resetSim.toBoolean != (dut.clockDomain.config.resetActiveLevel == HIGH))

    SpinalInfo("Start control test")
    controlTest(axilite_master, dut)
    SpinalInfo("Start coeff test")
    coeffTest(axilite_master, dut)
    SpinalInfo("Start thres test")
    thresTest(axilite_master, dut)
  }
}
