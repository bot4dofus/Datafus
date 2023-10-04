#!/usr/bin/env python
# -*- coding: utf8 -*-

import sys
import os
import re
import json


class Attribute:
    TYPES_TO_FIX = ["uint", "int", "Number"]
    VECTOR_LIKE_TYPES = ["ByteArray"]

    def __init__(self, name, script_type, lines):
        self._has_type_id = False
        self._name = name
        self._script_type = script_type
        self._pattern = re.compile(rf"output.write(\w+)\(this.{name}|this.{name}\s=\snew\s{script_type}\((\d+),")
        self._type_id_pattern = re.compile(rf"output.write(\w+)\([\(]?this.{name}[a-zA-Z [_\]0-9]*[\)]?.getTypeId")

        for line in lines:
            is_match = self._type_id_pattern.search(line)
            if is_match:
                self._has_type_id = True
                break

        if ("Vector" in script_type):
            number_of_vectors = script_type.count("Vector")
            self._types = [None for i in range(number_of_vectors)]
            last_type = script_type[script_type.rfind('<')+1:script_type.find('>')]
            self._types.append(None if last_type in self.TYPES_TO_FIX else last_type)
        elif script_type in self.VECTOR_LIKE_TYPES:
            self._types = [None, None]
        else:
            self._types = [None if script_type in self.TYPES_TO_FIX else script_type]

        self._socket_type = None

    @property
    def name(self):
        return self._name

    @property
    def script_type(self):
        return self._script_type

    @property
    def pattern(self):
        return self._pattern

    @property
    def types(self):
        return self._types

    @property
    def socket_type(self):
        if (self._socket_type is None):
            self.buildSocketType()
        return self._socket_type

    def mustBeFixed(self):
        return None in self._types

    def addType(self, _type):
        try:
            index = self._types.index(None)
            self._types[index] = _type
            return True
        except ValueError:
            return False

    def buildSocketType(self):
        self._socket_type =  "TypeId<" + str(self._types[0]) + ">" if self._has_type_id and len(self._types) < 2 else str(self._types[0]) 
        for i in range(1, len(self._types)):
            self._socket_type = ("TypeIdVector<" if self._has_type_id else "Vector<") + self._socket_type + "," + str(self._types[i]) + ">"


class ActionScriptReader:

    RESET_FUNCTION = "function reset"
    class_pattern = re.compile(r"public\sclass\s(\w+)\s(?:extends\s(\w+)\s)?(?:implements\s([\w,\s]+))?")
    protocolId_pattern = re.compile(r"public\sstatic\sconst\sprotocolId:\w+\s=\s(\d+);")
    attribute_pattern = re.compile(r"public\svar\s(\w+):([\w.<>]+)(?:\s=\s(.*))?;")

    def __init__(self, file_name):
        self.file_name = file_name
        self.class_name = ""
        self.superclass = ""
        self.interfaces = []
        self.protocolId = ""
        self.attributes = []

    def parse(self):

        with open(self.file_name, "r", encoding="utf8") as f:

            reset_function_reached = False

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
                    self.attributes.append(Attribute(attribute_match.group(1), attribute_match.group(2), lines))
                    continue

                if self.RESET_FUNCTION in line and not reset_function_reached:
                    reset_function_reached = True
                    continue

                # If reset function reached
                if reset_function_reached:
                    # For each attribut
                    for attribute in self.attributes:
                        # If must be fixed
                        if (attribute.mustBeFixed()):
                            write_method_match = attribute.pattern.search(line)
                            # If the line match a regex
                            if write_method_match:
                                # Get first group
                                _type = write_method_match.group(1)
                                # If first group is None
                                if _type is None:
                                    # Get second group
                                    _type = write_method_match.group(2)
                                # Add the type to the types
                                attribute.addType(_type)
                                continue

        return {
            'file': self.file_name,
            'id': self.protocolId,
            'class_name': self.class_name,
            'superclass': self.superclass,
            'interfaces': self.interfaces,
            'attributes': self.attributesToDict()
        }

    def attributesToDict(self):
        result = {}
        # For each attribute
        for attribute in self.attributes:
            result[attribute.name] = attribute.socket_type
        return result


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

        print(str(len(result)) + " files found!")
        return result

    def parse(self):
        print("Parsing files")

        results = []
        for file in self.files:
            reader = ActionScriptReader(file)
            result = reader.parse()

            # If the class implements the wanted class
            if(self.INTERFACE_TO_IMPLEMENT & set(result['interfaces'])):
                results.append(result)

        print(f"{len(results)} events found!")
        return sorted(results, key=lambda t: t['class_name'])


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
