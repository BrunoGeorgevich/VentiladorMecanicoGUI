#!/usr/bin/python
#-*- coding: utf-8 -*-

from PySide2.QtCore import QObject, Slot, Property, Signal

from Backend.Model.Person import Person

class PersonController(QObject):
	def __init__(self):
		super().__init__()

		self._person = Person()

	def parse_gender(self):
		gender = self._person.gender
		if gender == 'male':
			return "♂"
		if gender == 'female':
			return "♀"
		return "?"

	person_has_changed = Signal(Person)
	@Property(Person, notify=person_has_changed)
	def person(self):
		return self._person
	
	@Slot(result=str)
	def details(self):
		name = "Paciente" if self._person.name == "" else self._person.name
		gender = self.parse_gender()
		height = self._person.height
		return f"{name}, {gender}, {height} cm"