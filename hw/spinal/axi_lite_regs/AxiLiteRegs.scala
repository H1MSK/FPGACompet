package axi_lite_regs

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config}
import spinal.lib.bus.regif.{AxiLite4BusInterface, AccessType}
import spinal.lib.bus.regif.{CHeaderGenerator, HtmlGenerator}
import spinal.lib.bus.misc.SizeMapping
import lib.bus.csb.CSB
import lib.bus.csb.CSBConfig
import lib.adaptor.AxiLite2CSB
import lib.bus.regif.CSBBusInterface


// Hardware definition
case class AxiLiteRegs(config: Config) extends Component {
  val io = new Bundle {
    val axilite = slave(
      AxiLite4(
        AxiLite4Config(
          addressWidth = config.axiLiteAddrWidth,
          dataWidth = config.axiLiteDataWidth
        )
      )
    )

    val in_ip_output_valid = in Bool ()
    val in_ip_output_ready = in Bool ()
    val in_ip_output_last = in Bool ()

    val out_busy = out Bool ()
    val out_coeff = out(Vec(UInt(config.blurCoeffWidth bits), config.blurCoeffCount))
    val out_thres = out Vec (UInt(config.thresholdWidth bits), 2)
  }

  noIoPrefix()

  val csb = CSB(CSBConfig(config.axiLiteAddrWidth, config.axiLiteDataWidth))

  val adaptor = AxiLite2CSB(io.axilite,csb)

  val busif = new CSBBusInterface(
    csb,
    (0x0000, 1 KiB)
  )

  val G_BASE = busif.newGrp(16 Bytes, "Basic control registers")

  val M_CTRL = G_BASE.newReg("ctrl")
  val f_start = M_CTRL.field(Bool(), AccessType.WS, 0, "write 1 to start processing image")
  val last_start = RegNext(f_start, init=False)
  val just_start = f_start && !last_start

  val M_STAT = G_BASE.newReg("stat")
  val f_done = M_STAT.field(Bool(), AccessType.RC, 0, "read 1 when done")

  val G_PARAM = busif.newGrpAt(0x80, 128 Bytes, "Algorithm parameter registers")
  val M_THRES = Array.tabulate(2)(i => G_PARAM.newRegAt(i * 4, s"thres_$i").setName(s"M_THRES_$i"))
  val f_thres = M_THRES.zipWithIndex.map { case (f, i) =>
    f.field(UInt(config.thresholdWidth bits), AccessType.RW, 0, s"threshold #$i field").setName(s"f_thres_$i")
  }
  (f_thres zip io.out_thres) foreach { case (reg, out) => out := reg }

  val G_COEFF = busif.newGrpAt(0x100, 256 Bytes, "Coefficient registers")
  val M_COEFF = Array.tabulate(config.blurCoeffCount)(i => G_COEFF.newRegAt(i * 4, s"coeff_$i").setName(s"M_COEFF_$i"))
  val f_coeff = M_COEFF.zipWithIndex.map { case (f, i) =>
    f.field(UInt(8 bits), AccessType.RW, 0, s"coefficient #$i field").setName(s"f_coeff_$i")
  }
  (f_coeff zip io.out_coeff) foreach { case (reg, out) => out := reg }

  val ip_output_fire = io.in_ip_output_valid && io.in_ip_output_ready
  val ip_output_last_fire = ip_output_fire && io.in_ip_output_last
  val reg_busy = RegInit(False) setWhen (just_start) clearWhen (ip_output_last_fire)
  val last_busy = RegNext(reg_busy, init = False)
  val busy = just_start || reg_busy
  io.out_busy := busy
  f_done setWhen(ip_output_last_fire)
  f_start clearWhen(ip_output_last_fire)

  busif.accept(CHeaderGenerator("axi_lite_regs", "IP", "uint32_t"))
  busif.accept(HtmlGenerator("axi_lite_regs", "AxiLite Registers"))
}
