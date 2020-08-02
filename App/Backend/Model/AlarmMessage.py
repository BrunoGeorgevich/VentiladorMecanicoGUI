from PySide2.QtCore import QObject, Slot, Property, Signal

class AlarmMessage(QObject):
    def __init__(self, message, color):
        super().__init__()
        self.set_message(message)
        self.set_color(color)

    message_has_changed = Signal(str)
    @Property(str, notify=message_has_changed)
    def message(self): return self._message
    @message.setter
    def set_message(self, value):
        if value is not None:
            self._message = value
            self.message_has_changed.emit(value)
        
    color_has_changed = Signal(str)
    @Property(str, notify=color_has_changed)
    def color(self): return self._color
    @color.setter
    def set_color(self, value):
        if value is not None:
            self._color = value
            self.color_has_changed.emit(value)