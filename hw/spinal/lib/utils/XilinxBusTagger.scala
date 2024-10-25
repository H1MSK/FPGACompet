package lib.utils

import spinal.core._
import spinal.lib.DataCarrier.toImplicit
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite._
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream
import bus.bram.BRAM

import scala.reflect.{ClassTag, classTag}

object XilinxBusTagger {
  private def createSetter(interface_type: String, interface_name: String): (SpinalTagReady, String) => Unit =
    (port: SpinalTagReady, name: String) =>
      port.addAttribute("X_INTERFACE_INFO", s"$interface_type $interface_name $name")
  def tagAxi4Stream(axis: Axi4Stream, interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:axis:1.0", interface_name)
    set(axis.valid, "TVALID")
    set(axis.ready, "TREADY")
    set(axis.data, "TDATA")
    if (axis.config.useId)
      set(axis.id, "TID")
    if (axis.config.useDest)
      set(axis.dest, "TDEST")
    if (axis.config.useStrb)
      set(axis.strb, "TSTRB")
    if (axis.config.useKeep)
      set(axis.keep, "TKEEP")
    if (axis.config.useLast)
      set(axis.last, "TLAST")
    if (axis.config.useUser)
      set(axis.user, "TUSER")
  }

  def tagAxi4AwStream(aw: Stream[Axi4Aw], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(aw.ready, "AWREADY")
    set(aw.valid, "AWVALID")
    set(aw.addr, "AWADDR")
    if (aw.config.useId)
      set(aw.id, "AWID")
    if (aw.config.useLen)
      set(aw.len, "AWLEN")
    if (aw.config.useSize)
      set(aw.size, "AWSIZE")
    if (aw.config.useBurst)
      set(aw.burst, "AWBURST")
    if (aw.config.useLock)
      set(aw.lock, "AWLOCK")
    if (aw.config.useCache)
      set(aw.cache, "AWCACHE")
    if (aw.config.useProt)
      set(aw.prot, "AWPROT")
    if (aw.config.useRegion)
      set(aw.region, "AWREGION")
    if (aw.config.useQos)
      set(aw.qos, "AWQOS")
    if (aw.config.useAwUser)
      set(aw.user, "AWUSER")
  }
  def tagAxi4WStream(w: Stream[Axi4W], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(w.ready, "WREADY")
    set(w.valid, "WVALID")
    set(w.data, "WDATA")
    if (w.config.useLast)
      set(w.last, "WLAST")
    if (w.config.useStrb)
      set(w.strb, "WSTRB")
    if (w.config.useWUser)
      set(w.user, "WUSER")
  }
  def tagAxi4BStream(b: Stream[Axi4B], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(b.ready, "BREADY")
    set(b.valid, "BVALID")
    if (b.config.useResp)
      set(b.resp, "BRESP")
    if (b.config.useId)
      set(b.id, "BID")
    if (b.config.useBUser)
      set(b.user, "BUSER")
  }
  def tagAxi4ArStream(ar: Stream[Axi4Ar], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(ar.ready, "ARREADY")
    set(ar.valid, "ARVALID")
    set(ar.addr, "ARADDR")
    if (ar.config.useId)
      set(ar.id, "ARID")
    if (ar.config.useLen)
      set(ar.len, "ARLEN")
    if (ar.config.useSize)
      set(ar.size, "ARSIZE")
    if (ar.config.useBurst)
      set(ar.burst, "ARBURST")
    if (ar.config.useLock)
      set(ar.lock, "ARLOCK")
    if (ar.config.useCache)
      set(ar.cache, "ARCACHE")
    if (ar.config.useProt)
      set(ar.prot, "ARPROT")
    if (ar.config.useRegion)
      set(ar.region, "ARREGION")
    if (ar.config.useQos)
      set(ar.qos, "ARQOS")
    if (ar.config.useAwUser)
      set(ar.user, "ARUSER")
  }
  def tagAxi4RStream(r: Stream[Axi4R], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(r.ready, "RREADY")
    set(r.valid, "RVALID")
    set(r.data, "RDATA")
    if (r.config.useId)
      set(r.id, "RID")
    if (r.config.useLast)
      set(r.last, "RLAST")
    if (r.config.useResp)
      set(r.resp, "RRESP")
    if (r.config.useRUser)
      set(r.user, "RUSER")
  }
  def tagAxi4(axi4: Axi4, interface_name: String): Unit = {
    tagAxi4AwStream(axi4.aw, interface_name)
    tagAxi4WStream(axi4.w, interface_name)
    tagAxi4BStream(axi4.b, interface_name)
    tagAxi4ArStream(axi4.ar, interface_name)
    tagAxi4RStream(axi4.r, interface_name)
  }
  def tagAxi4ReadOnly(axi4: Axi4ReadOnly, interface_name: String): Unit = {
    tagAxi4ArStream(axi4.ar, interface_name)
    tagAxi4RStream(axi4.r, interface_name)
  }
  def tagAxi4WriteOnly(axi4: Axi4WriteOnly, interface_name: String): Unit = {
    tagAxi4AwStream(axi4.aw, interface_name)
    tagAxi4WStream(axi4.w, interface_name)
    tagAxi4BStream(axi4.b, interface_name)
  }

  def tagAxiLite4AwStream(aw: Stream[AxiLite4Ax], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(aw.ready, "AWREADY")
    set(aw.valid, "AWVALID")
    set(aw.addr, "AWADDR")
    set(aw.prot, "AWPROT")
  }
  def tagAxiLite4WStream(w: Stream[AxiLite4W], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(w.ready, "WREADY")
    set(w.valid, "WVALID")
    set(w.data, "WDATA")
    set(w.strb, "WSTRB")
  }
  def tagAxiLite4BStream(b: Stream[AxiLite4B], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(b.ready, "BREADY")
    set(b.valid, "BVALID")
    set(b.resp, "BRESP")
  }
  def tagAxiLite4ArStream(ar: Stream[AxiLite4Ax], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(ar.ready, "ARREADY")
    set(ar.valid, "ARVALID")
    set(ar.addr, "ARADDR")
    set(ar.prot, "ARPROT")
  }
  def tagAxiLite4RStream(r: Stream[AxiLite4R], interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:aximm:1.0", interface_name)
    set(r.ready, "RREADY")
    set(r.valid, "RVALID")
    set(r.data, "RDATA")
    set(r.resp, "RRESP")
  }
  def tagAxiLite4(axilite: AxiLite4, interface_name: String): Unit = {
    tagAxiLite4AwStream(axilite.aw, interface_name)
    tagAxiLite4WStream(axilite.w, interface_name)
    tagAxiLite4BStream(axilite.b, interface_name)
    tagAxiLite4ArStream(axilite.ar, interface_name)
    tagAxiLite4RStream(axilite.r, interface_name)
  }
  def tagAxiLite4ReadOnly(axilite: AxiLite4ReadOnly, interface_name: String): Unit = {
    tagAxiLite4ArStream(axilite.ar, interface_name)
    tagAxiLite4RStream(axilite.r, interface_name)
  }
  def tagAxiLite4WriteOnly(axilite: AxiLite4WriteOnly, interface_name: String): Unit = {
    tagAxiLite4AwStream(axilite.aw, interface_name)
    tagAxiLite4WStream(axilite.w, interface_name)
    tagAxiLite4BStream(axilite.b, interface_name)
  }

  def tagBRAM(bram: BRAM, interface_name: String): Unit = {
    val set = createSetter("xilinx.com:interface:bram:1.0", interface_name)
    set(bram.en, "EN")
    set(bram.addr, "ADDR")
    set(bram.we, "WE")
    set(bram.wrdata, "DIN")
    set(bram.rddata, "DOUT")
  }

  def tag[T <: Bundle](bus: T, interface_name: String)(implicit class_tag: ClassTag[T]): Unit = {
    bus match {
      case stream: Axi4Stream if class_tag == classTag[Axi4Stream] => tagAxi4Stream(stream, interface_name)

      case axi4: Axi4 if class_tag == classTag[Axi4] => tagAxi4(axi4, interface_name)
      case axi4ReadOnly: Axi4ReadOnly if class_tag == classTag[Axi4ReadOnly] =>
        tagAxi4ReadOnly(axi4ReadOnly, interface_name)
      case axi4WriteOnly: Axi4WriteOnly if class_tag == classTag[Axi4WriteOnly] =>
        tagAxi4WriteOnly(axi4WriteOnly, interface_name)
      case aw: Stream[Axi4Aw] if class_tag == classTag[Stream[Axi4Aw]] => tagAxi4AwStream(aw, interface_name)
      case w: Stream[Axi4W] if class_tag == classTag[Stream[Axi4W]]    => tagAxi4WStream(w, interface_name)
      case b: Stream[Axi4B] if class_tag == classTag[Stream[Axi4B]]    => tagAxi4BStream(b, interface_name)
      case ar: Stream[Axi4Ar] if class_tag == classTag[Stream[Axi4Ar]] => tagAxi4ArStream(ar, interface_name)
      case r: Stream[Axi4R] if class_tag == classTag[Stream[Axi4R]]    => tagAxi4RStream(r, interface_name)

      case axilite4: AxiLite4 if class_tag == classTag[AxiLite4] => tagAxiLite4(axilite4, interface_name)
      case axiLite4ReadOnly: AxiLite4ReadOnly if class_tag == classTag[AxiLite4ReadOnly] =>
        tagAxiLite4ReadOnly(axiLite4ReadOnly, interface_name)
      case axiLite4WriteOnly: AxiLite4WriteOnly if class_tag == classTag[AxiLite4WriteOnly] =>
        tagAxiLite4WriteOnly(axiLite4WriteOnly, interface_name)
      // both AR and AR are of type AxiLiteAx, and cannot be distinguished
      // case ar: Stream[AxiLite4Ar] if class_tag == classTag[Stream[AxiLite4Ar]] => tagAxiLite4ArStream(ar, interface_name)
      // case aw: Stream[AxiLite4Aw] if class_tag == classTag[Stream[AxiLite4Aw]] => tagAxiLite4AwStream(aw, interface_name)
      case w: Stream[AxiLite4W] if class_tag == classTag[Stream[AxiLite4W]] => tagAxiLite4WStream(w, interface_name)
      case b: Stream[AxiLite4B] if class_tag == classTag[Stream[AxiLite4B]] => tagAxiLite4BStream(b, interface_name)
      case r: Stream[AxiLite4R] if class_tag == classTag[Stream[AxiLite4R]] => tagAxiLite4RStream(r, interface_name)

      case bram: BRAM if class_tag == classTag[BRAM] => tagBRAM(bram, interface_name)
    }
  }
}