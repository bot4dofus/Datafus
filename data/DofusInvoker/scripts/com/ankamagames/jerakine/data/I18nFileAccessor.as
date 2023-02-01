package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.getQualifiedClassName;
   
   public class I18nFileAccessor
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(I18nFileAccessor));
      
      private static var _self:I18nFileAccessor;
       
      
      private var _stream:FileStream;
      
      private var _indexes:Dictionary;
      
      private var _unDiacriticalIndex:Dictionary;
      
      private var _textIndexes:Dictionary;
      
      private var _textIndexesOverride:Dictionary;
      
      private var _textSortIndex:Dictionary;
      
      private var _startTextIndex:uint = 4;
      
      private var _textCount:uint;
      
      private var _directBuffer:ByteArray;
      
      public function I18nFileAccessor()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : I18nFileAccessor
      {
         if(!_self)
         {
            _self = new I18nFileAccessor();
         }
         return _self;
      }
      
      public function init(fileUri:Uri) : void
      {
         var key:int = 0;
         var pointer:int = 0;
         var diacriticalText:Boolean = false;
         var position:uint = 0;
         var textKey:* = null;
         var nativeFile:File = fileUri.toFile();
         if(!nativeFile || !nativeFile.exists)
         {
            throw new Error("I18n file not readable.");
         }
         this._stream = new FileStream();
         this._stream.endian = Endian.BIG_ENDIAN;
         this._stream.open(nativeFile,FileMode.READ);
         this._indexes = new Dictionary();
         this._unDiacriticalIndex = new Dictionary();
         this._textIndexes = new Dictionary();
         this._textIndexesOverride = new Dictionary();
         this._textSortIndex = new Dictionary();
         this._textCount = 0;
         var indexesPointer:int = this._stream.readInt();
         var keyCount:uint = 0;
         this._stream.position = indexesPointer;
         var indexesLength:int = this._stream.readInt();
         for(var i:uint = 0; i < indexesLength; i += 9)
         {
            key = this._stream.readInt();
            diacriticalText = this._stream.readBoolean();
            pointer = this._stream.readInt();
            this._indexes[key] = pointer;
            keyCount++;
            if(diacriticalText)
            {
               keyCount++;
               i += 4;
               this._unDiacriticalIndex[key] = this._stream.readInt();
            }
            else
            {
               this._unDiacriticalIndex[key] = pointer;
            }
         }
         indexesLength = this._stream.readInt();
         while(indexesLength > 0)
         {
            position = this._stream.position;
            textKey = this._stream.readUTF();
            pointer = this._stream.readInt();
            ++this._textCount;
            this._textIndexes[textKey] = pointer;
            indexesLength -= this._stream.position - position;
         }
         indexesLength = this._stream.readInt();
         i = 0;
         while(indexesLength > 0)
         {
            position = this._stream.position;
            this._textSortIndex[this._stream.readInt()] = ++i;
            indexesLength -= this._stream.position - position;
         }
         var textKeys:Array = [];
         for(textKey in this._textIndexes)
         {
            textKeys.push(textKey);
         }
         EnterFrameDispatcher.worker.addForeachTreatment(this,this.setEntries,[],textKeys);
         EnterFrameDispatcher.worker.addSingleTreatment(this,this.logInit,[]);
      }
      
      private function logInit() : void
      {
         _log.debug("Initialized !");
      }
      
      private function setEntries(textKey:String) : void
      {
         LangManager.getInstance().setEntry(textKey,this.getNamedText(textKey));
      }
      
      public function overrideId(oldId:uint, newId:uint) : void
      {
         this._indexes[oldId] = this._indexes[newId];
         this._unDiacriticalIndex[oldId] = this._unDiacriticalIndex[newId];
      }
      
      public function addOverrideFile(file:Uri) : void
      {
         var rawContent:String = null;
         var f:File = null;
         var fs:FileStream = null;
         var content:XML = null;
         var override:XML = null;
         if(file.fileType == "xml")
         {
            try
            {
               f = file.toFile();
               if(!f.exists)
               {
                  _log.fatal("Le fichier [" + file + "] utiliser lors de la surcharge du fichier i18n n\'existe pas");
                  return;
               }
               fs = new FileStream();
               fs.open(f,FileMode.READ);
               rawContent = fs.readUTFBytes(fs.bytesAvailable);
            }
            catch(e:Error)
            {
               _log.fatal("Impossible de lire le fichier " + file + " lors de la surcharge du fichier i18n : \n" + e.getStackTrace());
               return;
            }
            try
            {
               content = new XML(rawContent);
               for each(override in content..override)
               {
                  if(override.@type.toString() == "" || override.@type.toString() == "ui")
                  {
                     this._textIndexesOverride[override.@target.toString()] = override.toString();
                  }
                  else
                  {
                     GameData.addOverride(override.@type.toString(),override.@target.toString(),override.toString());
                  }
               }
            }
            catch(e:Error)
            {
               _log.fatal("Erreur lors de la lecture du fichier " + file + " pour la surcharge du fichier i18n : \n" + e.getStackTrace());
            }
            _log.debug("Override done !");
         }
         else
         {
            _log.error("Le fichier d\'override [" + file.fileName + "] n\'est pas un fichier xml.");
         }
      }
      
      public function getOrderIndex(key:int) : int
      {
         return this._textSortIndex[key];
      }
      
      public function getText(key:int) : String
      {
         if(!this._indexes)
         {
            return null;
         }
         var pointer:int = this._indexes[key];
         if(!pointer)
         {
            return null;
         }
         if(this._directBuffer == null)
         {
            this._stream.position = pointer;
            return this._stream.readUTF();
         }
         this._directBuffer.position = pointer;
         return this._directBuffer.readUTF();
      }
      
      public function getUnDiacriticalText(key:int) : String
      {
         if(!this._unDiacriticalIndex)
         {
            return null;
         }
         var pointer:int = this._unDiacriticalIndex[key];
         if(!pointer)
         {
            return null;
         }
         if(this._directBuffer == null)
         {
            this._stream.position = pointer;
            return this._stream.readUTF();
         }
         this._directBuffer.position = pointer;
         return this._directBuffer.readUTF();
      }
      
      public function hasText(key:int) : Boolean
      {
         return this._indexes && this._indexes[key];
      }
      
      public function getNamedText(textKey:String) : String
      {
         if(!this._textIndexes)
         {
            return null;
         }
         if(this._textIndexesOverride[textKey])
         {
            textKey = this._textIndexesOverride[textKey];
         }
         var pointer:int = this._textIndexes[textKey];
         if(!pointer)
         {
            return null;
         }
         this._stream.position = pointer;
         return this._stream.readUTF();
      }
      
      public function hasNamedText(textKey:String) : Boolean
      {
         return this._textIndexes && this._textIndexes[textKey];
      }
      
      public function useDirectBuffer(bool:Boolean) : void
      {
         if(this._directBuffer == null == bool)
         {
            return;
         }
         if(!bool)
         {
            this._directBuffer = null;
         }
         else
         {
            this._directBuffer = new ByteArray();
            this._stream.position = 0;
            this._stream.readBytes(this._directBuffer);
         }
      }
      
      public function close() : void
      {
         if(this._stream)
         {
            try
            {
               this._stream.close();
            }
            catch(e:Error)
            {
            }
            this._stream = null;
         }
         this._indexes = null;
         this._textIndexes = null;
         this._directBuffer = null;
      }
   }
}
