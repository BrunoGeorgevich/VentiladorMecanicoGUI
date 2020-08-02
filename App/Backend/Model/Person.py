from PySide2.QtCore import QObject, Slot, Property, Signal

class Person(QObject):
    def __init__(self):
        super().__init__()
        # self._name = ""
        self._height = 170
        self._gender = "male"

    # name_has_changed = Signal(str)
    # @Property(str, notify=name_has_changed)
    # def name(self): return self._name
    # @name.setter
    # def set_name(self, value):
    #     self._name = value
    #     self.name_has_changed.emit(value)
        
    height_has_changed = Signal(int)
    @Property(int, notify=height_has_changed)
    def height(self): return self._height
    @height.setter
    def set_height(self, value):
        self._height = value
        self.height_has_changed.emit(value)
        
    gender_has_changed = Signal(str)
    @Property(str, notify=gender_has_changed)
    def gender(self): return self._gender
    @gender.setter
    def set_gender(self, value):
        self._gender = value
        self.gender_has_changed.emit(value)