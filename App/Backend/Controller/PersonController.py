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
	
	@Slot(str, result=str)
	def details(self, predicted_weight):
		# name = "Paciente" if self._person.name == "" else self._person.name
		height = self._person.height
		gender = self.parse_gender()

		parsed_gender = "Homem"
		if gender == "female":
			parsed_gender = "Mulher"
		
		first_header = "Paciente"
		second_header = "Altura\tSexo\tPeso"
		third_header = f"{height} cm\t{parsed_gender}\t{predicted_weight} kg"

		return f"{first_header}\n{second_header}\n{third_header}"