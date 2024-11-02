import math
from constant import *


from qfluentwidgets import QConfig, Signal, ConfigItem, RangeConfigItem, RangeValidator, qconfig
from PySide6.QtCore import Slot


class Config(QConfig):
    """应用配置"""

    kernelChanged = Signal()
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

    def __init__(self):
        super().__init__()
        self.kernel_00.valueChanged.connect(self.kernelChanged)
        self.kernel_01.valueChanged.connect(self.kernelChanged)
        self.kernel_02.valueChanged.connect(self.kernelChanged)
        self.kernel_11.valueChanged.connect(self.kernelChanged)
        self.kernel_12.valueChanged.connect(self.kernelChanged)
        self.kernel_22.valueChanged.connect(self.kernelChanged)

    def applyKernelObject(self, data):
        from app.objects.kernel_object import KernelObject

        data: KernelObject = data
        self.kernel_00.value = data.kernel_00
        self.kernel_01.value = data.kernel_01
        self.kernel_02.value = data.kernel_02
        self.kernel_11.value = data.kernel_11
        self.kernel_12.value = data.kernel_12
        self.kernel_22.value = data.kernel_22

    @Slot()
    def upload(self):
        import web_client
        assert web_client.connected()
        
        def quantize(x):
            return math.floor(x * 256)
        web_client.write_arg(ADDR_KERNEL_00, quantize(self.kernel_00.value))
        web_client.write_arg(ADDR_KERNEL_01, quantize(self.kernel_01.value))
        web_client.write_arg(ADDR_KERNEL_02, quantize(self.kernel_02.value))
        web_client.write_arg(ADDR_KERNEL_11, quantize(self.kernel_11.value))
        web_client.write_arg(ADDR_KERNEL_12, quantize(self.kernel_12.value))
        web_client.write_arg(ADDR_KERNEL_22, quantize(self.kernel_22.value))
        web_client.write_arg(ADDR_THRESHOLD_LOW, self.threshold_low.value)
        web_client.write_arg(ADDR_THRESHOLD_HIGH, self.threshold_high.value)
        
    @Slot()
    def download(self):
        import web_client
        assert web_client.connected()
        
        def dequantize(x):
            return x / 256
        self.threshold_low.value = web_client.read_arg(ADDR_THRESHOLD_LOW)
        self.threshold_high.value = web_client.read_arg(ADDR_THRESHOLD_HIGH)
        self.kernel_00.value = dequantize(web_client.read_arg(ADDR_KERNEL_00))
        self.kernel_01.value = dequantize(web_client.read_arg(ADDR_KERNEL_01))
        self.kernel_02.value = dequantize(web_client.read_arg(ADDR_KERNEL_02))
        self.kernel_11.value = dequantize(web_client.read_arg(ADDR_KERNEL_11))
        self.kernel_12.value = dequantize(web_client.read_arg(ADDR_KERNEL_12))
        self.kernel_22.value = dequantize(web_client.read_arg(ADDR_KERNEL_22))

app_cfg = Config()
qconfig.load("config/config.json", app_cfg)


@Slot()
def _guardThresholdLow(high_value):
    if app_cfg.threshold_low.value >= high_value:
        app_cfg.threshold_low.value = high_value


@Slot()
def _guardThresholdHigh(low_value):
    if app_cfg.threshold_high.value <= low_value:
        app_cfg.threshold_high.value = low_value


app_cfg.threshold_high.valueChanged.connect(_guardThresholdLow)
app_cfg.threshold_low.valueChanged.connect(_guardThresholdHigh)
