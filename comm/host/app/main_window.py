
from PySide6.QtCore import Slot
from qfluentwidgets import (
    MSFluentWindow,
    Icon,
)
from qfluentwidgets import FluentIcon as FIF
from app.config import app_cfg
from app.interfaces.home_interface import HomeInterface
from app.interfaces.proc_interface import ProcInterface
from app.objects.kernel_object import KernelObject
from app.widgets.kernel_set_message_box import KernelSetMessageBox


class MainWindow(MSFluentWindow):
    def __init__(self):
        super().__init__()

        # create sub interface
        self.homeInterface = self._buildPageForWidget(HomeInterface(self), "home-page")
        self.procInterface = self._buildPageForWidget(ProcInterface(self), "proc-page")
        self.homeInterface.connectionStateChanged.connect(self.procInterface.onConnectionStateChanged)
        # self.appInterface = Widget('Application Interface', self)
        # self.videoInterface = Widget('Video Interface', self)
        # self.libraryInterface = Widget('library Interface', self)

        self.initNavigation()
        self.initWindow()

    def initNavigation(self):
        self.addSubInterface(self.homeInterface, FIF.HOME, "主页", FIF.HOME_FILL)
        self.addSubInterface(self.procInterface, FIF.PHOTO, "应用")
        # self.addSubInterface(self.videoInterface, FIF.VIDEO, '视频')

        # self.addSubInterface(self.libraryInterface, FIF.BOOK_SHELF, '库', FIF.LIBRARY_FILL, NavigationItemPosition.BOTTOM)

        # # 添加自定义导航组件
        # self.navigationInterface.addItem(
        #     routeKey='Help',
        #     icon=FIF.HELP,
        #     text='帮助',
        #     onClick=self.showMessageBox,
        #     selectable=False,
        #     position=NavigationItemPosition.BOTTOM,
        # )

        self.navigationInterface.setCurrentItem(self.homeInterface.objectName())

    def initWindow(self):
        self.resize(900, 700)
        self.setWindowIcon(Icon(FIF.PALETTE))
        self.setWindowTitle("PyQt-Fluent-Widgets")

    def _buildPageForWidget(self, widget, name: str):
        widget.setObjectName(name)
        return widget

    @Slot()
    def openKernelSetMessageBox(self):
        kernel_data = KernelObject(self)
        box = KernelSetMessageBox(kernel_data, self)
        if box.exec():
            app_cfg.applyKernelObject(kernel_data)


main_window: MainWindow = None


def createWindowAndShow():
    global main_window
    main_window = MainWindow()
    main_window.show()
