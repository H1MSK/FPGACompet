package lib.bus.csb

import spinal.core._
import spinal.lib._

case class CSBResponse(config: CSBConfig) extends Bundle with IMasterSlave {
  val rdata = Bits(config.dataWidth bits)

  override def asMaster(): Unit = {
    out(rdata)
  }
}
