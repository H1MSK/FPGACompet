# coding:utf-8
from PySide6.QtCore import Qt
from PySide6.QtWidgets import QWidget, QVBoxLayout

from qfluentwidgets import ScrollArea


class BaseInterface(ScrollArea):
    """Gallery interface"""

    def __init__(self, parent=None):
        """
        Parameters
        ----------
        title: str
            The title of gallery

        subtitle: str
            The subtitle of gallery

        parent: QWidget
            parent widget
        """
        super().__init__(parent=parent)
        self.view = QWidget(self)
        self.vBoxLayout = QVBoxLayout(self.view)

        self.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.setWidget(self.view)
        self.setWidgetResizable(True)

        self.vBoxLayout.setSpacing(30)
        self.vBoxLayout.setAlignment(Qt.AlignTop)
        self.vBoxLayout.setContentsMargins(36, 20, 36, 36)

        self.view.setObjectName("view")

    def addWidget(self, widget):
        self.vBoxLayout.addWidget(widget, 0, Qt.AlignTop)
