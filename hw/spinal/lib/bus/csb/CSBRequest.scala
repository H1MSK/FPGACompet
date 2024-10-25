package lib.bus.csb

import spinal.core._
import spinal.lib._

case class CSBRequest(config: CSBConfig) extends Bundle with IMasterSlave {
  val addr = UInt(config.addressWidth bits)
  val wdata = Bits(config.dataWidth bits)
  val wr = Bool()

  override def asMaster(): Unit = {
    out(addr, wdata, wr)
  }
}
