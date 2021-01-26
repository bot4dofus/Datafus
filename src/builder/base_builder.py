#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import logger
from scrapper.list_scrapper import ListScrapper
from exceptions.exceptions import DatafusException


class BaseBuilder():

    def __init__(self, url, field_name, scrapper, language, mandatory_fields):
        super().__init__()
        self._url = url
        self._field_name = field_name
        self._scrapper = scrapper
        self._language = language
        self._mandatory_fields = mandatory_fields

    @property
    def url(self):
        return self._url

    @property
    def field_name(self):
        return self._field_name

    @property
    def scrapper(self):
        return self._scrapper

    @property
    def language(self):
        return self._language

    @property
    def mandatory_fields(self):
        return self._mandatory_fields

    def match(self, url):
        return self.url in url

    def get_urls(self):
        ls = ListScrapper(self._url)
        return ls.scrap()

    def build(self):
        logger.log('Building {} :'.format(self._field_name))

        data = []
        urls = self.get_urls()

        for i in range(len(urls)):
            logger.log('Scrapping {} {}/{}'.format(self._field_name, i+1, len(urls)))
            try:
                scrapper = self._scrapper(urls[i], self._language)
                data.append(scrapper.scrap())
            except DatafusException as e:
                logger.warning("Skipping {} for the following reason : {}".format(urls[i], str(e)))
            except Exception as e:
                logger.warning("Skipping {} for the following reason : {}".format(urls[i], str(e)))
                logger.error(e)

        return data
