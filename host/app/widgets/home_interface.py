from PySide6.QtWidgets import (QFrame, QVBoxLayout, QSpacerItem)
from qfluentwidgets import TitleLabel
from app.widgets.connection_card import ConnectionCard
from app.widgets.base_interface import BaseInterface
from app.widgets.argument_card import ArgumentCard


class HomeInterface(QFrame):
    def __init__(self, parent=None):
        super().__init__(parent=parent)
        self.title = TitleLabel("主页")
        self.layout = QVBoxLayout(self)
        self.layout.addWidget(self.title)
        self.connection_card = ConnectionCard(self)
        self.argument_card = ArgumentCard(self)
        self.layout.addWidget(self.connection_card)
        self.layout.addWidget(self.argument_card)
        self.layout.addStretch(1)
        
        self.connection_card.connectionStateChanged.connect(
            self.argument_card.onConnectionStateChanged
        )
