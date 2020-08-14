#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import Slot, Signal, Property, Qt

from Backend.Controller.Controller import Controller, Items
from Backend.Model.Alarm import Alarm

class AlarmItems(Items):
    IsEnabledRole = Qt.UserRole + 1000
    NameRole = Qt.UserRole + 1001
    MinRole = Qt.UserRole + 1002
    MaxRole = Qt.UserRole + 1003
    KeyRole = Qt.UserRole + 1004
    AlarmTypeRole = Qt.UserRole + 1005

    def __init__(self, parent=None):
        super(AlarmItems, self).__init__(parent)

    def data(self, index, role=Qt.DisplayRole):
        if 0 <= index.row() < self.rowCount() and index.isValid():
            item = self.entries[index.row()]
            if role == self.IsEnabledRole:
                return item.is_enabled
            if role == self.NameRole:
                return item.name
            elif role == self.MinRole:
                return item.min_val
            elif role == self.MaxRole:
                return item.max_val
            elif role == self.KeyRole:
                return item.key
            elif role == self.AlarmTypeRole:
                return item.alarm_type
        else:
            return None

    def roleNames(self):
        roles = dict()
        roles[self.IsEnabledRole] = b'isEnabled'
        roles[self.NameRole] = b'name'
        roles[self.MinRole] = b'min'
        roles[self.MaxRole] = b'max'
        roles[self.KeyRole] = b'key'
        roles[self.AlarmTypeRole] = b'alarmType'
        return roles

class AlarmController(Controller):
	def __init__(self, alarm_message_controller):
		super().__init__(AlarmItems())
		self.clear()
		self._alarm_message_controller = alarm_message_controller
		self.current_mode = ""

	@Slot(str)
	def init_vcv_alarm(self, mode):
		if self.current_mode != mode:
			self.clear()
			self.current_mode = mode
			self.add_alarm(True, "Tempo de inspiração", 0, 100, "tInsp", "numerical")
			self.add_alarm(True, "Pressão de Pico", 0, 100, "pe", "numerical")
			self.add_alarm(True, "Volume Tidal", 0, 100, "ve", "numerical")
			self.add_alarm(True, "Volume Minuto", 0, 100, "vol_min", "numerical")
			self.add_alarm(True, "FIO2", 0, 100, "fio2", "numerical")
        
	@Slot(str)
	def init_pcv_alarm(self, mode):
		if self.current_mode != mode:
			self.clear()
			self.current_mode = mode
			self.add_alarm(True, "Pressão de Pico", 0, 100, "pe", "numerical")
			self.add_alarm(True, "Volume Tidal", 0, 100, "ve", "numerical")
			self.add_alarm(True, "Volume Minuto", 0, 100, "vol_min", "numerical")
			self.add_alarm(True, "FIO2", 0, 100, "fio2", "numerical")
        
	@Slot(bool, str, float, float)
	def add_alarm(self, is_enabled, name, min_val, max_val, key, alarm_type):
		self.add(Alarm(is_enabled, name, min_val, max_val, key, alarm_type))
			
        
	@Slot(int, bool)
	def set_is_enabled(self, index, value):
		self.items.entries[index].set_is_enabled(value)
        
	@Slot(int, float)
	def set_max(self, index, value):
		self.items.entries[index].set_max_val(value)

	@Slot(int, float)
	def set_min(self, index, value):
		self.items.entries[index].set_min_val(value)

	@Slot(int)
	def remove_alarm(self, idx):
		self.remove(idx)

	@Slot(str, result=float)
	def get_min(self, key):
		item = list(filter(lambda it: it.key == key, self.items.entries))
		
		if len(item) == 1:
			item = item[0]
		else:
			item = None

		if item is not None:
			min_val = item.min_val
			return min_val

		return "-"

	@Slot(str, result=float)
	def get_max(self, key):
		item = list(filter(lambda it: it.key == key, self.items.entries))
		
		if len(item) == 1:
			item = item[0]
		else:
			item = None

		if item is not None:
			max_val = item.max_val
			return max_val
			
		return "-"
	
	@Slot(str, float, result=bool)
	def check_value(self, key, value):
		item = list(filter(lambda it: it.key == key, self.items.entries))
		
		if len(item) == 1:
			item = item[0]
		else:
			item = None

		if item is not None:
			if item.is_enabled == False:
				return True
				
			name = item.name
			min_val = item.min_val
			max_val = item.max_val
			max_triggered = list(filter(lambda it: it.message == f"{name} excedeu o limite máximo!", self._alarm_message_controller.items.entries))
			min_triggered = list(filter(lambda it: it.message == f"{name} excedeu o limite mínimo!", self._alarm_message_controller.items.entries))

			if value > max_val:
				if len(max_triggered) == 0:
					self._alarm_message_controller.add_alarm_message(f"{name} excedeu o limite máximo!", "bad")
				return False

			if value < min_val:
				if len(min_triggered) == 0:
					self._alarm_message_controller.add_alarm_message(f"{name} excedeu o limite mínimo!", "bad")
				return False
		
		return True