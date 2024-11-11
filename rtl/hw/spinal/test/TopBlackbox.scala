package test

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4StreamConfig
import spinal.lib.bus.amba4.axis.Axi4StreamWidthAdapter

case class TopBlackbox() extends BlackBox {
  val io = new Bundle {
    val clk = in Bool()
    val rst_n = in Bool()
    val in_axis = slave(Axi4Stream(Axi4StreamConfig(dataWidth = 1, useKeep = true, useLast = true)))
    val in_coeff = in(Vec(UInt(8 bits), 6))
    val in_thres = in(Vec(UInt(8 bits), 2))
    val out_axis = master(Axi4Stream(Axi4StreamConfig(dataWidth = 1, useKeep = true, useLast = true)))
  }
  noIoPrefix()
  mapCurrentClockDomain(io.clk, io.rst_n, resetActiveLevel = LOW)

  io.in_axis.data.setName("axi_data_in")
  io.in_axis.keep.setName("axi_keep")
  io.in_axis.last.setName("axi_last")
  io.in_axis.valid.setName("axi_valid")
  io.out_axis.ready.setName("dualth_axi_ready")

  io.in_coeff(0).setName("coe_00_in")
  io.in_coeff(1).setName("coe_01_in")
  io.in_coeff(2).setName("coe_02_in")
  io.in_coeff(3).setName("coe_11_in")
  io.in_coeff(4).setName("coe_12_in")
  io.in_coeff(5).setName("coe_22_in")

  io.in_thres(0).setName("gtl")
  io.in_thres(1).setName("gth")

  io.in_axis.ready.setName("gauss_axi_ready")
  io.out_axis.data.setName("dualth_axi_dout")
  io.out_axis.valid.setName("dualth_axi_valid")
  io.out_axis.last.setName("dualth_axi_last")
  io.out_axis.keep.setName("dualth_axi_keep")

  // addRTLPath("hw/verilog/top_core.v")
  // addRTLPath("hw/verilog/dualth.v")
  // addRTLPath("hw/verilog/gauss.v")
  // addRTLPath("hw/verilog/grad.v")
  // addRTLPath("hw/verilog/nms.v")
  // addRTLPath("hw/verilog/rams.v")

  setBlackBoxName("top_core")
}
