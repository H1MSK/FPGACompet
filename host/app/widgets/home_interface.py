from PySide6.QtWidgets import (QFrame, QVBoxLayout, QSpacerItem)
from qfluentwidgets import TitleLabel
from app.widgets.connection_card import ConnectionCard
from app.widgets.base_interface import BaseInterface


class HomeInterface(QFrame):
    def __init__(self, parent=None):
        super().__init__(parent=parent)
        self.title = TitleLabel("主页")
        self.layout = QVBoxLayout(self)
        self.layout.addWidget(self.title)
        self.connection = ConnectionCard(self)
        self.layout.addWidget(self.connection)
        self.layout.addStretch(1)
