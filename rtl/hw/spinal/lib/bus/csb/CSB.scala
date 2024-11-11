package lib.bus.csb

import spinal.core._
import spinal.lib._

case class CSB(config: CSBConfig) extends Bundle with IMasterSlave {
  val req: Stream[CSBRequest] = Stream(CSBRequest(config))
  val resp: Flow[CSBResponse] = Flow(CSBResponse(config))

  override def asMaster(): Unit = {
    master(req)
    slave(resp)
  }
}
