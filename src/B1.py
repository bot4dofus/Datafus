import struct
import json
import sys
import os

VERBOSE = 0

def log(log):
    if(VERBOSE > 0):
        print(log)

def save_file(file_name, data):
    file = open(file_name, 'w')
    file.write(json.dumps(data))
    file.close()

class D2OReader():

    FORMAT = b'D2O'
    
    def __init__(self, file):
        self.fieldType = {
            -1  :self.readInt,
            -2  :self.readBool,
            -3  :self.readUtf,
            -4  :self.readDouble,
            -5  :self.readI18N,
            -6  :self.readUint,
            -99 :self.readList
        }
        self.file = file
        self.offset = 0
        self.classes = {}
        with open(file, "rb") as f:
            self.data = f.read()
            log(self.data)

    def readBytes(self, size):
        r = self.data[self.offset: self.offset+size]
        self.offset += size
        log(r)
        return r

    def seek(self, offset):
        self.offset = offset

    def readMagic(self):
        return self.readBytes(3)

    def readInt(self):
        r = struct.unpack('>i', self.readBytes(4))
        return r[0]

    def readUint(self):
        r = struct.unpack('>I', self.readBytes(4))
        return r[0]

    def readDouble(self):
        r = struct.unpack('>d', self.readBytes(8))
        return r[0]

    def readShort(self):
        r = struct.unpack('>h', self.readBytes(2))
        return r[0]

    def readBool(self):
        r = struct.unpack('>?', self.readBytes(1))
        return r[0]
        
    def readUtf(self):
        return self.readBytes(self.readShort()).decode()
        
    def readI18N(self):
        return self.readUint()
    
    def readVector(self):
        name = self.readUtf()
        type = self.readInt()

        ret = {
            'name': name,
            'type': type
        }
        log(type)
        if type == -99:
            ret['vectorTypes'] = self.readVector()

        return ret

    def readList(self, field, dim=0):
        ret = []
        count = self.readInt()
        type = field['vectorTypes']['type']
        log("Reading list of type " + str(type))

        for i in range(count):

            if (type > 0):
                classId = self.readInt()
                if classId in self.classes:
                    c = self.readObject(self.classes[classId])
                else:
                    c = None
                
                ret.append(c)

            elif (type == -99):
                ret.append(self.readList(field['vectorTypes']))
                
            else:
                func =  self.fieldType[type]
                ret.append(func())

        return ret

    def readObject(self, obj = None):
        log("Reading object")
        ret = {}

        for field in obj['fields']:
            fieldType = field['type']
            log("Reading " + field['name'] + " of type " + str(fieldType))
            log(self.data[self.offset: self.offset+30])
            if(fieldType > 0):
                classId = self.readInt()
                if classId not in self.classes:
                    classId = fieldType
                ret[field['name']] = self.readObject(self.classes[classId])
            
            else:
                func =  self.fieldType[fieldType]
                if(fieldType != -99):
                    ret[field['name']] = func()
                else:
                    ret[field['name']] = self.readList(field)

        return ret
  
    def read(self):

        # File format
        format = self.readMagic()
        if(format != self.FORMAT):
            raise Exception("Can't read the file {} : not a {} format".format(self.file, str(self.FORMAT)))
        
        # Index location
        headerPosition = self.readInt()
        self.seek(headerPosition)

        # IndexTable
        indexTable = {}
        indexTableSize = int(self.readInt()/8)
        for i in range(indexTableSize):

            index = self.readInt()
            objectLocation = self.readInt()
            
            indexTable[index] = objectLocation
            log(str(i) + ":" + str(index) + ":" + str(objectLocation))

        log("==== IndexTable ====")
        log(indexTable)
        log("==== IndexTable ====")

        # Classes Definition
        classesSize = self.readInt()

        for i in range(classesSize):

            classId = self.readInt()
            memberName = self.readUtf()
            packageName = self.readUtf()
            fieldsSize = self.readInt()

            log("fieldsSize = " + str(fieldsSize))
            class_ = {
                'memberName': memberName,
                'packageName': packageName,
                'fields': []
            }

            for fieldId in range(fieldsSize):
                log("fieldId = " + str(fieldId))
                vector = self.readVector()
                class_['fields'].append(vector)

            self.classes[classId] = class_

        log("==== classes ====")
        log(self.classes)
        log("==== classes ====")

        # Class Objects
        objects = []
        for index in indexTable.values():

            self.seek(index)
            objects.append(self.readObject(self.classes[self.readInt()]))
        log(self.classes.values())
        return {
            'def': list(self.classes.values()),
            'data': objects
        }

def main(input, output, is_files):
    files_to_convert = {}
    
    if (is_files):
        file[input] = output;
    else: 
        files_in_input = os.listdir(input)
        for file_in_input in files_in_input:
            files_to_convert[input + file_in_input] = output + file_in_input.split('.')[0] + '.json'

    for key in files_to_convert:
        try:
            print("Extracting " + str(key), flush=True)
            reader = D2OReader(key)
            data = reader.read()
            print("Building " + str(files_to_convert[key]), flush=True)
            save_file(files_to_convert[key], data)
        except Exception as e:
            print(str(e))

if __name__ == "__main__":
    if(len(sys.argv) >= 3):
        is_files = (os.path.isfile(sys.argv[1]) and os.path.isfile(sys.argv[2]))    #If input and output are files
        is_folders = (os.path.isdir(sys.argv[1]) and os.path.isdir(sys.argv[2]))    #If input and output are folders 
        
        if(is_files or is_folders):
            main(sys.argv[1], sys.argv[2], is_files)
        else:
            print("""Needs arguments of same type: Two files or two folders""")
    else:
        print("""Needs at least two arguments:
            - An input file and an output file
            - An input folder and an output folder""")


