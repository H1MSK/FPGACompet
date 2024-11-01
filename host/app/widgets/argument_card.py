import functools
from PySide6.QtCore import Qt, Signal, Slot, QObject, QTimer
from PySide6.QtGui import QDoubleValidator
from PySide6.QtWidgets import (
    QHBoxLayout, QVBoxLayout, QGridLayout, QWidget
)
from qfluentwidgets import (
    GroupHeaderCardWidget, PushButton, LineEdit, IconWidget,
    BodyLabel, InfoBarIcon, PrimaryPushButton, FluentIcon, SpinBox,
    InfoBar, Slider, MessageBoxBase, SubtitleLabel, ComboBox, CompactDoubleSpinBox
)
from qfluentwidgets import FluentIcon as FIF
from app.config import config
import web_client
import math

class KernelObject(QObject):
    kernelChanged = Signal(int, float)
    def __init__(self, parent = None) -> None:
        super().__init__(parent)
        self.normalized = False
        self.kernel_00 = 1.0
        self.kernel_01 = 0.0
        self.kernel_02 = 0.0
        self.kernel_11 = 0.0
        self.kernel_12 = 0.0
        self.kernel_22 = 0.0
        
    def copyDataFrom(self, obj):
        for i in range(6):
            self.setKernel(i, obj.getKernel(i))
        self.normalized = obj.normalized
        
    def getKernel(self, pos: int):
        return [self.kernel_00, self.kernel_01, self.kernel_02, self.kernel_11, self.kernel_12, self.kernel_22][pos]
    
    def getQuantizedKernel(self, pos):
        return math.floor(self.getKernel(pos) * 256)
    
    def setQuantizedKernel(self, pos: int, value: int):
        self.setKernel(pos, value / 256)
    
    @Slot(int, float)
    def setKernel(self, pos: int, value: float):
        assert 0 <= value <= 1.0
        self.normalized = False
        if pos == 0:
            if self.kernel_00 != value:
                self.kernel_00 = value
                self.kernelChanged.emit(0, self.kernel_00)
        elif pos == 1:
            if self.kernel_01 != value:
                self.kernel_01 = value
                self.kernelChanged.emit(1, self.kernel_01)
        elif pos == 2:
            if self.kernel_02 != value:
                self.kernel_02 = value
                self.kernelChanged.emit(2, self.kernel_02)
        elif pos == 3:
            if self.kernel_11 != value:
                self.kernel_11 = value
                self.kernelChanged.emit(3, self.kernel_11)
        elif pos == 4:
            if self.kernel_12 != value:
                self.kernel_12 = value
                self.kernelChanged.emit(4, self.kernel_12)
        elif pos == 5:
            if self.kernel_22 != value:
                self.kernel_22 = value
                self.kernelChanged.emit(5, self.kernel_22)
        else:
            raise ValueError(f"Invalid pos: {pos}")
        
    @Slot()
    def normalizeKernel(self):
        kernels = [self.kernel_00, self.kernel_01, self.kernel_02, self.kernel_11, self.kernel_12, self.kernel_22]
        sumup = sum(kernels) * 4 - 3 * kernels[0] + 4 * kernels[4]
        print(f"kernels: {kernels}, sumup: {sumup}")
        norm = [round(k / sumup, 4) for k in kernels]
        print(f"normalized: {norm}")
        for i, k in enumerate(norm):
            self.setKernel(i, k)
        self.normalized = True
        

class GaussianKernelWidget(QWidget):
    gaussSizeChanged = Signal(int)
    gaussSigmaChanged = Signal(float)
    def __init__(self, kernel_data: KernelObject, parent = None):
        super().__init__(parent)
        self.kernel_data = kernel_data
        self.kernel_data.setKernel(0, 1.0)
        self.kernel_data.setKernel(1, 0.0)
        self.kernel_data.setKernel(2, 0.0)
        self.kernel_data.setKernel(3, 0.0)
        self.kernel_data.setKernel(4, 0.0)
        self.kernel_data.setKernel(5, 0.0)
        
        self.gauss_size = 3
        self.gauss_sigma = 1.0
        
        self.size_label = BodyLabel("高斯核尺寸：")
        self.size_combo = ComboBox(self)
        self.size_combo.addItems(["3", "5"])
        self.size_combo.currentIndexChanged.connect(self.setGaussSize)
        
        self.sigma_label = BodyLabel("高斯标准差：")
        self.sigma_edit = LineEdit(self)
        self.sigma_edit.setText(str(self.gauss_sigma))
        self.validator = QDoubleValidator(0, 1, 4, self.sigma_edit)
        self.sigma_edit.setValidator(self.validator)
        @Slot(str)
        def tryApplyGaussSigma(text: str):
            try:
                self.setGaussSigma(float(text))
            except ValueError:
                pass
        self.sigma_edit.textChanged.connect(tryApplyGaussSigma)
        
        self.grid_layout = QGridLayout(self)
        self.grid_layout.addWidget(self.size_label, 0, 0)
        self.grid_layout.addWidget(self.size_combo, 0, 1)
        self.grid_layout.addWidget(self.sigma_label, 1, 0)
        self.grid_layout.addWidget(self.sigma_edit, 1, 1)
        self.setLayout(self.grid_layout)
        
        
        self.gaussSizeChanged.connect(self.updateGaussianKernel)
        self.gaussSigmaChanged.connect(self.updateGaussianKernel)
        
        self.updateGaussianKernel()
        
    @Slot(int)
    def setGaussSize(self, index: int):
        if index == 0:
            self.gauss_size = 3
        elif index == 1:
            self.gauss_size = 5
        self.gaussSizeChanged.emit(self.gauss_size)
    
    @Slot(float)
    def setGaussSigma(self, sigma: float):
        if sigma == 0:
            print("sigma = 0, ignore")
            return
        self.gauss_sigma = float(sigma)
        self.gaussSigmaChanged.emit(self.gauss_sigma)
        
    @Slot()
    def updateGaussianKernel(self):
        sigma = self.gauss_sigma
        def gauss(x, y, sigma):
            return (1 / (2 * math.pi * sigma ** 2)) * math.exp((- (x ** 2 + y ** 2) / (2 * sigma ** 2)))
        kernels = [
            gauss(0, 0, sigma),
            gauss(0, 1, sigma),
            0,
            gauss(1, 1, sigma),
            0, 0
        ]
        if self.gauss_size == 5:
            kernels[2] = gauss(0, 2, sigma)
            kernels[4] = gauss(1, 2, sigma)
            kernels[5] = gauss(2, 2, sigma)
        for i in range(6):
            kernels[i] = round(kernels[i], 4)
        for i, k in enumerate(kernels):
            self.kernel_data.setKernel(i, k)
        
class CustomKernelWidget(QWidget):
    indexes = [12, 7, 2, 6, 1, 0]
    def __init__(self, kernel_data: KernelObject, parent=None) -> None:
        super().__init__(parent)
        self.kernel_data = kernel_data
        self.label = BodyLabel("参数值：")
        self.boxes = [CompactDoubleSpinBox(self) for _ in range(25)]
        self.validator = QDoubleValidator(0, 10, 4, self)
        self.normalize_button = PushButton("归一化")
        for box in self.boxes:
            box.setRange(0, 100)
            box.setDecimals(4)
            box.setSingleStep(0.0001)
        for i, idx in enumerate(CustomKernelWidget.indexes):
            self.boxes[idx].setValue(self.kernel_data.getKernel(i))
            self.boxes[idx].valueChanged.connect(
                functools.partial(
                    lambda kernel_idx, val: self.kernel_data.setKernel(kernel_idx, val),
                    i))
            self.kernel_data.kernelChanged.connect(self.onKernelDataChanged)
            
        self.grid_layout = QGridLayout(self)
        for row in range(5):
            for col in range(5):
                self.grid_layout.addWidget(self.boxes[row * 5 + col], row, col)
                if row <= 2 and col <= 2 and row <= col:
                    print(f"{row} {col} is editable")
                    continue
                kernel_row = row - 2
                kernel_col = col - 2
                if kernel_row > 0: kernel_row = -kernel_row
                if kernel_col > 0: kernel_col = -kernel_col
                if kernel_row > kernel_col:
                    kernel_row, kernel_col = kernel_col, kernel_row
                ref_row = kernel_row + 2
                ref_col = kernel_col + 2
                self.boxes[ref_row * 5 + ref_col].valueChanged.connect(
                    functools.partial(
                        lambda pos, val: self.boxes[pos].setValue(val),
                        row * 5 + col))
                print(f"{row} {col} is linked to {ref_row} {ref_col}")
                self.boxes[row * 5 + col].setEnabled(False)
                self.boxes[row * 5 + col].setValue(
                    self.boxes[ref_row * 5 + ref_col].value()
                )
        self.setLayout(self.grid_layout)

    
    @Slot(int, float)
    def onKernelDataChanged(self, kernel, val):
        edit = self.boxes[CustomKernelWidget.indexes[kernel]]
        edit.setValue(val)
        edit.editingFinished.emit()

class KernelSetMessageBox(MessageBoxBase):
    def __init__(self, kernel_data: KernelObject, parent = None):
        super().__init__(parent)
        
        self.mode = 1
        self.gauss_sigma = 1.0
        
        self.title_label = SubtitleLabel("参数设置")
        
        self.mode_widget = QWidget(self)
        self.mode_layout = QHBoxLayout(self.mode_widget)
        
        self.mode_label = BodyLabel("卷积核类型：")
        self.mode_combo = ComboBox(self)
        self.mode_combo.addItems(["高斯", "自定义"])
        self.mode_combo.setCurrentIndex(self.mode)
        self.mode_combo.currentIndexChanged.connect(self.setMode)
        
        self.mode_layout.addWidget(self.mode_label)
        self.mode_layout.addWidget(self.mode_combo, 1)
        
        self.kernel_label = BodyLabel("核参数：")
        
        self.kernel_data = kernel_data
        
        self.filter_gauss_sigma_widget = GaussianKernelWidget(self.kernel_data, self)
        self.custom_kernel_widget = CustomKernelWidget(self.kernel_data, self)
        self.normalize_button = PushButton("归一化")
        self.normalize_button.clicked.connect(self.kernel_data.normalizeKernel)
        
        self.kernel_text = BodyLabel("核参数")
        self.kernel_data.kernelChanged.connect(self.updateKernelText)
        
        self.viewLayout.addWidget(self.title_label)
        self.viewLayout.addWidget(self.mode_widget)
        # self.viewLayout.addWidget(self.kernel_label)
        self.viewLayout.addWidget(self.filter_gauss_sigma_widget)
        self.viewLayout.addWidget(self.custom_kernel_widget)
        self.viewLayout.addWidget(self.normalize_button)
        self.viewLayout.addWidget(self.kernel_text)
        
        self.updateKernelText()
        self.setMode(self.mode_combo.currentIndex())
        
    @Slot()
    def updateKernelText(self):
        self.kernel_text.setText(
            f"核参数：[{self.kernel_data.kernel_00:.4f}, {self.kernel_data.kernel_01:.4f}, "
            f"{self.kernel_data.kernel_02:.4f}, {self.kernel_data.kernel_11:.4f}, "
            f"{self.kernel_data.kernel_12:.4f}, {self.kernel_data.kernel_22:.4f}]")
        
    @Slot(int)
    def setMode(self, mode_index: int):
        if mode_index == 0: # Gauss
            self.filter_gauss_sigma_widget.setVisible(True)
            self.custom_kernel_widget.setVisible(False)
            self.mode = 0
        elif mode_index == 1: # Custom
            self.filter_gauss_sigma_widget.setVisible(False)
            self.custom_kernel_widget.setVisible(True)
            self.mode = 1


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
        self.threshold_low_group = self.addGroup(FIF.SETTING, "低阈值", str(self.threshold[0]), self.threshold_low_slider)
        self.threshold_low_group.setSeparatorVisible(True)

        self.threshold_high_group = self.addGroup(FIF.SETTING, "高阈值", str(self.threshold[1]), self.threshold_high_slider)
        self.threshold_high_group.setSeparatorVisible(True)
        
        self.kernel_set_group = self.addGroup(FIF.SETTING, "卷积核配置", "", self.kernel_set_button)

        # 添加底部工具栏
        self.vBoxLayout.addLayout(self.bottom_layout)

        config.threshold_low.valueChanged.connect(self.threshold_low_slider.setValue)
        config.threshold_high.valueChanged.connect(self.threshold_high_slider.setValue)
        self.threshold_low_slider.valueChanged.connect(lambda x: self.thresholdChanged(0, x))
        self.threshold_high_slider.valueChanged.connect(lambda x: self.thresholdChanged(1, x))
        self.kernel_set_button.clicked.connect(self.openKernelSetMessageBox)
        
        self.kernel_data.kernelChanged.connect(self.onKernelChanged)

        self.apply_button.clicked.connect(self.applyParameters)
        self.discard_button.clicked.connect(self.discardParameters)
        
        QTimer.singleShot(0, self.onKernelChanged)
        
    @Slot(int, int)
    def thresholdChanged(self, index, value):
        if index == 0: # low value changed, check high value
            if config.threshold_low.value == value:
                return
            config.threshold_low.value = value
            if config.threshold_high.value < config.threshold_low.value:
                config.threshold_high.value = config.threshold_low.value
            self.threshold_low_group.setContent(str(value))
        else:
            if config.threshold_high.value == value:
                return
            config.threshold_high.value = value
            if config.threshold_high.value < config.threshold_low.value:
                config.threshold_low.value = config.threshold_high.value
            self.threshold_high_group.setContent(str(value))

    @Slot()
    def onKernelChanged(self):
        self.kernel_set_group.setContent(
            f"核参数：[{self.kernel_data.kernel_00:.4f}, {self.kernel_data.kernel_01:.4f}, "
            f"{self.kernel_data.kernel_02:.4f}, {self.kernel_data.kernel_11:.4f}, "
            f"{self.kernel_data.kernel_12:.4f}, {self.kernel_data.kernel_22:.4f}]")

    @Slot()
    def openKernelSetMessageBox(self):
        from .main_window import main_window
        new_data = KernelObject(self)
        new_data.copyDataFrom(self.kernel_data)
        box = KernelSetMessageBox(new_data, main_window)
        if box.exec():
            self.kernel_data.copyDataFrom(new_data)
        
    @Slot()
    def applyParameters(self):
        for i in range(6):
            web_client.write_arg(0x100 + 4 * i, self.kernel_data.getQuantizedKernel(i))
        web_client.write_arg(0x80, self.threshold[0])
        web_client.write_arg(0x84, self.threshold[1])
    
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