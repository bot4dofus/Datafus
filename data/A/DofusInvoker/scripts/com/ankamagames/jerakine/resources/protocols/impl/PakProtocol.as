package com.ankamagames.jerakine.resources.protocols.impl
{
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
   
   public class PakProtocol extends AbstractProtocol implements IProtocol
   {
      
      private static var _streams:Dictionary = new Dictionary();
      
      private static var _indexes:Dictionary = new Dictionary();
       
      
      public function PakProtocol()
      {
         super();
      }
      
      public function getFilesIndex(uri:Uri) : Dictionary
      {
         var fileStream:FileStream = _streams[uri.path];
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
         var fileStream:FileStream = _streams[uri.path];
         if(!fileStream)
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
         var filePath:String = null;
         var fileOffset:int = 0;
         var fileLength:int = 0;
         var file:File = uri.toFile();
         if(!file.exists)
         {
            return null;
         }
         var fs:FileStream = new FileStream();
         fs.open(file,FileMode.READ);
         var indexes:Dictionary = new Dictionary();
         var indexesOffset:int = fs.readInt();
         fs.position = indexesOffset;
         while(fs.bytesAvailable > 0)
         {
            filePath = fs.readUTF();
            fileOffset = fs.readInt();
            fileLength = fs.readInt();
            indexes[filePath] = {
               "o":fileOffset,
               "l":fileLength
            };
         }
         _indexes[uri.path] = indexes;
         _streams[uri.path] = fs;
         return fs;
      }
   }
}
