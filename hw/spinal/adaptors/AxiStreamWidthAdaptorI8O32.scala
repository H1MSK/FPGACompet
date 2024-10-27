package adaptors

import spinal.core._
import spinal.lib._
import lib.utils.XilinxBusTagger
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4StreamConfig
import spinal.lib.bus.amba4.axis.Axi4StreamWidthAdapter

case class AxiStreamWidthAdaptorI8O32() extends Component {
  val io = new Bundle {
    val i = slave(Axi4Stream(Axi4StreamConfig(dataWidth = 1, useKeep = true, useLast = true)))
    val o = master(Axi4Stream(Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true)))
  }

  noIoPrefix()
  XilinxBusTagger.tag(io.i, "in")
  XilinxBusTagger.tag(io.o, "out")

  Axi4StreamWidthAdapter(io.i, io.o)
}
