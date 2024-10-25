package lib.adaptor

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config}
import lib.bus.csb.{CSB, CSBConfig}
import spinal.lib.fsm.{StateMachine, State, EntryPoint}

object AxiLite2CSB {
  def apply(axi_lite: AxiLite4, csb: CSB) = {
    val axi_lite_2_csb = new AxiLite2CSB(axi_lite.config, csb.config)
    axi_lite_2_csb.io.axi_lite <> axi_lite
    axi_lite_2_csb.io.csb <> csb
    axi_lite_2_csb
  }
}

case class AxiLite2CSB(axi_lite_config: AxiLite4Config, csb_config: CSBConfig) extends Component {
  require(axi_lite_config.dataWidth == csb_config.dataWidth)
  require(axi_lite_config.addressWidth == csb_config.addressWidth)

  val io = new Bundle {
    val axi_lite = slave(AxiLite4(axi_lite_config))
    val csb = master(CSB(csb_config))
  }

  // assert 4 byte alignment
  assert(!io.axi_lite.ar.fire || io.axi_lite.ar.addr(0, 2 bits) === U(0))
  assert(!io.axi_lite.aw.fire || io.axi_lite.aw.addr(0, 2 bits) === U(0))
  
  io.axi_lite.aw.ready := False
  val waddr = RegNextWhen(io.axi_lite.aw.addr, io.axi_lite.aw.fire)
  // TODO: if addr is not aligned to 4 bytes, how should we handle the data?
  // under current implementation, we will just ignore the error and handle as if it is aligned
  // TODO: similar to waddr
  val waddr_unaligned = RegNextWhen(io.axi_lite.ar.addr(0, 2 bits) =/= U(0), io.axi_lite.aw.fire)
  // ignore io.axi_lite.aw.prot
  io.axi_lite.w.ready := False
  val wdata = RegNextWhen(io.axi_lite.w.data, io.axi_lite.w.fire)
  // ignore io.axi_lite.w.strb

  io.axi_lite.ar.ready := False
  val raddr = RegNextWhen(io.axi_lite.ar.addr, io.axi_lite.ar.fire)
  val raddr_unaligned = RegNextWhen(io.axi_lite.ar.addr(0, 2 bits) =/= U(0), io.axi_lite.ar.fire)
  // ignore io.axi_lite.ar.prot

  io.csb.req.valid := False
  io.csb.req.wdata := wdata
  // these two need state in fsm, so they are defined in fsm
  // io.csb.req.addr := Mux(isActive(csb_send_raddr), raddr, waddr)
  // io.csb.req.wr := isActive(csb_send_wcmd)

  val rdata = RegNextWhen(io.csb.resp.rdata, io.csb.resp.valid)

  io.axi_lite.r.valid := False
  io.axi_lite.r.data := rdata
  io.axi_lite.r.resp := Mux(raddr_unaligned, AxiLite4.resp.SLVERR, AxiLite4.resp.OKAY)

  io.axi_lite.b.valid := False
  io.axi_lite.b.resp := Mux(waddr_unaligned, AxiLite4.resp.SLVERR, AxiLite4.resp.OKAY)
  // io.csb.req.payload := io.csb.req.payload.getZero

  val fsm = new StateMachine {
    val wait_axi_cmd = new State with EntryPoint

    val csb_send_raddr = new State
    val csb_wait_rdata = new State
    val axi_send_rdata = new State

    val axi_wait_wdata = new State
    val csb_send_wcmd = new State
    val csb_wait_resp = new State

    val axi_send_bresp = new State

    io.csb.req.addr := Mux(isActive(csb_send_raddr), raddr, waddr)
    io.csb.req.wr := isActive(csb_send_wcmd)

    wait_axi_cmd.whenIsActive {
      when(io.axi_lite.ar.valid) {
        io.axi_lite.ar.ready := True
        // raddr := io.axi_lite.ar.addr
        // when write the code here, CE of raddr will be (state == xxx && io.csb.resp.valid)
        // but we can set CE = io.axi_lite.ar.fire to save resource
        // this is similar for rdata/waddr/wdata
        goto(csb_send_raddr)
      }.elsewhen(io.axi_lite.aw.valid) {
        io.axi_lite.aw.ready := True
        // waddr := io.axi_lite.aw.addr
        when(io.axi_lite.w.valid) {
          io.axi_lite.w.ready := True
          // wdata := io.axi_lite.w.data
          assert(io.axi_lite.w.strb === io.axi_lite.w.strb.getAllTrue)
          goto(csb_send_wcmd)
        }.otherwise {
          goto(axi_wait_wdata)
        }
      }
    }

    csb_send_raddr.whenIsActive {
      // io.csb.req.wr := False
      io.csb.req.valid := True
      when(io.csb.req.ready) {
        when(io.csb.resp.valid) {
          // rdata := io.csb.resp.rdata
          goto(axi_send_rdata)
        }.otherwise {
          goto(csb_wait_rdata)
        }
      }
    }

    csb_wait_rdata.whenIsActive {
      when(io.csb.resp.valid) {
        // rdata := io.csb.resp.rdata
        goto(axi_send_rdata)
      }
    }

    axi_send_rdata.whenIsActive {
      io.axi_lite.r.valid := True
      when(io.axi_lite.r.ready) {
        goto(wait_axi_cmd)
      }
    }

    axi_wait_wdata.whenIsActive {
      when(io.axi_lite.w.valid) {
        io.axi_lite.w.ready := True
        goto(csb_send_wcmd)
      }
    }

    csb_send_wcmd.whenIsActive {
      io.csb.req.valid := True
      when(io.csb.req.ready) {
        when (io.csb.resp.valid) {
          goto(axi_send_bresp)
        } otherwise {
          goto(csb_wait_resp)
        }
      }
    }

    csb_wait_resp.whenIsActive {
      when(io.csb.resp.valid) {
        goto(axi_send_bresp)
      }
    }

    axi_send_bresp.whenIsActive {
      io.axi_lite.b.valid := True
      when(io.axi_lite.b.ready) {
        goto(wait_axi_cmd)
      }
    }
  }
}
