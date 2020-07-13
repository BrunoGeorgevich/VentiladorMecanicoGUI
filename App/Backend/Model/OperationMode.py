from PySide2.QtCore import QObject, Slot, Property, Signal

class OperationMode(QObject):
    def __init__(self):
        super().__init__()
        self._mode = ""
        self._parameters = {}

    mode_has_changed = Signal(str)
    @Property(str, notify=mode_has_changed)
    def mode(self): return self._mode
    @mode.setter
    def set_mode(self, value):
        self._mode = value
        self.mode_has_changed.emit(value)
        
    parameters_has_changed = Signal('QVariant')
    @Property('QVariant', notify=parameters_has_changed)
    def parameters(self): return self._parameters[self._mode]

    def init_parameters(self):
        self._parameters[self._mode] = {}

    def add_parameters(self, name, value):
        self._parameters[self._mode][name] = value