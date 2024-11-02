from app.objects.kernel_object import KernelObject


from PySide6.QtCore import Slot
from PySide6.QtGui import QDoubleValidator
from PySide6.QtWidgets import QGridLayout, QWidget
from qfluentwidgets import BodyLabel, CompactDoubleSpinBox, PushButton


import functools


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
                    i,
                )
            )
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
                if kernel_row > 0:
                    kernel_row = -kernel_row
                if kernel_col > 0:
                    kernel_col = -kernel_col
                if kernel_row > kernel_col:
                    kernel_row, kernel_col = kernel_col, kernel_row
                ref_row = kernel_row + 2
                ref_col = kernel_col + 2
                self.boxes[ref_row * 5 + ref_col].valueChanged.connect(
                    functools.partial(
                        lambda pos, val: self.boxes[pos].setValue(val), row * 5 + col
                    )
                )
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
