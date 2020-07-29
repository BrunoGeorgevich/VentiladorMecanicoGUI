#!/usr/bin/python
#-*- coding: utf-8 -*-

from Backend.Controller.AlarmController import AlarmController
from Backend.Controller.PersonController import PersonController
from Backend.Controller.HardwareController import HardwareController
from Backend.Controller.DashboardController import DashboardController
from Backend.Controller.OperationModeController import OperationModeController

from PySide2.QtCore import QObject, Slot, Property, Signal

class System(QObject):
	def __init__(self):
		super().__init__()
		self._alarm_controller = AlarmController()

		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "good")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "bad")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "info")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "good")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "bad")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "info")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "good")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "bad")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "info")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "good")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "bad")
		self._alarm_controller.add_alarm("asd asd ahsadui ahsuid hasiuas hiudasias iudhaisu diashdiuashiud aia isudiuashiu hiais iud idhs a", "info")

		self._person_controller = PersonController()
		self._operation_mode_controller = OperationModeController()
		self._hardware_controller = HardwareController(self._operation_mode_controller)
		self._dashboard_controller = DashboardController(self._hardware_controller)

	# Getters and Setters

	alc_has_changed = Signal(AlarmController)
	@Property(AlarmController, notify=alc_has_changed)
	def alarm_controller(self, ): return self._alarm_controller

	hwc_has_changed = Signal(HardwareController)
	@Property(HardwareController, notify=hwc_has_changed)
	def hardware_controller(self, ): return self._hardware_controller

	psc_has_changed = Signal(PersonController)
	@Property(PersonController, notify=psc_has_changed)
	def person_controller(self, ): return self._person_controller

	opc_has_changed = Signal(OperationModeController)
	@Property(OperationModeController, notify=opc_has_changed)
	def operation_mode_controller(self, ): return self._operation_mode_controller

	dbc_has_changed = Signal(DashboardController)
	@Property(DashboardController, notify=dbc_has_changed)
	def dashboard_controller(self, ): return self._dashboard_controller
