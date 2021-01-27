#!/usr/bin/env python
# -*- coding: cp1252 -*-

import logger
import utils
import traceback
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


class DatabaseBuilder():

    def __init__(self, path, database_name, database_format='json', language='fr'):
        if language not in POSSIBLE_LANGUAGES:
            raise DatafusException('Language {} does not exist.'.format(language))

        if database_format not in POSSIBLE_FORMAT:
            raise DatafusException('Format {} does not exist.'.format(database_format))

        self.path = path
        self.database_format = database_format
        self.language = language

        self.database_file = self.get_file_name(database_name)

        self.builders = []
        self.builders.append(MonsterBuilder(language))
        self.builders.append(WeaponBuilder(language))
        self.builders.append(EquipmentBuilder(language))
        self.builders.append(SetBuilder(language))
        self.builders.append(PetBuilder(language))
        self.builders.append(MountBuilder(language))
        self.builders.append(ConsumableBuilder(language))
        self.builders.append(ResourceBuilder(language))
        self.builders.append(CeremonialItemBuilder(language))
        self.builders.append(SidekickBuilder(language))
        self.builders.append(IdolBuilder(language))
        self.builders.append(HarnessBuilder(language))

    def get_file_name(self, field_name):
        return '{}{}.{}.{}'.format(self.path, field_name, self.language, self.database_format)

    def build_database(self):
        logger.info('Building database...')
        self.build_files()
        self.merge_files()
        self.check_integrity()

    def build_files(self):
        logger.info('Building files...')
        for builder in self.builders:
            self.build_items(builder)

    def build_items(self, builder):
        data = builder.build()
        utils.save_json(self.get_file_name(builder.field_name), data)

    def merge_files(self):
        logger.info('Merging files...')
        self.create_database_file()
        self.remove_individual_files()

    def create_database_file(self):
        logger.info('Creating database file...')
        try:
            data = {}
            for builder in self.builders:
                data[builder.field_name] = utils.read_json(self.get_file_name(builder.field_name))
            utils.save_json(self.database_file, data)
        except DatafusException as e:
            logger.info(str(e))

    def remove_individual_files(self):
        logger.info('Removing individual files...')
        try:
            for builder in self.builders:
                utils.remove_json(self.get_file_name(builder.field_name))
        except DatafusException as e:
            logger.info(str(e))

    def check_integrity(self):
        logger.info('Checking database integrity...')
        try:
            data = utils.read_json(self.database_file)
            ok = True

            for builder in self.builders:

                # Check doublons
                doubles = utils.contains_double([item['url'] for item in data[builder.field_name]])
                if(len(doubles)):
                    logger.info('In {} : {} is in double'.format(builder.field_name, doubles))
                    ok = False

                # Check mandatory fields
                for item in data[builder.field_name]:
                    missing = []
                    empty = []

                    for mandatory_field in builder.mandatory_fields:

                        if(mandatory_field not in item):
                            missing.append(mandatory_field)

                        else:
                            if(item[mandatory_field] is None):
                                empty.append(mandatory_field)
                            elif(len(str(item[mandatory_field])) == 0):
                                empty.append(mandatory_field)

                    if(len(missing)):
                        logger.info('Fields {} are missing for {}'.format(missing, item['url']))

                    if(len(empty)):
                        logger.info('Fields {} are empty for {}'.format(empty, item['url']))

            if(ok):
                logger.info('Ok !')
            else:
                logger.info('Failed !')

        except DatafusException as e:
            logger.info(str(e))

    def split_database(self):
        logger.info('Spliting database...')
        self.create_individual_files()
        self.remove_database_file()

    def create_individual_files(self):
        logger.info('Creating individual files...')
        try:
            data = utils.read_json(self.database_file)
            for builder in self.builders:
                utils.save_json(self.get_file_name(builder.field_name), data[builder.field_name])
        except DatafusException as e:
            logger.info(str(e))

    def remove_database_file(self):
        logger.info('Removing database file...')
        try:
            utils.remove_json(self.database_file)
        except DatafusException as e:
            logger.info(str(e))

    def add_item(self, urls=None):
        if(urls is None):
            urls = [input("Url to parse : ")]
        data = utils.read_json(self.database_file)

        for url in urls:
            try:
                for builder in self.builders:
                    if builder.match(url):
                        break
                else:
                    logger.info('The url {} is not valid'.format(url))

                logger.info("Scrapping and adding {} to the database".format(url))
                item_data = builder.scrapper(url, self.language).scrap()
                data[builder.field_name].append(item_data)
            except DatafusException as e:
                logger.warning("Skipping {} for the following reason : {}".format(url, str(e)))
            except Exception as e:
                logger.warning("Skipping {} for the following reason : {}".format(url, str(e)))
                logger.error(e)

        utils.save_json(self.database_file, data)

    def remove_item(self, urls=None):
        if(urls is None):
            urls = [input("Url to parse : ")]
        data = utils.read_json(self.database_file)

        for url in urls:
            try:
                for builder in self.builders:
                    if builder.match(url):
                        break
                else:
                    logger.info('The url {} is not valid'.format(url))

                logger.info("Removing {} from the database".format(url))

                for item in data[builder.field_name]:
                    if item['url'] == url:
                        data[builder.field_name].remove(item)
                        break
                else:
                    logger.info('Coulnd\'t find the url {} in the database'.format(url))

            except Exception as e:
                logger.error(e)

        utils.save_json(self.database_file, data)

    def update_database(self):
        logger.info('Updating database...')
        try:
            data = utils.read_json(self.database_file)
            total_missing_urls = []
            total_deprecated_urls = []

            for builder in self.builders:
                logger.info('Retrieving {} urls...'.format(builder.field_name))
                remote_urls = builder.get_urls()
                locale_urls = [item['url'] for item in data[builder.field_name]]

                missing_urls = [url for url in remote_urls if url not in locale_urls]
                deprecated_urls = [url for url in locale_urls if url not in remote_urls]

                logger.info("Found {} remote {} and {} local ones".format(len(remote_urls), builder.field_name, len(locale_urls)))
                logger.info("{} {} are missing and will be added".format(len(missing_urls), builder.field_name))
                logger.info("{} {} are deprecated and will be removed".format(len(deprecated_urls), builder.field_name))

                total_missing_urls.extend(missing_urls)
                total_deprecated_urls.extend(deprecated_urls)

            if total_deprecated_urls:
                logger.info("Removing {} items from the database...".format(len(total_deprecated_urls)))
                self.remove_item(urls=total_deprecated_urls)

            if total_missing_urls:
                logger.info("Adding {} items to the database...".format(len(total_missing_urls)))
                self.add_item(urls=total_missing_urls)

            logger.info("The database is up to date !")

        except DatafusException as e:
            logger.info(str(e))

    def display_menu(self):
        logger.log("""
========== MENU ==========
(Selected language : {})

0)  Exit
1)  Build database
2)   └── Build files
3)        └── Monsters
4)        └── Weapons
5)        └── Equipments
6)        └── Sets
7)        └── Pets
8)        └── Mounts
9)        └── Consumables
10)       └── Resources
11)       └── Ceremonial items
12)       └── Sidekicks
13)       └── Idols
14)       └── Harnesses
15)  └── Merge files
16)       └── Create database file
17)       └── Remove individual files
18)  └── Check integrity
19) Split database
20)  └── Create individual files
21)  └── Remove database file
22) Add item
23) Remove item
24) Update database
==========================\n""".format(self.language))

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
                    self.build_items(MonsterBuilder(self.language))
                elif choise == '4':
                    self.build_items(WeaponBuilder(self.language))
                elif choise == '5':
                    self.build_items(EquipmentBuilder(self.language))
                elif choise == '6':
                    self.build_items(SetBuilder(self.language))
                elif choise == '7':
                    self.build_items(PetBuilder(self.language))
                elif choise == '8':
                    self.build_items(MountBuilder(self.language))
                elif choise == '9':
                    self.build_items(ConsumableBuilder(self.language))
                elif choise == '10':
                    self.build_items(ResourceBuilder(self.language))
                elif choise == '11':
                    self.build_items(CeremonialItemBuilder(self.language))
                elif choise == '12':
                    self.build_items(SidekickBuilder(self.language))
                elif choise == '13':
                    self.build_items(IdolBuilder(self.language))
                elif choise == '14':
                    self.build_items(HarnessBuilder(self.language))
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
                    logger.info('Choise {} does not exist'.format(choise))

            except Exception:
                traceback.print_exc()
            except KeyboardInterrupt:
                logger.info('\nYou interrupted the script')


if __name__ == "__main__":
    language = input("Language : ")
    databaseBuilder = DatabaseBuilder('../data/', 'dofus', language=language)
    databaseBuilder.build()
