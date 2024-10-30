from PySide6.QtCore import Qt
from PySide6.QtGui import QValidator
from PySide6.QtWidgets import (
    QHBoxLayout, QGridLayout
)
from qfluentwidgets import (
    GroupHeaderCardWidget, PushButton, LineEdit, IconWidget,
    BodyLabel, InfoBarIcon, PrimaryPushButton, FluentIcon, SpinBox,
    InfoBar, Slider, MessageBoxBase, SubtitleLabel, ComboBox
)
from qfluentwidgets import FluentIcon as FIF
from app.config import config
import web_client

class ParamSetMessageBox(MessageBoxBase):
    def __init__(self, parent = None):
        super().__init__(parent)
        self.title_label = SubtitleLabel("参数设置")
        self.viewLayout.addWidget(self.title_label)
        
        self.mode = "gauss"
        
        self.mode_combo = ComboBox(self)
        self.mode_combo.addItems(["高斯", "自定义"])
        
        self.
        self.threshold_sigma_validator = None # todo
        self.filter_gauss_sigma_edit = LineEdit(self)
        self.filter_gauss_sigma_edit.setValidator(self.threshold_sigma_validator)
        self.filter_gauss_sigma_edit.textChanged.connect(lambda: self.)
        
        self.grid_layout = QGridLayout(self)
        self.grid_layout.addWidget(BodyLabel("模式："), 0, 0)
        self.grid_layout.addWidget()

class ArgumentCard(GroupHeaderCardWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        
        self.threshold = [0, 255]
        
        self.setTitle("参数配置")
        self.setBorderRadius(8)

        self.hint_icon = IconWidget(FluentIcon.APPLICATION)
        self.apply_button = PrimaryPushButton(FluentIcon.UP, "应用")
        self.discard_button = PushButton(FluentIcon.DOWNLOAD, "读取")
        self.bottom_layout = QHBoxLayout()
        
        self.threshold_low_slider = Slider(self)
        self.threshold_low_slider.setFixedWidth(320)
        self.threshold_low_slider.setRange(0, 255)
        self.threshold_low_slider.setValue(1)
        
        self.threshold_high_slider = Slider(self)
        self.threshold_high_slider.setFixedWidth(320)
        self.threshold_high_slider.setRange(0, 255)
        self.threshold_high_slider.setValue(64)
        
        self.param_set_button = PushButton("参数设置")

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
        self.addGroup(FIF.GLOBE, "主机地址", "FPGA 设备的网络地址", self.addr_edit).setSeparatorVisible(True)
        self.addGroup(FIF.LINK, "端口号", "FPGA 设备的 TCP 端口号", self.port_spin).setSeparatorVisible(True)

        # 添加底部工具栏
        self.vBoxLayout.addLayout(self.bottom_layout)

        self.updateWidgets()
        
        
        self.threshold_low_slider.valueChanged.connect(lambda: self.thresholdRangeCheck(0))
        self.threshold_high_slider.valueChanged.connect(lambda: self.thresholdRangeCheck(1))
        self.param_set_button.clicked.connect(self.openParamSetMessageBox())

        self.apply_button.clicked.connect(lambda: self.applyParameters())
        self.discard_button.clicked.connect(lambda: self.downloadParameters())
        
    def thresholdRangeCheck(self, index):
        if index == 0:
            self.threshold[0] = self.threshold_low_slider.value()
            if self.threshold[0] > self.threshold[1]:
                self.threshold[0] = self.threshold[1]
                self.threshold_low_slider.setValue(self.threshold[0])
        else:
            self.threshold[1] = self.threshold_high_slider.value()
            if self.threshold[1] < self.threshold[0]:
                self.threshold[1] = self.threshold[0]
                self.threshold_high_slider.setValue(self.threshold[1])

    def updateWidgets(self):
        connect_disable = self.connected
        self.addr_edit.setDisabled(connect_disable)
        self.port_spin.setDisabled(connect_disable)
        self.apply_button.setDisabled(connect_disable)
        disconnect_disable = not self.connected
        self.disconnect_button.setDisabled(disconnect_disable)

    def openParamSetMessageBox(self):
        