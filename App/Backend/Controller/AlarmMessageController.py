#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import Slot, Signal, Property, Qt

from Backend.Controller.Controller import Controller, Items
from Backend.Model.AlarmMessage import AlarmMessage

class AlarmMessageItems(Items):
    MessageRole = Qt.UserRole + 1000
    ColorRole = Qt.UserRole + 1001

    def __init__(self, parent=None):
        super(AlarmMessageItems, self).__init__(parent)

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

class AlarmMessageController(Controller):
	new_alarm_message_added = Signal(str, str)
	def __init__(self):
		super().__init__(AlarmMessageItems())
		self.clear()
        
	@Slot(str, str)
	def add_alarm_message(self, message, color):
		self.add(AlarmMessage(message, color))
		self.new_alarm_message_added.emit(message, color)

	@Slot(int)
	def remove_alarm_message(self, idx):
		self.remove(idx)
	