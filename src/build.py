#!/usr/bin/env python
# -*- coding: cp1252 -*-

import logger, utils, os, traceback
from exceptions.exceptions import DatafusException
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
            raise DatafusException('Language ' + language + ' does not exist.')

        if not database_format in POSSIBLE_FORMAT:
            raise DatafusException('Format ' + database_format + ' does not exist.')

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

        except DatafusException as e:
            logger.log(str(e))

    def remove_individual_files(self):
        logger.log('Removing individual files...')
        try:
            for builder in self.builders:
                utils.remove_json(self.get_file_name(builder.field_name))
        except DatafusException as e:
            logger.log(str(e))

    def check_integrity(self):
        logger.log('Checking database integrity...')
        try:
            data = utils.read_json(self.database_file)
            ok = True

            for builder in self.builders:

                #Check doublons
                doubles = utils.contains_double([item['url'] for item in data[builder.field_name]])
                if(len(doubles)):
                    logger.log('In ' + builder.field_name + ', ' + str(doubles) + ', are in doubles')
                    ok = False

                #Check mandatory fields
                for item in data[builder.field_name]:
                    missing = []
                    empty = []

                    for mandatory_field in builder.mandatory_fields:

                        if(mandatory_field not in item):
                            missing.append(mandatory_field)

                        else:
                            if(item[mandatory_field] == None):
                                empty.append(mandatory_field)
                            elif(len(str(item[mandatory_field])) == 0):
                                empty.append(mandatory_field)

                    if(len(missing)):
                        logger.log('Fields ' + str(missing) + ' are missing for ' + item['url'])

                    if(len(empty)):
                        logger.log('Fields ' + str(empty) + ' are empty for ' + item['url'])

            if(ok):
                logger.log('Ok !')
            else:
                logger.log('Failed !')

        except DatafusException as e:
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
            
        except DatafusException as e:
            logger.log(str(e))

    def remove_database_file(self):
        logger.log('Removing database file...')
        try:
            utils.remove_json(self.database_file)
        except DatafusException as e:
            logger.log(str(e))

    def add_item(self, urls=None):

        if(urls == None):
            urls = [input("Url to parse : ")]
                
        data = utils.read_json(self.database_file)
            
        for url in urls:
            try:
                for builder in self.builders:
                    if builder.match(url):
                        break
                else:
                    logger.log('The url ' + url + ' is not valid.')

                logger.log("Scrapping and adding " + url + " to the database.")
                item_data = builder.scrapper(url, self.language).scrap()
                data[builder.field_name].append(item_data)
                
            except DatafusException as e:
                logger.log(str(e))
            except Exception as e:
                traceback.print_exc()
                
        utils.save_json(self.database_file, data)

    def remove_item(self, urls=None):
        if(urls == None):
            urls = [input("Url to parse : ")]

        data = utils.read_json(self.database_file)
            
        for url in urls:
            try:
                for builder in self.builders:
                    if builder.match(url):
                        break
                else:
                    logger.log('The url ' + url + ' is not valid.')
                    
                logger.log("Removing " + url + " from the database.")
                
                for item in data[builder.field_name]:
                    if item['url'] == url:
                        data[builder.field_name].remove(item)
                        break
                else:
                    logger.log('Coulnd\'t find the url ' + url + ' in the database.')
                
            except DatafusException as e:
                logger.log(str(e))
            except Exception as e:
                traceback.print_exc()
                
        utils.save_json(self.database_file, data)
            
    def update_database(self):
        logger.log('Updating database...')
        try:
            data = utils.read_json(self.database_file)
            total_missing_urls = []
            total_deprecated_urls = []

            for builder in self.builders:
                logger.log('Retrieving ' + builder.field_name + ' urls...')
                remote_urls = builder.get_urls()
                locale_urls = [item['url'] for item in data[builder.field_name]]
                
                missing_urls = [url for url in remote_urls if not url in locale_urls]
                deprecated_urls = [url for url in locale_urls if not url in remote_urls]
                
                logger.log("Found " + str(len(remote_urls)) + " remote " + builder.field_name + " and " + str(len(locale_urls)) + " local ones")
                logger.log(str(len(missing_urls)) + " "  + builder.field_name + " are missing and will be added")
                logger.log(str(len(deprecated_urls)) + " " + builder.field_name + " are deprecated and will be removed")
        
                total_missing_urls.extend(missing_urls)
                total_deprecated_urls.extend(deprecated_urls)
            
            if total_deprecated_urls:
                logger.log("Removing " + str(len(total_deprecated_urls)) + " items from the database...")
                self.remove_item(urls=total_deprecated_urls)
                
            if total_missing_urls:
                logger.log("Adding " + str(len(total_missing_urls)) + " items to the database...")
                self.add_item(urls=total_missing_urls)
            
            logger.log("The database is up to date !")
        
        except DatafusException as e:
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
                    "23) Remove item\n" +
                    "24) Update database\n" +
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
                elif choise == '23':
                    self.remove_item()
                elif choise == '24':
                    self.update_database()
                else:
                    logger.log('Choise ' + choise + ' does not exist')

            except Exception:
                traceback.print_exc()
            except KeyboardInterrupt:
                logger.log('\nYou interrupted the script')

if __name__ == "__main__":
    language = input("Language : ")
    databaseBuilder = DatabaseBuilder('../data/', 'dofus', language=language)
    databaseBuilder.build()