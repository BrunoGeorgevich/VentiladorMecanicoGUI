from PySide2.QtCore import QRunnable, QObject, Slot, Signal
import sys,os,subprocess,time,traceback

class HardwareThread(QRunnable):
    def __init__(self, fn, parent, *args, **kwargs):
        super(HardwareThread, self).__init__()
        
        self.fn = fn
        self.args = args
        self.kwargs = kwargs
        self.parent = parent
        self.signals = HardwareThreadSignals()

    @Slot()
    def run(self):
        try:
            result = self.fn(
                *self.args, **self.kwargs,
            )
        except:
            traceback.print_exc()
            exctype, value = sys.exc_info()[:2]
            if self.parent.hardware_is_connected:
                self.signals.error.emit((exctype, value, traceback.format_exc()))
        else:
            if self.parent.hardware_is_connected:
                try:
                    self.signals.result.emit(result)
                except:
                    pass
        finally:
            if self.parent.hardware_is_connected:
                try:
                    self.signals.finished.emit()
                except:
                    pass


class HardwareThreadSignals(QObject):
    finished = Signal()
    error = Signal(tuple)
    result = Signal(object)

    def __init__(self):
        super(HardwareThreadSignals, self).__init__()
