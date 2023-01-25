#!/usr/bin/env python
# -*- coding: utf8 -*-

import sys
import os
import re
import json


class ActionScriptReader:

    types_to_fix = ["uint", "int"]
    class_pattern = re.compile(r"public\sclass\s(\w+)\s(?:extends\s(\w+)\s)?(?:implements\s([\w,\s]+))?")
    protocolId_pattern = re.compile(r"public\sstatic\sconst\sprotocolId:\w+\s=\s(\d+);")
    attribute_pattern = re.compile(r"public\svar\s(\w+):([\w.<>]+)(?:\s=\s(.*))?;")

    def __init__(self, file_name):
        self.file_name = file_name
        self.class_name = ""
        self.superclass = ""
        self.interfaces = []
        self.protocolId = ""
        self.attributes = {}

    def parse(self):

        with open(self.file_name, "r", encoding="utf8") as f:

            first_function_reached = False
            attributs_to_fix = []

            lines = f.readlines()
            for line in lines:

                class_match = self.class_pattern.search(line)
                if class_match:
                    self.class_name = class_match.group(1)
                    self.superclass = class_match.group(2)
                    self.interfaces = class_match.group(3)
                    if self.interfaces:
                        self.interfaces = self.interfaces.split(',')
                        self.interfaces = [x.strip() for x in self.interfaces]
                    else:
                        self.interfaces = []
                    continue

                protocolId_match = self.protocolId_pattern.search(line)
                if protocolId_match:
                    self.protocolId = protocolId_match.group(1)
                    continue

                attribute_match = self.attribute_pattern.search(line)
                if attribute_match:
                    self.attributes[attribute_match.group(1)] = attribute_match.group(2)
                    continue

                if "function" in line and not first_function_reached:
                    first_function_reached = True
                    attributs_to_fix = [key for key, value in self.attributes.items() if value in self.types_to_fix]
                    if len(attributs_to_fix) == 0:
                        break

                if len(attributs_to_fix):
                    write_method_pattern = re.compile(rf"output.write(\w+)\(this.{attributs_to_fix[0]}\);")
                    write_method_match = write_method_pattern.search(line)

                    if write_method_match:
                        self.attributes[attributs_to_fix[0]] = write_method_match.group(1)
                        attributs_to_fix.pop(0)

                        if len(attributs_to_fix) == 0:
                            break

        return {
            'file': self.file_name,
            'id': self.protocolId,
            'class_name': self.class_name,
            'superclass': self.superclass,
            'interfaces': self.interfaces,
            'attributes': self.attributes
        }


class NetworkActionScriptReader:

    ACTION_SCRIPT_FORMAT = ".as"
    INTERFACE_TO_IMPLEMENT = set(["INetworkMessage", "INetworkType"])

    def __init__(self, folder):
        self.folder = folder
        self.files = self.list_files(folder)

    def list_files(self, search_folder, format=ACTION_SCRIPT_FORMAT):
        print("Searching " + format + " files...")

        result = []
        for root, dirs, files in os.walk(search_folder):
            for name in files:
                if name.endswith((format)):
                    result.append(root + '/' + name)

        print(str(len(result)) + " files found !")
        return result

    def parse(self):
        print("Parsing files")
        
        results = {}
        for file in self.files:
            reader = ActionScriptReader(file)
            result = reader.parse()

            # If the class implements the wanted class
            if(self.INTERFACE_TO_IMPLEMENT & set(result['interfaces'])):
                class_name = result['class_name']
                result.pop('class_name')
                results[class_name] = result

        return results


def save_json(file_name, data):
    print("Saving json...")

    file = open(file_name, 'w')
    file.write(json.dumps(data, indent='\t'))
    file.close()

    print("Json saved !")


def main(search_folder, output_file):
    # List all the action script files
    reader = NetworkActionScriptReader(search_folder)
    # Build the dict
    data = reader.parse()
    # Save dict
    save_json(output_file, data)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
