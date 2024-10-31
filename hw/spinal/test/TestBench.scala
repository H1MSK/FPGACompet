package test

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config}
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4StreamConfig
import project.Config
import adaptors.AxiStreamWidthAdaptorI8O32
import adaptors.AxiStreamWidthAdaptorI32O8
import _root_.axi_lite_regs.AxiLiteRegs

case class TestBench(config: Config) extends Component {
  val io = new Bundle {
    val axilite = slave(
      AxiLite4(
        AxiLite4Config(
          addressWidth = config.axiLiteAddrWidth,
          dataWidth = config.axiLiteDataWidth
        )
      )
    )
    val i = slave(Axi4Stream(Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true)))
    val o = master(Axi4Stream(Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true)))
  }

  val down = AxiStreamWidthAdaptorI32O8()
  val regs = AxiLiteRegs(config)
  val ip = TopBlackbox()
  val up = AxiStreamWidthAdaptorI8O32()
  io.i >> down.io.i
  down.io.o >> ip.io.in_axis
  ip.io.out_axis >> up.io.i
  up.io.o >> io.o

  io.axilite >> regs.io.axilite
  (regs.io.out_coeff zip ip.io.in_coeff) foreach { case (a, b) => b := a }
  // ip.io.in_coeff_00 := regs.io.out_coeff(0)
  (regs.io.out_thres zip ip.io.in_thres) foreach { case (a, b) => b := a }

  regs.io.in_ip_output_last := ip.io.out_axis.last
  regs.io.in_ip_output_ready := ip.io.out_axis.ready
  regs.io.in_ip_output_valid := ip.io.out_axis.valid
}