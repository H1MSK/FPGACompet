from PySide6.QtCore import Qt, Signal, QTimer
from PySide6.QtWidgets import (
    QHBoxLayout, QApplication
)
from qfluentwidgets import (
    GroupHeaderCardWidget, PushButton, LineEdit, IconWidget,
    BodyLabel, InfoBarIcon, PrimaryPushButton, FluentIcon, SpinBox,
    InfoBar
)
from qfluentwidgets import FluentIcon as FIF
from app.config import config
import web_client

class ConnectionCard(GroupHeaderCardWidget):
    connectionStateChanged = Signal(bool)
    
    def __init__(self, parent=None):
        super().__init__(parent)
        self.connected = False
        self.setTitle("连接设置")
        self.setBorderRadius(8)

        self.addr_edit = LineEdit()
        self.port_spin = SpinBox()

        self.hint_icon = IconWidget(InfoBarIcon.INFORMATION)
        self.hint_label = BodyLabel("点击按钮以开始连接 👉")
        self.connect_button = PrimaryPushButton(FluentIcon.PLAY_SOLID, "连接")
        self.disconnect_button = PushButton(FluentIcon.PAUSE_BOLD, "断开")
        self.bottom_layout = QHBoxLayout()

        self.addr_edit.setFixedWidth(320)
        self.addr_edit.setPlaceholderText("输入主机地址")
        self.addr_edit.setText(config.get(config.addr))
        self.addr_edit.textChanged.connect(lambda x: config.set(config.addr, x))
        self.port_spin.setFixedWidth(320)
        self.port_spin.setRange(1, 65535)
        self.port_spin.setValue(config.get(config.port))
        self.port_spin.valueChanged.connect(lambda x: config.set(config.port, x))

        # 设置底部工具栏布局
        self.hint_icon.setFixedSize(16, 16)
        self.bottom_layout.setSpacing(10)
        self.bottom_layout.setContentsMargins(24, 15, 24, 20)
        self.bottom_layout.addWidget(self.hint_icon, 0, Qt.AlignLeft)
        self.bottom_layout.addWidget(self.hint_label, 0, Qt.AlignLeft)
        self.bottom_layout.addStretch(1)
        self.bottom_layout.addWidget(self.disconnect_button, 0, Qt.AlignRight)
        self.bottom_layout.addWidget(self.connect_button, 0, Qt.AlignRight)
        self.bottom_layout.setAlignment(Qt.AlignVCenter)

        # 添加组件到分组中
        self.addGroup(FIF.GLOBE, "主机地址", "FPGA 设备的网络地址", self.addr_edit).setSeparatorVisible(True)
        self.addGroup(FIF.LINK, "端口号", "FPGA 设备的 TCP 端口号", self.port_spin).setSeparatorVisible(True)

        # 添加底部工具栏
        self.vBoxLayout.addLayout(self.bottom_layout)
        
        self.connect_button.clicked.connect(self.connectToHost)
        self.disconnect_button.clicked.connect(self.disconnectFromHost)
        self.connectionStateChanged.connect(self.updateWidgets)
        
        self.connectionStateChanged.emit(False)
        
    def connectToHost(self):
        if self.connected: return
        from app.widgets.main_window import main_window
        try:
            web_client.connect(self.addr_edit.text(), self.port_spin.value())
        except ConnectionRefusedError:
            print('ConnectionRefused')
            InfoBar.error(
                '连接失败', f'无法连接到{self.addr_edit.text()}:{self.port_spin.value()}',
                duration=3000,
                parent=main_window
            )
        else:
            print('connected')
            self.connected = True
            self.connectionStateChanged.emit(self.connected)
        
    def disconnectFromHost(self):
        if not self.connected: return
        web_client.disconnect()
        print('disconnected')
        self.connected = False
        self.connectionStateChanged.emit(self.connected)
    
    def updateWidgets(self):
        connect_disable = self.connected
        self.addr_edit.setDisabled(connect_disable)
        self.port_spin.setDisabled(connect_disable)
        self.connect_button.setVisible(not connect_disable)
        disconnect_disable = not self.connected
        self.disconnect_button.setVisible(not disconnect_disable)
