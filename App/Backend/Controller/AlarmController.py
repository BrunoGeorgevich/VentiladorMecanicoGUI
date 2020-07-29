#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import Slot, Signal, Property, Qt

from Backend.Controller.Controller import Controller, Items
from Backend.Model.Alarm import Alarm

class AlarmItems(Items):
    MessageRole = Qt.UserRole + 1000
    ColorRole = Qt.UserRole + 1001

    def __init__(self, parent=None):
        super(AlarmItems, self).__init__(parent)

    def data(self, index, role=Qt.DisplayRole):
        if 0 <= index.row() < self.rowCount() and index.isValid():
            item = self.entries[index.row()]
            if role == self.MessageRole:
                return item.message
            elif role == self.ColorRole:
                return item.color
        else:
            return None

    def roleNames(self):
        roles = dict()
        roles[self.MessageRole] = b'message'
        roles[self.ColorRole] = b'msgColor'
        return roles

class AlarmController(Controller):
	def __init__(self):
		super().__init__(AlarmItems())

	@Slot(str, str)
	def add_alarm(self, message, color):
		self.add(Alarm(message, color))

	@Slot(int)
	def remove_alarm(self, idx):
		self.remove(idx)
	