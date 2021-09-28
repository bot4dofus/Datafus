#!/usr/bin/env python
# -*- coding: cp1252 -*-

import sys
import os
import re
import json

ACTION_SCRIPT_FORMAT = ".as"
SUPER_CLASS = "NetworkMessage"

CLASS_REGEX = "[\s]*public class (\w+) extends (\w+)"
ID_REGEX = "[\s]*public static const protocolId:uint = ([0-9]+);"
READER_REGEX = "[\s]*this.(\w+) = input.read(\w+)\(\);"


def list_files(search_folder, format=ACTION_SCRIPT_FORMAT):
    print("Searching " + format + " files...")

    result = []
    for root, dirs, files in os.walk(search_folder):
        for name in files:
            if name.endswith((format)):
                result.append(root + '/' + name)
                
    print(str(len(result)) + " files found !")
    return result


def build_json(files):
    print("Building json...")

    all_classes = {}
    # For each file
    for file in files:
        # Open the file
        f = open(file, encoding="utf-8")
        # For each line of the file
        for line in f.readlines():

            # Search regex
            class_match = re.match(CLASS_REGEX, line)
            # If regex match
            if(class_match):
                # Add the class to the dict
                all_classes[class_match.groups()[0]] = {
                    'file': file,
                    'superclass': class_match.groups()[1],
                    'attributs': {}
                }
                break

    network_classes = {}
    # For each class
    for class_name in all_classes.keys():
        # If subclass of NetworkMessage
        if(is_subclass_of(all_classes, class_name)):
            network_classes[class_name] = all_classes[class_name]

    # For each class
    for class_name in network_classes.keys():
        # Open the file
        f = open(network_classes[class_name]['file'], encoding="utf-8")
        # For each line of the file
        for line in f.readlines():

            # If line contains "protocolId"
            if("protocolId" in line):
                # Search regex
                id_match = re.match(ID_REGEX, line)
                # If regex match
                if(id_match):
                    # Save if
                    network_classes[class_name]['id'] = id_match.groups()[0]

            # Else
            else:
                # Search regex
                reader_match = re.match(READER_REGEX, line)
                # If regex match
                if(reader_match):
                    # Save attribut
                    network_classes[class_name]['attributs'][reader_match.groups()[0]] = reader_match.groups()[1]

    print(str(len(network_classes)) + " events found !")
    return network_classes


def is_subclass_of(dict, subclass, superclass=SUPER_CLASS):
    if(subclass in dict):
        if(dict[subclass]['superclass'] == superclass):
            return True
        else:
            return is_subclass_of(dict, dict[subclass]['superclass'])
    return False


def save_json(file_name, data):
    print("Saving json...")

    file = open(file_name, 'w')
    file.write(json.dumps(data))
    file.close()
    
    print("Json saved !")


def main(search_folder, output_file):
    # List all the action script files
    files = list_files(search_folder)
    # Build the dict
    data = build_json(files)
    # Save dict
    save_json(output_file, data)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
