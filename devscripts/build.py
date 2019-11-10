#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger, utils, os
from builder.monster_builder import MonsterBuilder
from builder.weapon_builder import WeaponBuilder
from builder.equipment_builder import EquipmentBuilder
from builder.set_builder import SetBuilder
from builder.pet_builder import PetBuilder
from builder.mount_builder import MountBuilder
from builder.consumable_builder import ConsumableBuilder
from builder.resource_builder import ResourceBuilder
from builder.ceremonial_item_builder import CeremonialItemBuilder
from builder.sidekick_builder import SidekickBuilder
from builder.idol_builder import IdolBuilder
from builder.harness_builder import HarnessBuilder

POSSIBLE_LANGUAGES = ['fr', 'en', 'de', 'es', 'it', 'pt']
POSSIBLE_FORMAT = ['json']

BUILDERS = [
	MonsterBuilder,
	WeaponBuilder,
	EquipmentBuilder,
	SetBuilder,
	PetBuilder,
	MountBuilder,
	ConsumableBuilder,
	ResourceBuilder,
	CeremonialItemBuilder,
	SidekickBuilder,
	IdolBuilder,
	HarnessBuilder
]

class DatabaseBuilder():

	def __init__(self, path, database_name, database_format='json', language='fr'):
		if not language in POSSIBLE_LANGUAGES:
			raise Exception('Language ' + language + ' does not exist.')

		if not database_format in POSSIBLE_FORMAT:
			raise Exception('Format ' + database_format + ' does not exist.')

		self.path = path
		self.database_format = database_format
		self.language = language

		self.database_file = self.get_file_name(database_name)

		self.builders = []
		for builder in BUILDERS:
			self.builders.append(builder(language))

	def get_file_name(self, field_name):
		return self.path + field_name + '.' + self.language + '.' + self.database_format

	def build_database(self):
		logger.log('Building database...')
		self.build_files()
		self.merge_files()
		self.check_integrity()

	def build_files(self):
		logger.log('Building files...')

		for builder in BUILDERS:
			self.build_items(builder)

	def build_items(self, builderClass):

		for builder in self.builders:
			if(isinstance(builder, builderClass)):
				break
		data = builder.build()
		utils.save_json(self.get_file_name(builder.field_name), data)

	def merge_files(self):
		logger.log('Merging files...')
		self.create_database_file()
		self.remove_individual_files()

	def create_database_file(self):
		logger.log('Creating database file...')
		try:
			data = {}
			for builder in self.builders:
				data[builder.field_name] = utils.read_json(self.get_file_name(builder.field_name))
			utils.save_json(self.database_file, data)

		except Exception as e:
			logger.log(str(e))

	def remove_individual_files(self):
		logger.log('Removing individual files...')

		for builder in self.builders:
			os.remove(self.get_file_name(builder.field_name))

	def check_integrity(self):
		logger.log('Checking database integrity...')
		try:
			data = utils.read_json(self.database_file)
			ok = True

			for builder in self.builders:
				if len(data[builder.field_name]) != builder.nb:
					logger.log('Got ' + str(len(data[builder.field_name])) + ' ' + builder.field_name + ', expected ' + str(builder.nb))
					ok = False

				doubles = utils.contains_double([item['url'] for item in data[builder.field_name]])
				if(len(doubles)):
					logger.log('In ' + builder.field_name + ', ' + str(doubles) + ', are in doubles')
					ok = False

			if(ok):
				logger.log('Ok !')
			else:
				logger.log('Failed !')

		except Exception as e:
			logger.log(str(e))

	def split_database(self):
		logger.log('Spliting database...')
		self.create_individual_files()
		self.remove_database_file()

	def create_individual_files(self):
		logger.log('Creating individual files...')

		try:
			data = utils.read_json(self.database_file)

			for builder in self.builders:
				utils.save_json(self.get_file_name(builder.field_name), data[builder.field_name])
			
		except Exception as e:
			logger.log(str(e))

	def remove_database_file(self):
		logger.log('Removing database file...')
		os.remove(self.database_file)

	def add_item(self):

		try:
			url = input("Url to parse : ")
			for builder in self.builders:
				if builder.match(url):
					break

			else:
				raise Exception('This url is not valid.')

			item_data = builder.scrapper(url).scrap()
			data = utils.read_json(self.database_file)
			data[builder.field_name].append(item_data)
			utils.save_json(self.database_file, data),
		except Exception as e:
			logger.log(str(e))

	def display_menu(self):
		logger.log("\n========== MENU ==========\n" +
					"(Selected language : " + self.language + ')\n\n'+
					"0)  Exit\n" +
					"1)  Build database\n" +
					"2)   └── Build files\n" +
					"3)        └── Monsters\n" +
					"4)        └── Weapons\n" +
					"5)        └── Equipments\n" +
					"6)        └── Sets\n" +
					"7)        └── Pets\n" +
					"8)        └── Mounts\n" +
					"9)        └── Consumables\n" +
					"10)       └── Resources\n" +
					"11)       └── Ceremonial items\n" +
					"12)       └── Sidekicks\n" +
					"13)       └── Idols\n" +
					"14)       └── Harnesses\n" +
					"15)  └── Merge files\n" +
					"16)       └── Create database file\n" +
					"17)       └── Remove individual files\n" +
					"18)  └── Check integrity\n" +
					"19) Split database\n" +
					"20)  └── Create individual files\n" +
					"21)  └── Remove database file\n" +
					"22) Add item\n" +
					"==========================\n")	

	def build(self):
		
		while True:
			self.display_menu()
			choise = input("Choise : ")

			try:
				if choise == '0':
					break
				elif choise == '1':
					self.build_database()
				elif choise == '2':
					self.build_files()
				elif choise == '3':
					self.build_items(MonsterBuilder)
				elif choise == '4':
					self.build_items(WeaponBuilder)
				elif choise == '5':
					self.build_items(EquipmentBuilder)
				elif choise == '6':
					self.build_items(SetBuilder)
				elif choise == '7':
					self.build_items(PetBuilder)
				elif choise == '8':
					self.build_items(MountBuilder)
				elif choise == '9':
					self.build_items(ConsumableBuilder)
				elif choise == '10':
					self.build_items(ResourceBuilder)
				elif choise == '11':
					self.build_items(CeremonialItemBuilder)
				elif choise == '12':
					self.build_items(SidekickBuilder)
				elif choise == '13':
					self.build_items(IdolBuilder)
				elif choise == '14':
					self.build_items(HarnessBuilder)
				elif choise == '15':
					self.merge_files()
				elif choise == '16':
					self.create_database_file()
				elif choise == '17':
					self.remove_individual_files()
				elif choise == '18':
					self.check_integrity()
				elif choise == '19':
					self.split_database()
				elif choise == '20':
					self.create_individual_files()
				elif choise == '21':
					self.remove_database_file()
				elif choise == '22':
					self.add_item()
				else:
					logger.log('Choise ' + choise + 'does not exist')

			except KeyboardInterrupt:
				logger.log('\nYou interrupted the script')

if __name__ == "__main__":
	language = input("Language : ")
	databaseBuilder = DatabaseBuilder('../data/', 'dofus', language=language)
	databaseBuilder.build()