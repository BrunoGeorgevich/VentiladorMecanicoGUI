from PySide2.QtCore import QObject, Slot, Property, Signal

class Alarm(QObject):
    def __init__(self, is_enabled, name, min_val, max_val, key, alarm_type):
        super().__init__()
        self.set_is_enabled(is_enabled)
        self.set_name(name)
        self.set_min_val(min_val)
        self.set_max_val(max_val)
        self.set_key(key)
        self.set_alarm_type(alarm_type)

    is_enabled_has_changed = Signal(bool)
    @Property(bool, notify=is_enabled_has_changed)
    def is_enabled(self): return self._is_enabled
    @is_enabled.setter
    def set_is_enabled(self, value):
        if value is not None:
            self._is_enabled = value
            self.is_enabled_has_changed.emit(value)
        
    name_has_changed = Signal(str)
    @Property(str, notify=name_has_changed)
    def name(self): return self._name
    @name.setter
    def set_name(self, value):
        if value is not None:
            self._name = value
            self.name_has_changed.emit(value)
        
    min_val_has_changed = Signal(float)
    @Property(float, notify=min_val_has_changed)
    def min_val(self): return self._min_val
    @min_val.setter
    def set_min_val(self, value):
        if value is not None:
            self._min_val = value
            self.min_val_has_changed.emit(value)

    max_val_has_changed = Signal(float)
    @Property(float, notify=max_val_has_changed)
    def max_val(self): return self._max_val
    @max_val.setter
    def set_max_val(self, value):
        if value is not None:
            self._max_val = value
            self.max_val_has_changed.emit(value)
        
    key_has_changed = Signal(str)
    @Property(str, notify=key_has_changed)
    def key(self): return self._key
    @key.setter
    def set_key(self, value):
        if value is not None:
            self._key = value
            self.key_has_changed.emit(value)
        
    alarm_type_has_changed = Signal(str)
    @Property(str, notify=alarm_type_has_changed)
    def alarm_type(self): return self._alarm_type
    @alarm_type.setter
    def set_alarm_type(self, value):
        if value is not None:
            self._alarm_type = value
            self.alarm_type_has_changed.emit(value)