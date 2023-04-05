package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class PakProtocol2 extends AbstractProtocol implements IProtocol
   {
      
      private static var _indexes:Dictionary = new Dictionary();
      
      private static var _properties:Dictionary = new Dictionary();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PakProtocol2));
       
      
      public function PakProtocol2()
      {
         super();
      }
      
      public function getFilesIndex(uri:Uri) : Dictionary
      {
         var fileStream:* = _indexes[uri.path];
         if(!fileStream)
         {
            fileStream = this.initStream(uri);
            if(!fileStream)
            {
               return null;
            }
         }
         return _indexes[uri.path];
      }
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, uniqueFile:Boolean) : void
      {
         var fileStream:FileStream = null;
         if(!_indexes[uri.path])
         {
            fileStream = this.initStream(uri);
            if(!fileStream)
            {
               if(observer)
               {
                  observer.onFailed(uri,"Unable to find container.",ResourceErrorCode.PAK_NOT_FOUND);
               }
               return;
            }
         }
         var index:Object = _indexes[uri.path][uri.subPath];
         if(!index)
         {
            if(observer)
            {
               observer.onFailed(uri,"Unable to find the file in the container.",ResourceErrorCode.FILE_NOT_FOUND_IN_PAK);
            }
            return;
         }
         fileStream = index.stream;
         var data:ByteArray = new ByteArray();
         fileStream.position = index.o;
         fileStream.readBytes(data,0,index.l);
         getAdapter(uri,forcedAdapter);
         try
         {
            _adapter.loadFromData(uri,data,observer,dispatchProgress);
         }
         catch(e:Object)
         {
            observer.onFailed(uri,"Can\'t load byte array from this adapter.",ResourceErrorCode.INCOMPATIBLE_ADAPTER);
            return;
         }
      }
      
      override protected function release() : void
      {
      }
      
      override public function cancel() : void
      {
         if(_adapter)
         {
            _adapter.free();
         }
      }
      
      private function initStream(uri:Uri) : FileStream
      {
         var fs:FileStream = null;
         var vMax:int = 0;
         var vMin:int = 0;
         var dataOffset:uint = 0;
         var dataCount:uint = 0;
         var indexOffset:uint = 0;
         var indexCount:uint = 0;
         var propertiesOffset:uint = 0;
         var propertiesCount:uint = 0;
         var propertyName:String = null;
         var propertyValue:String = null;
         var i:uint = 0;
         var filePath:String = null;
         var fileOffset:int = 0;
         var fileLength:int = 0;
         var idx:int = 0;
         var fileUri:Uri = uri;
         var file:File = fileUri.toFile();
         var indexes:Dictionary = new Dictionary();
         var properties:Dictionary = new Dictionary();
         _indexes[uri.path] = indexes;
         _properties[uri.path] = properties;
         while(file && file.exists)
         {
            fs = new FileStream();
            fs.open(file,FileMode.READ);
            vMax = fs.readUnsignedByte();
            vMin = fs.readUnsignedByte();
            if(vMax != 2 || vMin != 1)
            {
               return null;
            }
            fs.position = file.size - 24;
            dataOffset = fs.readUnsignedInt();
            dataCount = fs.readUnsignedInt();
            indexOffset = fs.readUnsignedInt();
            indexCount = fs.readUnsignedInt();
            propertiesOffset = fs.readUnsignedInt();
            propertiesCount = fs.readUnsignedInt();
            fs.position = propertiesOffset;
            file = null;
            for(i = 0; i < propertiesCount; i++)
            {
               propertyName = fs.readUTF();
               propertyValue = fs.readUTF();
               properties[propertyName] = propertyValue;
               if(propertyName == "link")
               {
                  idx = fileUri.path.lastIndexOf("/");
                  if(idx != -1)
                  {
                     fileUri = new Uri(fileUri.path.substr(0,idx) + "/" + propertyValue);
                  }
                  else
                  {
                     fileUri = new Uri(propertyValue);
                  }
                  file = fileUri.toFile();
               }
            }
            fs.position = indexOffset;
            for(i = 0; i < indexCount; i++)
            {
               filePath = fs.readUTF();
               fileOffset = fs.readInt();
               fileLength = fs.readInt();
               indexes[filePath] = {
                  "o":fileOffset + dataOffset,
                  "l":fileLength,
                  "stream":fs
               };
            }
         }
         return fs;
      }
   }
}
