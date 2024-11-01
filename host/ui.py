import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtGui import QPalette
from app.main_window import createWindowAndShow
from app.config import config

if __name__ == '__main__':
    app = QApplication(sys.argv)
    createWindowAndShow()
    app.aboutToQuit.connect(config.save)
    app.exec()
