package besspin.chisel

import java.io.FileOutputStream
import scala.reflect.{classTag, ClassTag}
import firrtl.ir._
import firrtl.{
  CDefMemory, CDefMPort, MPortDir,
  MInfer, MRead, MWrite, MReadWrite,
}
import firrtl.Parser
import io.bullet.borer.{Cbor, Encoder, Writer}

// Fallback, used when an abstract type's encoder can't find a concrete type to
// dispatch to.
case class DispatchError[T](obj: T)

case class EncodeEmpty[T](obj: T)

object Exporter {
  def main(args: Array[String]) {
    if (args.length != 2) {
      println("usage: firrtl-exporter <in.fir> <out.cbor>")
      System.exit(1)
    }

    // TODO: load annotation json to get source locations?
    val circ = Parser.parseFile(args(0), Parser.UseInfo)
    val bs = Cbor.encode(circ).toByteArray

    val out = new FileOutputStream(args(1))
    out.write(bs)
  }

  def listWrapped[T: ClassTag](e: Encoder[T]) : Encoder[T] =
    Encoder((w, x) => {
      w.writeArrayStart
      w.writeString(classTag[T].runtimeClass.getName)
      e.write(w, x)
      w.writeBreak
    })

  implicit def encodeDispatchError[T: ClassTag]: Encoder[DispatchError[T]] =
    listWrapped((w, x) => w ~ x.obj.getClass.getName)

  implicit def encodeEmpty[T: ClassTag]: Encoder[EncodeEmpty[T]] =
    Encoder((w, _) => {
      w.writeArrayStart
      w.writeString(classTag[T].runtimeClass.getName)
      w.writeBreak
    })

  implicit val encodeCircuit: Encoder[Circuit] =
    listWrapped((w, x) => w ~ x.info ~ x.modules ~ x.main)

  implicit val encodeDefModule: Encoder[DefModule] =
    Encoder((w, x) => x match {
      case x: Module => w ~ x
      case x: ExtModule => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeModule: Encoder[Module] =
    listWrapped((w, x) => {
      println("exporting module " + x.name)
      w ~ x.info ~ x.name ~ x.ports ~ x.body
    })

  implicit val encodeExtModule: Encoder[ExtModule] =
    listWrapped((w, x) => {
      println("exporting external module " + x.name)
      w ~ x.info ~ x.name ~ x.ports ~ x.defname
    })

  implicit val encodePort: Encoder[Port] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.direction ~ x.tpe)

  implicit val encodeDirection: Encoder[Direction] =
    Encoder((w, x) => x match {
      case x @ Input => w ~ EncodeEmpty(x)
      case x @ Output => w ~ EncodeEmpty(x)
      case x => w ~ DispatchError(x)
    })


  implicit val encodeInfo: Encoder[Info] =
    Encoder((w, x) => x match {
      case x @ NoInfo => w ~ EncodeEmpty(x)
      case x: FileInfo => w ~ x
      case x: MultiInfo => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeFileInfo: Encoder[FileInfo] =
    listWrapped((w, x) => w ~ x.info.string)

  implicit val encodeMultiInfo: Encoder[MultiInfo] =
    listWrapped((w, x) => w ~ x.infos)


  implicit val encodeType: Encoder[Type] =
    Encoder((w, x) => x match {
      case x: GroundType => w ~ x
      case x: AggregateType => w ~ x
      case x @ UnknownType => w ~ EncodeEmpty(x)
      case x => w ~ DispatchError(x)
    })

  implicit val encodeGroundType: Encoder[GroundType] =
    Encoder((w, x) => x match {
      case x: UIntType => w ~ x
      case x: SIntType => w ~ x
      case x: FixedType => w ~ x
      case x @ ClockType => w ~ EncodeEmpty(x)
      case x: AnalogType => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeUIntType: Encoder[UIntType] =
    listWrapped((w, x) => w ~ x.width)

  implicit val encodeSIntType: Encoder[SIntType] =
    listWrapped((w, x) => w ~ x.width)

  implicit val encodeFixedType: Encoder[FixedType] =
    listWrapped((w, x) => w ~ x.width ~ x.point)

  implicit val encodeAnalogType: Encoder[AnalogType] =
    listWrapped((w, x) => w ~ x.width)

  implicit val encodeWidth: Encoder[Width] =
    Encoder((w, x) => x match {
      case x: IntWidth => w ~ x
      case x @ UnknownWidth => w ~ EncodeEmpty(x)
      case x => w ~ DispatchError(x)
    })

  implicit val encodeIntWidth: Encoder[IntWidth] =
    listWrapped((w, x) => w ~ x.width)

  implicit val encodeAggregateType: Encoder[AggregateType] =
    Encoder((w, x) => x match {
      case x: BundleType => w ~ x
      case x: VectorType => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeBundleType: Encoder[BundleType] =
    listWrapped((w, x) => w ~ x.fields)

  implicit val encodeVectorType: Encoder[VectorType] =
    listWrapped((w, x) => w ~ x.tpe ~ x.size)

  implicit val encodeField: Encoder[Field] =
    listWrapped((w, x) => w ~ x.name ~ x.flip ~ x.tpe)

  implicit val encodeOrientation: Encoder[Orientation] =
    Encoder((w, x) => x match {
      case x @ Default => w ~ EncodeEmpty(x)
      case x @ Flip => w ~ EncodeEmpty(x)
      case x => w ~ DispatchError(x)
    })


  implicit val encodeStatement: Encoder[Statement] =
    Encoder((w, x) => x match {
      case x: DefWire => w ~ x
      case x: DefRegister => w ~ x
      case x: DefInstance => w ~ x
      case x: DefMemory => w ~ x
      case x: DefNode => w ~ x
      case x: Conditionally => w ~ x
      case x: Block => w ~ x
      case x: PartialConnect => w ~ x
      case x: Connect => w ~ x
      case x: IsInvalid => w ~ x
      case x: Attach => w ~ x
      case x: Stop => w ~ x
      case x: Print => w ~ x
      case x @ EmptyStmt => w ~ EncodeEmpty(x)
      case x: CDefMemory => w ~ x
      case x: CDefMPort => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeDefWire: Encoder[DefWire] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.tpe)

  implicit val encodeDefRegister: Encoder[DefRegister] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.tpe ~ x.clock ~ x.reset ~ x.init)

  implicit val encodeDefInstance: Encoder[DefInstance] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.module)

  implicit val encodeDefMemory: Encoder[DefMemory] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.dataType ~ x.depth
      ~ x.readers ~ x.writers ~ x.readwriters)

  implicit val encodeDefNode: Encoder[DefNode] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.value)

  implicit val encodeConditionally: Encoder[Conditionally] =
    listWrapped((w, x) => w ~ x.info ~ x.pred ~ x.conseq ~ x.alt)

  implicit val encodeBlock: Encoder[Block] =
    listWrapped((w, x) => w ~ x.stmts)

  implicit val encodePartialConnect: Encoder[PartialConnect] =
    listWrapped((w, x) => w ~ x.info ~ x.loc ~ x.expr)

  implicit val encodeConnect: Encoder[Connect] =
    listWrapped((w, x) => w ~ x.info ~ x.loc ~ x.expr)

  implicit val encodeIsInvalid: Encoder[IsInvalid] =
    listWrapped((w, x) => w ~ x.info ~ x.expr)

  implicit val encodeAttach: Encoder[Attach] =
    listWrapped((w, x) => w ~ x.info ~ x.exprs)

  implicit val encodeStop: Encoder[Stop] =
    listWrapped((w, x) => w ~ x.info ~ x.ret ~ x.clk ~ x.en)

  implicit val encodePrint: Encoder[Print] =
    listWrapped((w, x) => w ~ x.info ~ x.string.string ~ x.args ~ x.clk ~ x.en)

  implicit val encodeCDefMemory: Encoder[CDefMemory] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.tpe ~ x.size ~ x.seq)

  implicit val encodeCDefMPort: Encoder[CDefMPort] =
    listWrapped((w, x) => w ~ x.info ~ x.name ~ x.tpe ~ x.mem ~ x.exps ~ x.direction)

  implicit val encodeMPortDir: Encoder[MPortDir] =
    Encoder((w, x) => x match {
      case x @ MInfer => w ~ EncodeEmpty(x)
      case x @ MRead => w ~ EncodeEmpty(x)
      case x @ MWrite => w ~ EncodeEmpty(x)
      case x @ MReadWrite => w ~ EncodeEmpty(x)
      case x => w ~ DispatchError(x)
    })


  implicit val encodeExpression: Encoder[Expression] =
    Encoder((w, x) => x match {
      case x: Reference => w ~ x
      case x: SubField => w ~ x
      case x: SubIndex => w ~ x
      case x: SubAccess => w ~ x
      case x: Mux => w ~ x
      case x: ValidIf => w ~ x
      case x: Literal => w ~ x
      case x: DoPrim => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeReference: Encoder[Reference] =
    listWrapped((w, x) => w ~ x.name ~ x.tpe)

  implicit val encodeSubField: Encoder[SubField] =
    listWrapped((w, x) => w ~ x.expr ~ x.name ~ x.tpe)

  implicit val encodeSubIndex: Encoder[SubIndex] =
    listWrapped((w, x) => w ~ x.expr ~ x.value ~ x.tpe)

  implicit val encodeSubAccess: Encoder[SubAccess] =
    listWrapped((w, x) => w ~ x.expr ~ x.index ~ x.tpe)

  implicit val encodeMux: Encoder[Mux] =
    listWrapped((w, x) => w ~ x.cond ~ x.tval ~ x.fval ~ x.tpe)

  implicit val encodeValidIf: Encoder[ValidIf] =
    listWrapped((w, x) => w ~ x.cond ~ x.value ~ x.tpe)

  implicit val encodeDoPrim: Encoder[DoPrim] =
    listWrapped((w, x) => w ~ x.op.toString ~ x.args ~ x.consts ~ x.tpe)


  implicit val encodeLiteral: Encoder[Literal] =
    // NB: Literals are `listWrapped`, to let us separate literal cases from
    // general expr cases in the parser.
    listWrapped((w, x) => x match {
      case x: UIntLiteral => w ~ x
      case x: SIntLiteral => w ~ x
      case x: FixedLiteral => w ~ x
      case x => w ~ DispatchError(x)
    })

  implicit val encodeUIntLiteral: Encoder[UIntLiteral] =
    listWrapped((w, x) => w ~ x.value ~ x.width)

  implicit val encodeSIntLiteral: Encoder[SIntLiteral] =
    listWrapped((w, x) => w ~ x.value ~ x.width)

  implicit val encodeFixedLiteral: Encoder[FixedLiteral] =
    listWrapped((w, x) => w ~ x.value ~ x.width ~ x.point)

}
