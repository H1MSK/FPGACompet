package adaptors

import spinal.core._
import spinal.lib._
import lib.utils.XilinxBusTagger
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4StreamConfig
import spinal.lib.bus.amba4.axis.Axi4StreamWidthAdapter

case class FakeTop() extends Component {
  val io = new Bundle {
    val i = slave(Axi4Stream(Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true)))
    val o = master(Axi4Stream(Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true)))
  }

  val mid = Axi4Stream(Axi4StreamConfig(dataWidth = 1, useKeep = true, useLast = true))

  val down = AxiStreamWidthAdaptorI32O8()
  val up = AxiStreamWidthAdaptorI8O32()

  io.i >> down.io.i
  down.io.o >> mid
  mid >> up.io.i
  up.io.o >> io.o
}