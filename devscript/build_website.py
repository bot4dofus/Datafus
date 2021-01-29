#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import json


def read_json(file_name):
    if(not os.path.isfile(file_name)):
        raise Exception('File ' + file_name + ' does not exist. Build it first.')

    print("Reading data from " + file_name, flush=True)
    file = open(file_name, 'r')
    data = json.loads(file.read())
    file.close()
    return data

def save_json(file_name, data):
    print("Saving data to " + file_name, flush=True)
    file = open(file_name, 'w')
    file.write(json.dumps(data))
    file.close()

def find_language(file):
    splited = file.split('.')
    return splited[len(splited)-2]

def build_website(input_folder, output_folder):
    if input_folder[len(input_folder)-1] != '/':
        raise Exception('The input folder path must end by "/".')

    if output_folder[len(output_folder)-1] != '/':
        raise Exception('The output folder path must end by "/".')

    os.makedirs(output_folder)

    for file in os.listdir(input_folder):
        absolute_path = input_folder + file
        data = read_json(absolute_path)
        language = find_language(absolute_path)

        os.makedirs(output_folder + language + "/")

        for category in data:
            file = output_folder + language + "/" + category
            save_json(file, data[category])

            os.makedirs(output_folder + language + "/" + category[:-1])

            for item in data[category]:
                file = output_folder + language + "/" + category[:-1] + "/" + str(item['id'])
                save_json(file, item)


if __name__ == "__main__":
    build_website(sys.argv[1], sys.argv[2])
