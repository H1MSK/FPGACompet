from app.objects.kernel_object import KernelObject
from app.widgets.custom_kernel_widget import CustomKernelWidget
from app.widgets.gaussian_kernel_widget import GaussianKernelWidget


from PySide6.QtCore import Slot
from PySide6.QtWidgets import QHBoxLayout, QWidget
from qfluentwidgets import (
    BodyLabel,
    ComboBox,
    MessageBoxBase,
    PushButton,
    SubtitleLabel,
)


class KernelSetMessageBox(MessageBoxBase):
    def __init__(self, kernel_data: KernelObject, parent=None):
        super().__init__(parent)

        self.mode = 1

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
            f"{self.kernel_data.kernel_12:.4f}, {self.kernel_data.kernel_22:.4f}]"
        )

    @Slot(int)
    def setMode(self, mode_index: int):
        if mode_index == 0:  # Gauss
            self.filter_gauss_sigma_widget.setVisible(True)
            self.custom_kernel_widget.setVisible(False)
            self.mode = 0
        elif mode_index == 1:  # Custom
            self.filter_gauss_sigma_widget.setVisible(False)
            self.custom_kernel_widget.setVisible(True)
            self.mode = 1
