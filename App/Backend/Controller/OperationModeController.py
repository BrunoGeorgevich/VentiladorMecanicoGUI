#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import QObject, Slot, Property, Signal

from Backend.Model.OperationMode import OperationMode

class OperationModeController(QObject):
	def __init__(self):
		super().__init__()
		self._operation_mode = OperationMode()

	operation_mode_has_changed = Signal(OperationMode)
	@Property(OperationMode, notify=operation_mode_has_changed)
	def operation_mode(self):
		return self._operation_mode
	
	@Slot(str)
	def set_mode(self, mode):
		if self._operation_mode.mode != mode:
			self._operation_mode.mode = mode
			self._operation_mode.init_parameters()

	@Slot(str, "QVariant")
	def add_parameter(self, name, value):
		self._operation_mode.parameters[name] = value