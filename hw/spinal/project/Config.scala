package project

case class Config(
  axiLiteAddrWidth: Int = 14,
  axiLiteDataWidth: Int = 32,

  blurCoeffWidth: Int = 8,
  blurCoeffCount: Int = 6,

  thresholdWidth: Int = 8
)