package lib.bus.regif

import spinal.core._
import spinal.lib._
import lib.bus.csb.CSB
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.bus.regif.{BusIf, ClassName}

case class CSBBusInterface(bus: CSB, sizeMap: SizeMapping, regPre: String = "", withSecFireWall: Boolean = false)(implicit moduleName: ClassName) extends BusIf {
  override val busDataWidth: Int = bus.config.dataWidth
  override val busAddrWidth: Int = bus.config.addressWidth
  override val withStrb: Boolean = false

  val bus_rderr: Bool = Bool()
  val bus_rdata: Bits = Bits(busDataWidth bits)
  val reg_rderr: Bool = Reg(Bool(), init = False)
  val reg_rdata: Bits = Reg(Bits(busDataWidth bits), init = defualtReadBits)

  val wstrb: Bits = null.asInstanceOf[Bits]
  val wmask: Bits = null.asInstanceOf[Bits]
  val wmaskn: Bits = null.asInstanceOf[Bits]
  def getModuleName: String = moduleName.name

  val askWrite = bus.req.valid && bus.req.wr
  val askRead: Bool = bus.req.valid && !bus.req.wr
  val doWrite: Bool = askWrite && bus.req.ready
  val doRead: Bool = askRead && bus.req.ready
  val writeData: Bits = bus.req.wdata

  bus.req.ready := bus.req.valid

  bus.resp.valid := RegNext(doRead || doWrite, False)
  bus.resp.rdata := readData

  def readAddress(): UInt = bus.req.addr
  def writeAddress(): UInt = bus.req.addr

  def readHalt(): Unit = doRead := False
  def writeHalt(): Unit = doWrite := False
}
