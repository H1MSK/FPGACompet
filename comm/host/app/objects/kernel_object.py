from PySide6.QtCore import QObject, Signal, Slot
from app.config import app_cfg
import math


class KernelObject(QObject):
    kernelChanged = Signal(int, float)

    def __init__(self, parent=None) -> None:
        super().__init__(parent)
        self.normalized = False
        self.kernel_00 = app_cfg.kernel_00.value
        self.kernel_01 = app_cfg.kernel_01.value
        self.kernel_02 = app_cfg.kernel_02.value
        self.kernel_11 = app_cfg.kernel_11.value
        self.kernel_12 = app_cfg.kernel_12.value
        self.kernel_22 = app_cfg.kernel_22.value

    def getKernel(self, pos: int):
        return (
            self.kernel_00,
            self.kernel_01,
            self.kernel_02,
            self.kernel_11,
            self.kernel_12,
            self.kernel_22,
        )[pos]

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
        kernels = [
            self.kernel_00,
            self.kernel_01,
            self.kernel_02,
            self.kernel_11,
            self.kernel_12,
            self.kernel_22,
        ]
        sumup = sum(kernels) * 4 - 3 * kernels[0] + 4 * kernels[4]
        print(f"kernels: {kernels}, sumup: {sumup}")
        norm = [round(k / sumup, 4) for k in kernels]
        print(f"normalized: {norm}")
        for i, k in enumerate(norm):
            self.setKernel(i, k)
        self.normalized = True
