#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import QObject, Slot, Property, Signal, QThreadPool
from serial import Serial, SerialException
from platform import system
from time import time

from Backend.Concurrent.HardwareThread import HardwareThread

SERIAL_PATH = ""

if system() == 'Linux':
    SERIAL_PATH = "/dev/ttyUSB"
elif system() == 'Windows':
    SERIAL_PATH = "COM"

class HardwareController(QObject):
	
	new_data_arrived = Signal(str)

	def __init__(self, operation_mode_controller):
		super().__init__()
		
		self._thread_pool = QThreadPool()

		self._operation_mode_controller = operation_mode_controller
		usb_port = 0
        
		while True:
			try:
				self.__serial = Serial(f'{SERIAL_PATH}{usb_port}', 115200, timeout=0.25)
			except SerialException:
				usb_port += 1
				if usb_port > 100:
					self.__serial = None
					break
			else:
				print(f"CONNECTED WITH {SERIAL_PATH}{usb_port}")
		
				data = ""
				counter = 0
				timer = time()
				while counter < 10:
					self.__serial.write(b"CONNECT\n")
					ret = self.__serial.readline().strip().decode()
					if ret == "OK":
						data = ret
						break
					counter += 1

				if data == "OK":
					print(f"{SERIAL_PATH}{usb_port} CONNECTION WAS SUCCESSFULLY!")
					break
				else:
					print(f"{SERIAL_PATH}{usb_port} DO NOT REPLY CORRECTLY, TRYING ONE MORE!")

		if self.__serial is None:
			print(f"[UNABLE TO CONNECT WITH ARDUINO!!!]")
			self.__hardware_is_connected = False
		else:
			self.__hardware_is_connected = True
			self.restart_thread()
	
	def __del__(self):
		self.__hardware_is_connected = False

	@Slot(str, str)
	def write_data(self, command, key):
		if self.hardware_is_connected is not True:
			print("NO HARDWARE CONNECTED!")
			return

		if (command == "SET ALL"):
			message = "SET$"
			params = self._operation_mode_controller.operation_mode.parameters
			for k in params:
				v = params[k]
				if (k == "sensiT"):
					v = 1 if v == "pressure" else 0
				message = f"{message}{k}:{v},"

			message = f"{message}op:{self._operation_mode_controller.get_mode_parsed()}%\n".upper()

			print(f"SEND TO ARDUINO => {message}")
			self.__serial.write(message.encode())
		
		if (command == "SET"):
			message = f"SET${key}:{self._operation_mode_controller.get_parameter(key)}%\n".upper()
			print(f"SEND TO ARDUINO => {message}")
			self.__serial.write(message.encode())
		
		if (command == "START"):
			message = "START"
			print(f"SEND TO ARDUINO => {message}")
			self.__serial.write(message.encode())
		
		if (command == "STOP"):
			message = "STOP"
			print(f"SEND TO ARDUINO => {message}")
			self.__serial.write(message.encode())


	def read_data(self):
		data = self.__serial.readline()
		data = data.decode("utf-8")
		if len(data) > 0 and self.__hardware_is_connected:
			return data
	
	@Slot(str)
	def send_data(self, result):
		self.new_data_arrived.emit(result)

	def restart_thread(self):
		hardware_thread = HardwareThread(fn=self.read_data, parent=self)
		hardware_thread.signals.result.connect(self.send_data)
		hardware_thread.signals.finished.connect(self.restart_thread)
		
		self._thread_pool.start(hardware_thread)

	hardware_is_connected_changed = Signal(bool)
	@Property(bool, notify=hardware_is_connected_changed)
	def hardware_is_connected(self): return self.__hardware_is_connected
	@hardware_is_connected.setter
	def set_hardware_is_connected(self, value): 
		self.__hardware_is_connected = value
		self.hardware_is_connected_changed.emit(value)