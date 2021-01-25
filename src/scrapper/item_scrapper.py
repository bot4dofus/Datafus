#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger, utils
from scrapper.base_scrapper import BaseScrapper

FIELD_NAMES = {
    'fr':{
        'description': 'Description',                                # https://www.dofus.com/en/mmorpg/encyclopedia/equipment/14170-bzzzinga-headband
        'effects': 'Effets',                                        # https://www.dofus.com/en/mmorpg/encyclopedia/equipment/14170-bzzzinga-headband
        'conditions': 'Conditions',                                    # https://www.dofus.com/en/mmorpg/encyclopedia/pets/12541-madreggon
        'characteristics': 'Caractéristiques',                        # https://www.dofus.com/en/mmorpg/encyclopedia/mounts/41-almond-crimson-dragoturkey
        'evolutionary_effects': 'Effets évolutifs',                    # https://www.dofus.com/en/mmorpg/encyclopedia/pets/12541-madreggon
        'bonuses': 'Bonus',                                            # https://www.dofus.com/en/mmorpg/encyclopedia/idols/51-djim
        'spells': 'Sorts',                                            # https://www.dofus.com/en/mmorpg/encyclopedia/idols/51-djim
        'resistances': 'Résistances',                                # https://www.dofus.com/en/mmorpg/encyclopedia/monsters/982-acrocat
        'set_bonuses': 'Bonus de la panoplie',                        # https://www.dofus.com/en/mmorpg/encyclopedia/sets/346-rassler-set
        'set_total_bonuses': 'Bonus total de la panoplie complète',    # https://www.dofus.com/en/mmorpg/encyclopedia/sets/346-rassler-set
        'craft' : 'Recette',
        'set' : 'fait partie de la',
    },
    'en':{
        'description': 'Description',
        'effects': 'Effects',
        'conditions': 'Conditions',
        'characteristics': 'Characteristics',
        'evolutionary_effects': 'Evolution Effects',
        'bonuses': 'Bonus',
        'spells': 'Spells',
        'resistances': 'Resistances',
        'set_bonuses': 'Set Bonus',
        'set_total_bonuses': 'Complete Set Bonus',
        'craft' : 'Recipe',
        'set' : 'is part of the',
    },
    'de':{
        'description': 'Beschreibung',
        'effects': 'Wirkungen',
        'conditions': 'Voraussetzungen',
        'characteristics': 'Eigenschaften',
        'evolutionary_effects': 'Evolutionäre Wirkungen',
        'bonuses': 'Bonus',
        'spells': 'Zauber',
        'resistances': 'Resistenz',
        'set_bonuses': 'Setbonus',
        'set_total_bonuses': 'Gesamtbonus des vollständigen Sets',
        'craft' : 'Rezeptur',
        'set' : 'ist teil des',
    },
    'es':{
        'description': 'Descripción',
        'effects': 'Efectos',
        'conditions': 'Condiciones',
        'characteristics': 'Características',
        'evolutionary_effects': 'Efectos evolutivos',
        'bonuses': 'Bonus',
        'spells': 'Hechizos',
        'resistances': 'Resistencias',
        'set_bonuses': 'Bonus de set',
        'set_total_bonuses': 'Bonus total del set completo',
        'craft' : 'Receta',
        'set' : 'forma parte del',
    },
    'it':{
        'description': 'Descrizione',
        'effects': 'Effetti',
        'conditions': 'Condizioni',
        'characteristics': 'Caratteristiche',
        'evolutionary_effects': 'Effetti evolutivi',
        'bonuses': 'Bonus',
        'spells': 'Incantesimi',
        'resistances': 'Resistenze',
        'set_bonuses': 'Bonus della panoplia',
        'set_total_bonuses': 'Bonus totale della panoplia completa',
        'craft' : 'Ricetta',
        'set' : 'fa parte di',
    },
    'pt':{
        'description': 'Descrição',
        'effects': 'Efeitos',
        'conditions': 'Condições',
        'characteristics': 'Características',
        'evolutionary_effects': 'Efeitos evolutivos',
        'bonuses': 'Bônus',
        'spells': 'Feitiços',
        'resistances': 'Resistências',
        'set_bonuses': 'Bônus do conjunto',
        'set_total_bonuses': 'Bônus total do conjunto completo',
        'craft' : 'Receita',
        'set' : 'faz parte do',
    }
}

class ItemScrapper(BaseScrapper):

    ###########
    # BUILDER #
    ###########

    def __init__(self, url, language):
        super().__init__(url)
        self.soup = self.requests(url)
        self.fields = FIELD_NAMES[self.get_language_from_url(url)]

    #############
    # MANDATORY #
    #############

    def get_id(self):
        return self.get_id_from_url(self.url)

    def get_name(self):
        return self.soup.findAll("h1", {"class": "ak-return-link"})[0].get_text().strip().replace('\n', ' ')

    def get_picture(self):
        img = self.soup.findAll("div", {"class": "ak-encyclo-detail-illu"})[0].img

        if(img.has_attr('src')):
            url = img['src']
        else:
            url = img['data-src']

        if('..' in url):
            return self.STATIC_DOMAIN + url[url.rfind('..')+2:]
        else:
            return url

    def get_type(self):
        element = self.soup.findAll("div", {"class": "ak-encyclo-detail-type"})[0]
        if(element.has_attr('span')):
            text = element.span.get_text().strip().replace('\n', ' ')
        else:
            text = element.get_text().strip().replace('\n', ' ')
        return text[text.find(':')+2:].strip()

    ################
    # NON OPTIONAL #
    ################

    def get_level(self):
        text = self.soup.findAll("div", {"class": "ak-encyclo-detail-level"})[0].get_text().strip().replace('  ', ' ')
        return text[text.find(':')+2:]

    def get_description(self):
        block = self.get_block('description')
        return self.get_text(block)

    ############
    # OPTIONAL #
    ############

    def get_effects(self):
        block = self.get_block('effects')
        if(block):
            return self.get_array(block)
        else:
            return None

    def get_conditions(self):
        block = self.get_block('conditions')
        if(block):
            return self.get_text(block)
        else:
            return None

    def get_characteristics(self):
        block = self.get_block('characteristics')
        if(block):
            return self.get_array(block)
        else:
            return None

    #Weapons, Equipments, Consumables, Resources, Ceremonial items, Idols, Harnesses
    def get_craft(self):
        block = self.get_block('craft')
        if(not block):
            return None
            
        craft = []
        items = block.findAll("div", {"class", "ak-list-element"})

        for item in items:

            quantity = item.findAll("div", {"class", "ak-front"})[0].get_text().strip()
            url = item.findAll("a")[0]['href']

            craft.append({
                'url': self.DOMAIN + url,
                'quantity':int(quantity[:quantity.find(' ')])
                })
        return craft

    #Weapons and Equipments
    def get_set(self):
        block = self.get_block('set')
        if(block):
            return self.DOMAIN + block.findAll("a")[0]['href']
        else:
            return None

    ###########
    # GENERAL #
    ###########

    def get_text(self, node):
        return node.findAll("div", {"class": "ak-panel-content"})[0].get_text().strip().replace('\n', ' ')

    def get_array(self, node):
        effects = []
        elements = node.findAll("div", {"class", "ak-title"})
        for element in elements:
            effects.append(element.get_text().strip().replace('\n', ' '))
        return effects

    def get_block(self, block_name):
        blocks = self.soup.findAll("span", {"class": "ak-panel-title-icon"})
        for block in blocks:
            if block_name != "set":
                if self.fields[block_name] == block.parent.get_text().strip():
                    return block.parent.parent
            else:
                if self.fields[block_name] in block.parent.get_text():
                    return block.parent.parent
            
        return None

    #########
    # SCRAP #
    #########

    def scrap(self):
        return {
                'url':self.url,
                'id':self.get_id(),
                'name':self.get_name(),
                'img':self.get_picture(),
                'type':self.get_type(),
            }
