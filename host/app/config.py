from qfluentwidgets import *

class Config(QConfig):
  """ 应用配置 """
  addr = ConfigItem("net", "host", "192.168.15.134")
  port = RangeConfigItem("net", "port", 10240, RangeValidator(1, 65535))
  
  threshold_low = RangeConfigItem("threshold", "low", 8, RangeValidator(0, 255))
  threshold_high = RangeConfigItem("threshold", "high", 64, RangeValidator(0, 255))
  
  kernel_00 = RangeConfigItem("kernel", "00", 1.0, RangeValidator(0.0, 1.0))
  kernel_01 = RangeConfigItem("kernel", "01", 1.0, RangeValidator(0.0, 1.0))
  kernel_02 = RangeConfigItem("kernel", "02", 1.0, RangeValidator(0.0, 1.0))
  kernel_11 = RangeConfigItem("kernel", "11", 1.0, RangeValidator(0.0, 1.0))
  kernel_12 = RangeConfigItem("kernel", "12", 1.0, RangeValidator(0.0, 1.0))
  kernel_22 = RangeConfigItem("kernel", "22", 1.0, RangeValidator(0.0, 1.0))
  
config = Config()
qconfig.load('config/config.json', config)
