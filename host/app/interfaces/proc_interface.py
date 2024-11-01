from PySide6.QtCore import QTimer, Slot
from PySide6.QtGui import QPixmap, QImage, QScreen, QGuiApplication
from PySide6.QtWidgets import (QFrame, QGridLayout, QSpacerItem)
from qfluentwidgets import TitleLabel, RangeSettingCard, ImageLabel, Action, PrimaryPushButton
from app.widgets.connection_card import ConnectionCard
from app.interfaces.base_interface import BaseInterface
from app.widgets.argument_card import ArgumentCard
from qfluentwidgets import FluentIcon as FIF
from app.config import config
import os


class ProcInterface(QFrame):
  def __init__(self, parent=None):
    super().__init__(parent=parent)
    
    screen_geometry = QGuiApplication.primaryScreen().availableGeometry()
    print(f"screen_size = {screen_geometry.width()}x{screen_geometry.height()}@({screen_geometry.left()},{screen_geometry.top()})")
    self.column_width = min(screen_geometry.width() / 3, screen_geometry.height() / 1.5)
    print(f"column_width = {self.column_width}")
    self.grid_layout = QGridLayout(self)
    
    self.title = TitleLabel("图像处理")
    self.grid_layout.addWidget(self.title, 0, 0, 0, -1)
    
    self.threshold_low_card = RangeSettingCard(config.threshold_low, FIF.SETTING, "低阈值", None, self)
    self.threshold_high_card = RangeSettingCard(config.threshold_high, FIF.SETTING, "高阈值", None, self)
    
    self.grid_layout.addWidget(self.threshold_low_card, 1, 0)
    self.grid_layout.addWidget(self.threshold_high_card, 1, 1)
    
    self.input_image = ImageLabel(self)
    self.output_image = ImageLabel(self)
    self.grid_layout.addWidget(self.input_image, 2, 0)
    self.grid_layout.addWidget(self.output_image, 2, 1)
    
    self.run_button = PrimaryPushButton(FIF.PLAY, "运行", self)
    self.grid_layout.addWidget(self.run_button, 3, 0, 1, -1)
    
    self.grid_layout.setRowStretch(2, 1)
    self.grid_layout.setColumnMinimumWidth(0, self.column_width)
    self.grid_layout.setColumnMinimumWidth(1, self.column_width)
    
    self.setLayout(self.grid_layout)
    
    QTimer.singleShot(0, self.loadImages)
  
  @Slot()
  def loadImages(self):
    if os.path.exists("test_in.png"):
      self.input_image.setImage("test_in.png")
      self.input_image.scaledToHeight(self.column_width)
    if os.path.exists("test_out.png"):
      self.output_image.setImage("test_out.png")
      self.output_image.scaledToHeight(self.column_width)