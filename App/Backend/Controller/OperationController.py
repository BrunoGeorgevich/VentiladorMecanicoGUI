#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import QObject, Slot, Property, Signal

class OperationController(QObject):
	def __init__(self):
		super().__init__()