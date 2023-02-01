#!/usr/bin/env python
# -*- coding: cp1252 -*-

import sys
import os
import json


def load_json(file_name):
    print("Loading json...")

    if(not os.path.isfile(file_name)):
        raise Exception('File ' + file_name + ' does not exist. Build it first.')
    file = open(file_name, 'r')
    data = json.loads(file.read())
    file.close()

    print("Json loaded !")
    return data


def build_property(network_classes):
    print("Building properties...")

    properties = ""

    for class_name in network_classes:
        if 'id' in network_classes[class_name]:
            properties += class_name + "=" + network_classes[class_name]["id"] + "\n"
        else:
            properties += class_name + "=\n"

    return properties


def save_property(file_name, properties):
    print("Saving properties...")

    file = open(file_name, 'w')
    file.write(properties)
    file.close()

    print("Properties saved !")


def main(json_file, properties_file):

    # Build the data
    data = load_json(json_file)
    # Build the properties
    properties = build_property(data)
    # Save the properties
    save_property(properties_file, properties)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
