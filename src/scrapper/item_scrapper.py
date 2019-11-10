#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from scrapper.base_scrapper import BaseScrapper

FIELD_NAMES = {
	'fr':{
		'description': 'Description',								# https://www.dofus.com/fr/mmorpg/encyclopedia/equipment/14170-bzzzinga-headband
		'effects': 'Effets',										# https://www.dofus.com/fr/mmorpg/encyclopedia/equipment/14170-bzzzinga-headband
		'conditions': 'Conditions',									# https://www.dofus.com/fr/mmorpg/encyclopedia/pets/12541-madreggon
		'characteristics': 'Caractéristiques',						# https://www.dofus.com/fr/mmorpg/encyclopedia/mounts/41-almond-crimson-dragoturkey
		'evolutionary_effects': 'Effets évolutifs',					# https://www.dofus.com/fr/mmorpg/encyclopedia/pets/12541-madreggon
		'bonuses': 'Bonus',											# https://www.dofus.com/fr/mmorpg/encyclopedia/idols/51-djim
		'spells': 'Sorts',											# https://www.dofus.com/fr/mmorpg/encyclopedia/idols/51-djim
		'resistances': 'Résistances',								# https://www.dofus.com/fr/mmorpg/encyclopedia/monsters/982-acrocat
		'set_bonuses': 'Bonus de la panoplie',						# https://www.dofus.com/fr/mmorpg/encyclopedia/sets/346-rassler-set
		'set_total_bonuses': 'Bonus total de la panoplie complète',	# https://www.dofus.com/fr/mmorpg/encyclopedia/sets/346-rassler-set
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
	}
}

class ItemScrapper(BaseScrapper):

	def __init__(self, url, language):
		super().__init__()
		self.url = url
		self.soup = self.requests(url)
		self.fields = FIELD_NAMES[language]

	def get_id_from_url(self, url):
		try:
			trailer = url[url.rfind('/')+1:]
			return trailer[:trailer.find('-')]
		except Exception:
			logger.warning('Cannot get id for ' + url)
			return None

	def get_id(self):
		return self.get_id_from_url(self.url)

	def get_name(self):
		try:
			return self.soup.findAll("h1", {"class": "ak-return-link"})[0].get_text().strip().replace('\n', ' ')
		except Exception:
			logger.warning('Cannot get name for ' + self.url)
			return None

	def get_picture(self):

		try:
			img = self.soup.findAll("div", {"class": "ak-encyclo-detail-illu"})[0].img

			if(img.has_attr('src')):
				url = img['src']
			else:
				url = img['data-src']

			if('..' in url):
				return self.STATIC_DOMAIN + url[url.rfind('..')+2:]
			else:
				return url
		except Exception:
			logger.warning('Cannot get picture for ' + self.url)
			return None

	def get_type(self):
		try:
			element = self.soup.findAll("div", {"class": "ak-encyclo-detail-type"})[0]
			if(element.has_attr('span')):
				text = element.span.get_text().strip().replace('\n', ' ')
			else:
				text = element.get_text().strip().replace('\n', ' ')
			return text[text.find(':')+2:]
		except Exception:
			logger.warning('Cannot get type for ' + self.url)
			return None

	def get_level(self):
		try:
			text = self.soup.findAll("div", {"class": "ak-encyclo-detail-level"})[0].get_text().strip()
			return text[text.find(':')+2:]
		except Exception:
			logger.warning('Cannot get level for ' + self.url)
			return None

	###########
	# CONTENT #
	###########

	def get_text(self, node, name):
		try:
			return node.findAll("div", {"class": "ak-panel-content"})[0].get_text().strip().replace('\n', ' ')
		except Exception:
			logger.warning('Cannot get ' + name + ' for ' + self.url)
			return None

	def get_array(self, node, name):

		try:
			elements = node.findAll("div", {"class", "ak-title"})

			effects = []
			for element in elements:
				effects.append(element.get_text().strip().replace('\n', ' '))

			return effects

		except Exception:
			logger.warning('Cannot get ' + name + ' for ' + self.url)
			return None

	def get_contents(self, class_name):
		
		try:
			description = None
			effects = None
			conditions = None
			characteristics = None
			evolutionary_effects = None
			bonuses = None
			spells = None
			resistances = None
			set_bonuses = None
			set_total_bonuses = None

			block = self.soup.findAll("div", {"class": class_name})[0]
			titles = block.findAll("div", {"class": "ak-panel-title"})

			for title in titles:
				striped_title = title.get_text().strip()

				if '{' in striped_title:
					striped_title = striped_title[:striped_title.find('{')]

				if striped_title == self.fields['description']:
					description = self.get_text(title.parent, 'description')
				elif striped_title == self.fields['effects']:
					effects = self.get_array(title.parent, 'effects')
				elif striped_title == self.fields['conditions']:
					conditions = self.get_array(title.parent, 'conditions')
				elif striped_title == self.fields['characteristics']:
					characteristics = self.get_array(title.parent, 'characteristics')
				elif striped_title == self.fields['evolutionary_effects']:
					evolutionary_effects = self.get_array(title.parent, 'evolutionary_effects')
				elif striped_title == self.fields['bonuses']:
					bonuses = self.get_array(title.parent, 'bonuses')
				elif striped_title == self.fields['spells']:
					spells = self.get_text(title.parent, 'spells')
				elif striped_title == self.fields['resistances']:
					resistances = self.get_array(title.parent, 'resistances')
				elif striped_title == self.fields['set_bonuses']:
					set_bonuses = self.get_array(title.parent, 'set_bonuses')
				elif striped_title == self.fields['set_total_bonuses']:
					set_total_bonuses = self.get_array(title.parent, 'set_total_bonuses')

			return description, effects, conditions, characteristics, evolutionary_effects, bonuses, spells, resistances, set_bonuses, set_total_bonuses

		except Exception:
			logger.warning('Cannot get contents for ' + self.url)
			return None, None, None, None, None, None, None, None, None, None


	##########
	# RECIPE #
	##########

	def get_craft(self):

		try:
			blocks = self.soup.findAll("div", {"class": "ak-crafts"})

			if(not len(blocks)):
				return None
			
			craft = []
			items = blocks[0].findAll("div", {"class", "ak-list-element"})

			for item in items:

				quantity = item.findAll("div", {"class", "ak-front"})[0].get_text().strip()
				url = item.findAll("a")[0]['href']
				type_ = item.findAll("div", {"class", "ak-text"})[0].get_text().strip()

				craft.append({
					'url': self.DOMAIN + url,
					'id':self.get_id_from_url(url),
					'type':type_,
					'quantity':quantity[:quantity.find(' ')]
					})
			return craft

		except Exception:
			logger.warning('Cannot get crafts for ' + self.url)
			return None

	#########
	# SCRAP #
	#########

	def scrap(self, class_name):
		data = {
				'url':self.url,
				'id':self.get_id(),
				'name':self.get_name(),
				'img':self.get_picture(),
				'type':self.get_type(),
				'level':self.get_level(),
			}
		description, effects, conditions, characteristics, evolutionary_effects, bonuses, spells, resistances, set_bonuses, set_total_bonuses = self.get_contents(class_name)
		craft = self.get_craft()

		if description:
			data['description'] = description

		if effects:
			data['effects'] = effects
			
		if conditions:
			data['conditions'] = conditions
			
		if characteristics:
			data['characteristics'] = characteristics

		if evolutionary_effects:
			data['evolutionary_effects'] = evolutionary_effects

		if bonuses:
			data['bonuses'] = bonuses

		if spells:
			data['spells'] = spells

		if resistances:
			data['resistances'] = resistances

		if set_bonuses:
			data['set_bonuses'] = set_bonuses

		if set_total_bonuses:
			data['set_total_bonuses'] = set_total_bonuses

		if craft:
			data['craft'] = craft

		return data
