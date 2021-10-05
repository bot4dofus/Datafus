package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.CustomSharedObjectFileFormatError;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.ObjectEncoding;
   import flash.utils.getQualifiedClassName;
   
   public class CustomSharedObject
   {
      
      public static const DATAFILE_EXTENSION:String = "dat";
      
      public static var clearedCacheAndRebooting:Boolean = false;
      
      public static var directory:String = "Dofus";
      
      public static var useDefaultDirectory:Boolean = false;
      
      private static var COMMON_FOLDER:String;
      
      private static var _cache:Array = [];
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomSharedObject));
      
      public static var throwException:Boolean;
       
      
      private var _name:String;
      
      private var _fileStream:FileStream;
      
      private var _file:File;
      
      public var data:Object;
      
      public var objectEncoding:uint;
      
      public function CustomSharedObject()
      {
         this.data = new Object();
         super();
      }
      
      public static function getLocal(name:String) : CustomSharedObject
      {
         if(_cache[name])
         {
            return _cache[name];
         }
         if(!COMMON_FOLDER)
         {
            COMMON_FOLDER = getCustomSharedObjectDirectory();
         }
         var cso:CustomSharedObject = new CustomSharedObject();
         cso._name = name;
         cso.getDataFromFile();
         _cache[name] = cso;
         return cso;
      }
      
      public static function getCustomSharedObjectDirectory() : String
      {
         var dir:File = null;
         var tmp2:Array = null;
         var tmp:Array = null;
         var valid:Boolean = false;
         var newPathFile:File = null;
         var newPath:String = null;
         var folder:String = null;
         var canonicalizedCommonFolder:File = null;
         if(!COMMON_FOLDER)
         {
            if(CommandLineArguments.getInstance().hasArgument("prefs"))
            {
               COMMON_FOLDER = CommandLineArguments.getInstance().getArgument("prefs");
            }
            else if(useDefaultDirectory)
            {
               COMMON_FOLDER = File.applicationStorageDirectory.nativePath;
            }
            else
            {
               tmp2 = File.applicationStorageDirectory.nativePath.split(File.separator);
               tmp2.pop();
               tmp2.pop();
               tmp = File.applicationDirectory.nativePath.split(File.separator);
               valid = tmp.length > 1;
               if(valid)
               {
                  folder = tmp[tmp.length - 2];
                  valid = folder.toLowerCase().indexOf("ankama") == -1 && folder.toLowerCase().indexOf("zaap") == -1 && folder.indexOf(":") == -1;
                  if(valid)
                  {
                     canonicalizedCommonFolder = new File(tmp2.join(File.separator) + File.separator + folder);
                     canonicalizedCommonFolder.canonicalize();
                     COMMON_FOLDER = canonicalizedCommonFolder.nativePath;
                     valid = canonicalizedCommonFolder.exists;
                  }
               }
               newPathFile = new File(tmp2.join(File.separator) + File.separator + directory);
               newPathFile.canonicalize();
               newPath = newPathFile.nativePath;
               if(valid && newPath != COMMON_FOLDER)
               {
                  if(newPathFile.exists)
                  {
                     try
                     {
                        newPathFile.deleteDirectory(true);
                     }
                     catch(e:Error)
                     {
                        e.message = "Error deleting existing cache directory before migration (" + newPath + ") : " + e.message;
                        throw e;
                     }
                  }
                  try
                  {
                     new File(COMMON_FOLDER).moveTo(newPathFile,true);
                  }
                  catch(e:Error)
                  {
                     e.message = "Error migrating old cache directory from " + COMMON_FOLDER + " to " + newPath + " : " + e.message;
                     throw e;
                  }
               }
               COMMON_FOLDER = newPath;
            }
            COMMON_FOLDER += File.separator;
            dir = new File(COMMON_FOLDER);
            if(!dir.exists)
            {
               dir.createDirectory();
            }
         }
         return COMMON_FOLDER;
      }
      
      public static function closeAll() : void
      {
         var cso:CustomSharedObject = null;
         for each(cso in _cache)
         {
            if(cso)
            {
               cso.close();
            }
         }
      }
      
      public static function resetCache() : void
      {
         _cache = [];
      }
      
      public static function clearCache(name:String) : void
      {
         delete _cache[name];
      }
      
      public function flush() : void
      {
         if(clearedCacheAndRebooting)
         {
            return;
         }
         this.writeData(this.data);
      }
      
      public function clear() : void
      {
         this.data = new Object();
         this.writeData(this.data);
      }
      
      public function close() : void
      {
         if(this._fileStream)
         {
            this._fileStream.close();
         }
      }
      
      private function writeData(data:*) : Boolean
      {
         try
         {
            this._fileStream.open(this._file,FileMode.WRITE);
            this._fileStream.writeObject(data);
            this._fileStream.close();
         }
         catch(e:Error)
         {
            if(_fileStream)
            {
               _fileStream.close();
            }
            _log.error("Impossible d\'écrire le fichier " + _file.url);
            return false;
         }
         return true;
      }
      
      private function getDataFromFile() : void
      {
         if(!this._file)
         {
            this._file = new File(COMMON_FOLDER + this._name + "." + DATAFILE_EXTENSION);
            this._fileStream = new FileStream();
         }
         if(this._file.exists)
         {
            try
            {
               this._fileStream.objectEncoding = ObjectEncoding.AMF3;
               this._fileStream.open(this._file,FileMode.READ);
               this.data = this._fileStream.readObject();
               this._fileStream.close();
            }
            catch(e:Error)
            {
               if(_fileStream)
               {
                  _fileStream.close();
               }
               _log.error("Impossible d\'ouvrir le fichier " + _file.url);
               if(throwException)
               {
                  throw new CustomSharedObjectFileFormatError("Malformated file : " + _file.url);
               }
            }
         }
         if(!this.data)
         {
            this.data = new Object();
         }
      }
   }
}
