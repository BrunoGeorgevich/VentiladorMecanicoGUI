#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import QObject, Slot, Property, Signal

class DashboardController(QObject):

	data_incomplete = Signal(str)
	data_complete = Signal("QVariant")

	def __init__(self, hardware_controller):
		super().__init__()
		self._hardware_controller = hardware_controller
		self._hardware_controller.new_data_arrived.connect(self.parse_data)

	@Slot(str)
	def parse_data(self, data):
		data = data.strip()
		
		print(f"RECEIVED FROM ARDUINO => {data}")

		if len(data) <= 0:
			return
		
		if data == "OK":
			return

		if data[0] != "$" or data[-1] != "%":
			self.data_incomplete.emit(data)
			return
		
		values = data.replace("$", "").replace("%", "").split(",")
		values_dict = {}

		for it in values:
			key, val = it.split(":")
			values_dict[key] = val
		
		self.data_complete.emit(values_dict)

