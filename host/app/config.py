from qfluentwidgets import *

class Config(QConfig):
  """ 应用配置 """
  addr = ConfigItem("net", "host", "192.168.15.134")
  port = RangeConfigItem("net", "port", 10240, RangeValidator(1, 65535))
  
config = Config()
qconfig.load('config/config.json', config)
