from PySide2.QtCore import Slot, Property, Signal, Qt, QObject

class SplashController(QObject):

    def __init__(self):
        super().__init__()
        self._splash_is_opened = True
    
    splash_is_opened_changed = Signal(int)
    @Property(int, notify=splash_is_opened_changed)
    def splash_is_opened(self): return self._splash_is_opened
    @splash_is_opened.setter
    def set_splash_is_opened(self, value): 
        self._splash_is_opened= value
        self.splash_is_opened_changed.emit(value)