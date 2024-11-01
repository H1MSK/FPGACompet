from PySide6.QtCore import Qt, Slot, QTimer
from PySide6.QtWidgets import (
    QHBoxLayout, QVBoxLayout
)
from qfluentwidgets import (
    GroupHeaderCardWidget, PushButton, IconWidget,
    BodyLabel, InfoBarIcon, PrimaryPushButton, FluentIcon, SpinBox,
    InfoBar, Slider
)
from qfluentwidgets import FluentIcon as FIF
from app.config import config
from app.objects.kernel_object import KernelObject
from app.widgets.kernel_set_message_box import KernelSetMessageBox
import web_client

class ArgumentCard(GroupHeaderCardWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        
        self.kernel_data = KernelObject(self)
        # TODO: set initial data from config.kernel_xx
        
        self.setTitle("参数配置")
        self.setBorderRadius(8)

        self.hint_icon = IconWidget(InfoBarIcon.INFORMATION)
        self.hint_label = BodyLabel("配置IP参数")
        self.apply_button = PrimaryPushButton(FluentIcon.UP, "上传")
        self.discard_button = PushButton(FluentIcon.DOWNLOAD, "下载")
        self.bottom_layout = QHBoxLayout()
        
        self.threshold_low_slider = Slider(Qt.Horizontal, self)
        self.threshold_low_slider.setFixedWidth(320)
        self.threshold_low_slider.setRange(0, 255)
        self.threshold_low_slider.setValue(config.threshold_low.value)
        
        self.threshold_high_slider = Slider(Qt.Horizontal, self)
        self.threshold_high_slider.setFixedWidth(320)
        self.threshold_high_slider.setRange(0, 255)
        self.threshold_high_slider.setValue(config.threshold_high.value)
        
        self.kernel_set_button = PushButton("设置...")

        # 设置底部工具栏布局
        self.hint_icon.setFixedSize(16, 16)
        self.bottom_layout.setSpacing(10)
        self.bottom_layout.setContentsMargins(24, 15, 24, 20)
        self.bottom_layout.addWidget(self.hint_icon, 0, Qt.AlignLeft)
        self.bottom_layout.addWidget(self.hint_label, 0, Qt.AlignLeft)
        self.bottom_layout.addStretch(1)
        self.bottom_layout.addWidget(self.discard_button, 0, Qt.AlignRight)
        self.bottom_layout.addWidget(self.apply_button, 0, Qt.AlignRight)
        self.bottom_layout.setAlignment(Qt.AlignVCenter)

        # 添加组件到分组中
        self.threshold_low_group = self.addGroup(FIF.SETTING, "低阈值", str(config.threshold_low.value), self.threshold_low_slider)
        self.threshold_low_group.setSeparatorVisible(True)

        self.threshold_high_group = self.addGroup(FIF.SETTING, "高阈值", str(config.threshold_high.value), self.threshold_high_slider)
        self.threshold_high_group.setSeparatorVisible(True)
        
        self.kernel_set_group = self.addGroup(FIF.SETTING, "卷积核配置", "", self.kernel_set_button)

        # 添加底部工具栏
        self.vBoxLayout.addLayout(self.bottom_layout)

        self.threshold_low_slider.valueChanged.connect(lambda x: self.onThresholdSliderValueChanged(0, x))
        config.threshold_low.valueChanged.connect(lambda x: self.onConfigThresholdChanged(0, x))
        self.threshold_high_slider.valueChanged.connect(lambda x: self.onThresholdSliderValueChanged(1, x))
        config.threshold_high.valueChanged.connect(lambda x: self.onConfigThresholdChanged(1, x))
        self.kernel_set_button.clicked.connect(self.openKernelSetMessageBox)
        
        self.kernel_data.kernelChanged.connect(self.onKernelChanged)

        self.apply_button.clicked.connect(self.applyParameters)
        self.discard_button.clicked.connect(self.discardParameters)
        
        QTimer.singleShot(0, self.onKernelChanged)
        
    @Slot(int, int)
    def onThresholdSliderValueChanged(self, index, value):
        if index == 0:
            config.threshold_low.value = value
        else:
            config.threshold_high.value = value
        
    @Slot(int, int)
    def onConfigThresholdChanged(self, index, value):
        if index == 0: # low value changed, check high value
            self.threshold_low_group.setContent(str(value))
            self.threshold_low_slider.setValue(value)
        else:
            self.threshold_high_group.setContent(str(value))
            self.threshold_high_slider.setValue(value)

    @Slot()
    def onKernelChanged(self):
        self.kernel_set_group.setContent(
            f"核参数：[{self.kernel_data.kernel_00:.4f}, {self.kernel_data.kernel_01:.4f}, "
            f"{self.kernel_data.kernel_02:.4f}, {self.kernel_data.kernel_11:.4f}, "
            f"{self.kernel_data.kernel_12:.4f}, {self.kernel_data.kernel_22:.4f}]")

    @Slot()
    def openKernelSetMessageBox(self):
        from app.main_window import main_window
        new_data = KernelObject(self)
        new_data.copyDataFrom(self.kernel_data)
        box = KernelSetMessageBox(new_data, main_window)
        if box.exec():
            self.kernel_data.copyDataFrom(new_data)
        
    @Slot()
    def applyParameters(self):
        for i in range(6):
            web_client.write_arg(0x100 + 4 * i, self.kernel_data.getQuantizedKernel(i))
        web_client.write_arg(0x80, self.threshold_low_slider.value())
        web_client.write_arg(0x84, self.threshold_high_slider.value())

    @Slot()
    def discardParameters(self):
        for i in range(6):
            self.kernel_data.setQuantizedKernel(i, web_client.read_arg(0x100 + 4 * i))
        self.threshold_low_slider.setValue(web_client.read_arg(0x80))
        self.threshold_high_slider.setValue(web_client.read_arg(0x84))

    @Slot()
    def onConnectionStateChanged(self, connected: bool):
        self.apply_button.setEnabled(connected)
        self.discard_button.setEnabled(connected)