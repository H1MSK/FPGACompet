from PySide6.QtCore import QTimer, Slot
from PySide6.QtGui import QImage, QGuiApplication
from PySide6.QtWidgets import QFrame, QGridLayout, QFileDialog
from qfluentwidgets import (
    TitleLabel,
    RangeSettingCard,
    ImageLabel,
    Dialog,
    PrimaryPushButton,
    PushSettingCard,
)
from qfluentwidgets import FluentIcon as FIF
from app.config import app_cfg
import os

import web_client


class ProcInterface(QFrame):
    def __init__(self, parent=None):
        super().__init__(parent=parent)

        screen_geometry = QGuiApplication.primaryScreen().availableGeometry()
        print(
            "screen_size = "
            f"{screen_geometry.width()}x{screen_geometry.height()}"
            f"@({screen_geometry.left()},{screen_geometry.top()})"
        )
        self.column_width = min(
            screen_geometry.width() / 3, screen_geometry.height() / 1.5
        )
        print(f"column_width = {self.column_width}")
        self.grid_layout = QGridLayout(self)

        self.title = TitleLabel("图像处理")
        self.grid_layout.addWidget(self.title, 0, 0, 1, -1)

        self.kernel_setting_card = PushSettingCard(
            "设置...", FIF.SETTING, "卷积核", None, self
        )
        self.kernel_setting_card.clicked.connect(self.openKernelSetMessageBox)
        self.grid_layout.addWidget(self.kernel_setting_card, 1, 0, 1, -1)

        self.threshold_low_card = RangeSettingCard(
            app_cfg.threshold_low, FIF.SETTING, "低阈值", None, self
        )
        self.threshold_high_card = RangeSettingCard(
            app_cfg.threshold_high, FIF.SETTING, "高阈值", None, self
        )

        self.grid_layout.addWidget(self.threshold_low_card, 2, 0)
        self.grid_layout.addWidget(self.threshold_high_card, 2, 1)

        self.input_image_label = ImageLabel(self)
        self.input_image_label.clicked.connect(self.pickInputImage)
        self.output_image_dat: bytes = bytes()
        self.output_image: QImage = QImage()
        self.output_image_label = ImageLabel(self)
        self.output_image_label.clicked.connect(self.saveOutputImage)
        self.grid_layout.addWidget(self.input_image_label, 3, 0)
        self.grid_layout.addWidget(self.output_image_label, 3, 1)
        self.grid_layout.setRowStretch(3, 1)

        self.run_button = PrimaryPushButton(FIF.PLAY, "运行", self)
        self.run_button.clicked.connect(self.run)
        self.grid_layout.addWidget(self.run_button, 4, 0, 1, -1)

        self.grid_layout.setColumnMinimumWidth(0, self.column_width)
        self.grid_layout.setColumnMinimumWidth(1, self.column_width)

        self.setLayout(self.grid_layout)

        app_cfg.kernelChanged.connect(self.updateKernelText)

        QTimer.singleShot(0, self.preloadImages)
        QTimer.singleShot(0, self.updateKernelText)

        app_cfg.threshold_high.valueChanged.connect(self.updateOutputImage)
        app_cfg.threshold_low.valueChanged.connect(self.updateOutputImage)

    @Slot()
    def preloadImages(self):
        if os.path.exists("test_in.png"):
            img = QImage("test_in.png").scaled(1024, 1024)
            self.input_image_label.setImage(img)
            self.input_image_label.scaledToWidth(self.column_width)
        if os.path.exists("test_out.png"):
            self.output_image = (
                QImage("test_out.png")
                .scaled(1024, 1024)
                .toPixelFormat(QImage.Format.Format_Grayscale8)
            )
            self.updateOutputImage()

    @Slot()
    def pickInputImage(self):
        while True:
            name, _ = QFileDialog.getOpenFileName(
                self, "选择输入图像", "", "图像文件 (*.bmp *.jpeg *.jpg *.png)"
            )
            if len(name) == 0:
                return
            img = QImage(name, format=None)
            if img.width() != 1024 or img.height() != 1024:
                from app.main_window import main_window

                w = Dialog(
                    "自动转换",
                    f"选中图像尺寸为{img.width()}x{img.height()}，"
                    "输入图像尺寸需要为1024x1024，是否进行自动转换？",
                    main_window,
                )
                w.yesButton.setText("转换")
                w.cancelButton.setText("重新选择...")
                if not w.exec():
                    print("canceled input image pick")
                    continue
                else:
                    img = img.scaled(1024, 1024)
                    break
            else:
                break
        self.input_image_label.setImage(img)
        self.input_image_label.scaledToWidth(self.column_width)

    @Slot()
    def saveOutputImage(self):
        name, _ = QFileDialog.getSaveFileName(
            self, "保存输出图像", "", "图像文件 (*.bmp *.jpeg *.jpg *.png)"
        )
        if name:
            self.output_image_label.image.save(name)

    @Slot()
    def updateKernelText(self):
        self.kernel_setting_card.setContent(
            f"[{app_cfg.kernel_00.value:.4f}, {app_cfg.kernel_01.value:.4f}, "
            f"{app_cfg.kernel_02.value:.4f}, {app_cfg.kernel_11.value:.4f}, "
            f"{app_cfg.kernel_12.value:.4f}, {app_cfg.kernel_22.value:.4f}]"
        )

    @Slot()
    def openKernelSetMessageBox(self):
        from app.main_window import main_window

        main_window.openKernelSetMessageBox()

    @Slot()
    def run(self):
        app_cfg.upload()
        in_dat = self.input_image_label.image.convertToFormat(
            QImage.Format.Format_Grayscale8
        )
        with open(os.path.dirname(__file__) + "/model.bin", "rb") as fp:
            buf = fp.read()
        web_client.write_weights(buf)
        web_client.write_img(in_dat.constBits())
        web_client.write_arg(0x00, 0x01)
        out_dat = bytes(web_client.read_img())
        self.output_image_dat = out_dat
        self.output_image: QImage = QImage(
            out_dat, 1024, 1024, QImage.Format.Format_Grayscale8
        )
        self.output_image.save("test_out.png")
        self.updateOutputImage()

    @Slot()
    def updateOutputImage(self):
        if len(self.output_image_dat) == 0:
            return
        low = app_cfg.threshold_low.value
        high = app_cfg.threshold_high.value
        ratio = max(1, high - low)
        ints = list(min(255, max(0, round((pix - low) / ratio * 255))) for pix in self.output_image_dat)
        dat = bytes(ints)
        self.output_image = QImage(
            dat, 1024, 1024, QImage.Format.Format_Grayscale8
        )
        self.output_image_label.setImage(self.output_image)
        self.output_image_label.scaledToWidth(self.column_width)

    @Slot()
    def onConnectionStateChanged(self, connected):
        self.run_button.setEnabled(connected)
