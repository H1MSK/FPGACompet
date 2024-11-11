from app.objects.kernel_object import KernelObject


from PySide6.QtCore import Signal, Slot
from PySide6.QtGui import QDoubleValidator
from PySide6.QtWidgets import QGridLayout, QWidget
from qfluentwidgets import BodyLabel, ComboBox, LineEdit


import math


class GaussianKernelWidget(QWidget):
    gaussSizeChanged = Signal(int)
    gaussSigmaChanged = Signal(float)

    def __init__(self, kernel_data: KernelObject, parent=None):
        super().__init__(parent)
        self.kernel_data = kernel_data

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
            return (1 / (2 * math.pi * sigma**2)) * math.exp(
                (-(x**2 + y**2) / (2 * sigma**2))
            )

        kernels = [gauss(0, 0, sigma), gauss(0, 1, sigma), 0, gauss(1, 1, sigma), 0, 0]
        if self.gauss_size == 5:
            kernels[2] = gauss(0, 2, sigma)
            kernels[4] = gauss(1, 2, sigma)
            kernels[5] = gauss(2, 2, sigma)
        for i in range(6):
            kernels[i] = round(kernels[i], 4)
        for i, k in enumerate(kernels):
            self.kernel_data.setKernel(i, k)
