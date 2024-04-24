package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class GameDataFileAccessor
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataFileAccessor));
      
      private static var _self:GameDataFileAccessor;
       
      
      private var _streams:Dictionary;
      
      private var _streamStartIndex:Dictionary;
      
      private var _indexes:Dictionary;
      
      private var _classes:Dictionary;
      
      private var _counter:Dictionary;
      
      private var _gameDataProcessor:Dictionary;
      
      public function GameDataFileAccessor()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : GameDataFileAccessor
      {
         if(!_self)
         {
            _self = new GameDataFileAccessor();
         }
         return _self;
      }
      
      public function init(fileUri:Uri) : void
      {
         var nativeFile:File = fileUri.toFile();
         if(!nativeFile || !nativeFile.exists)
         {
            throw new Error("Game data file \'" + nativeFile + "\' not readable.");
         }
         var moduleName:String = fileUri.fileName.substr(0,fileUri.fileName.indexOf(".d2o"));
         if(!this._streams)
         {
            this._streams = new Dictionary();
         }
         if(!this._streamStartIndex)
         {
            this._streamStartIndex = new Dictionary();
         }
         var stream:FileStream = this._streams[moduleName];
         if(!stream)
         {
            stream = new FileStream();
            stream.endian = Endian.BIG_ENDIAN;
            stream.open(nativeFile,FileMode.READ);
            this._streams[moduleName] = stream;
            this._streamStartIndex[moduleName] = 7;
         }
         else
         {
            stream.position = 0;
         }
         this.initFromIDataInput(stream,moduleName);
      }
      
      public function initFromIDataInput(stream:IDataInput, moduleName:String) : void
      {
         var key:int = 0;
         var pointer:int = 0;
         var count:uint = 0;
         var classIdentifier:int = 0;
         var formatVersion:uint = 0;
         var len:uint = 0;
         if(!this._streams)
         {
            this._streams = new Dictionary();
         }
         if(!this._indexes)
         {
            this._indexes = new Dictionary();
         }
         if(!this._classes)
         {
            this._classes = new Dictionary();
         }
         if(!this._counter)
         {
            this._counter = new Dictionary();
         }
         if(!this._streamStartIndex)
         {
            this._streamStartIndex = new Dictionary();
         }
         if(!this._gameDataProcessor)
         {
            this._gameDataProcessor = new Dictionary();
         }
         this._streams[moduleName] = stream;
         if(!this._streamStartIndex[moduleName])
         {
            this._streamStartIndex[moduleName] = 7;
         }
         var indexes:Dictionary = new Dictionary();
         this._indexes[moduleName] = indexes;
         var contentOffset:uint = 0;
         var headers:String = stream.readMultiByte(3,"ASCII");
         if(headers != "D2O")
         {
            stream["position"] = 0;
            try
            {
               headers = stream.readUTF();
            }
            catch(e:Error)
            {
            }
            if(headers != Signature.ANKAMA_SIGNED_FILE_HEADER)
            {
               throw new Error("Malformated game data file. (AKSF)");
            }
            formatVersion = stream.readShort();
            len = stream.readInt();
            stream["position"] += len;
            contentOffset = stream["position"];
            this._streamStartIndex[moduleName] = contentOffset + 7;
            headers = stream.readMultiByte(3,"ASCII");
            if(headers != "D2O")
            {
               throw new Error("Malformated game data file. (D2O)");
            }
         }
         var indexesPointer:int = stream.readInt();
         stream["position"] = contentOffset + indexesPointer;
         var indexesLength:int = stream.readInt();
         for(var i:uint = 0; i < indexesLength; i += 8)
         {
            key = stream.readInt();
            pointer = stream.readInt();
            indexes[key] = contentOffset + pointer;
            count++;
         }
         this._counter[moduleName] = count;
         _log.debug(count + " objets in this module");
         var classes:Dictionary = new Dictionary();
         this._classes[moduleName] = classes;
         var classesCount:int = stream.readInt();
         for(var j:uint = 0; j < classesCount; j++)
         {
            classIdentifier = stream.readInt();
            this.readClassDefinition(classIdentifier,stream,classes);
         }
         if(stream.bytesAvailable)
         {
            this._gameDataProcessor[moduleName] = new GameDataProcess(stream);
         }
      }
      
      public function getDataProcessor(moduleName:String) : GameDataProcess
      {
         return this._gameDataProcessor[moduleName];
      }
      
      public function getClassDefinition(moduleName:String, classId:int) : GameDataClassDefinition
      {
         return this._classes[moduleName][classId];
      }
      
      public function getCount(moduleName:String) : uint
      {
         return this._counter[moduleName];
      }
      
      public function getObject(moduleName:String, objectId:*) : *
      {
         if(!this._indexes || !this._indexes[moduleName])
         {
            return null;
         }
         var pointer:int = this._indexes[moduleName][objectId];
         if(!pointer)
         {
            return null;
         }
         this._streams[moduleName].position = pointer;
         var classId:int = this._streams[moduleName].readInt();
         var classDef:GameDataClassDefinition = this.getClassDefinition(moduleName,classId);
         if(classDef)
         {
            return classDef.read(moduleName,this._streams[moduleName]);
         }
         return null;
      }
      
      public function getObjects(moduleName:String) : Array
      {
         if(!this._counter || !this._counter[moduleName])
         {
            return null;
         }
         var len:uint = this._counter[moduleName];
         var classes:Dictionary = this._classes[moduleName];
         var stream:IDataInput = this._streams[moduleName];
         stream["position"] = this._streamStartIndex[moduleName];
         var objs:Array = new Array(len);
         for(var i:uint = 0; i < len; i++)
         {
            objs[i] = classes[stream.readInt()].read(moduleName,stream);
         }
         return objs;
      }
      
      public function close() : void
      {
         var stream:IDataInput = null;
         for each(stream in this._streams)
         {
            try
            {
               if(stream is FileStream)
               {
                  FileStream(stream).close();
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
         this._streams = null;
         this._indexes = null;
         this._classes = null;
      }
      
      private function readClassDefinition(classId:int, stream:IDataInput, store:Dictionary) : void
      {
         var fieldName:String = null;
         var fieldType:int = 0;
         var className:String = stream.readUTF();
         var packageName:String = stream.readUTF();
         var classDef:GameDataClassDefinition = new GameDataClassDefinition(packageName,className);
         var fieldsCount:int = stream.readInt();
         for(var i:uint = 0; i < fieldsCount; i++)
         {
            fieldName = stream.readUTF();
            classDef.addField(fieldName,stream);
         }
         store[classId] = classDef;
      }
   }
}
