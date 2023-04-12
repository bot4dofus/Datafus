package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.adapters.impl.BinaryAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class HttpServerConnection
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServerConnection));
      
      private static var _requestCount:uint = 0;
       
      
      private var _loader:IResourceLoader;
      
      private var _requestTimestamp:Dictionary;
      
      private var _errorCallback:Dictionary;
      
      private var _whiteList:Dictionary;
      
      private var _whiteListCount:uint;
      
      public var rawParser:RawDataParser;
      
      public var handler:MessageHandler;
      
      public function HttpServerConnection()
      {
         super();
         this.init();
      }
      
      public function resetTime(uri:Uri) : void
      {
         delete this._requestTimestamp[uri.toString()];
      }
      
      public function request(uri:Uri, errorCallback:Function = null, cacheLife:uint = 0) : Boolean
      {
         var lastRequestTime:Number = this._requestTimestamp[uri.toString()];
         if(lastRequestTime && getTimer() - lastRequestTime < cacheLife)
         {
            return false;
         }
         this._errorCallback[uri] = errorCallback;
         this._requestTimestamp[uri.toString()] = getTimer();
         ++_requestCount;
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onReceive);
         this._loader.load(uri,null,BinaryAdapter);
         return true;
      }
      
      public function reset() : void
      {
         this._loader.cancel();
      }
      
      public function addToWhiteList(classRef:Class) : void
      {
         if(!this._whiteList[classRef])
         {
            this._whiteList[classRef] = true;
            ++this._whiteListCount;
         }
      }
      
      public function removeFromWhiteList(classRef:Class) : void
      {
         if(this._whiteList[classRef])
         {
            delete this._whiteList[classRef];
            --this._whiteListCount;
         }
      }
      
      public function get whiteListCount() : uint
      {
         return this._whiteListCount;
      }
      
      private function init() : void
      {
         this._whiteList = new Dictionary();
         this._errorCallback = new Dictionary(true);
         this._requestTimestamp = new Dictionary();
         _requestCount = 0;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
      }
      
      private function getMessageId(firstOctet:uint) : uint
      {
         return firstOctet >> NetworkMessage.BIT_RIGHT_SHIFT_LEN_PACKET_ID;
      }
      
      private function readMessageLength(staticHeader:uint, src:IDataInput) : uint
      {
         var byteLenDynamicHeader:uint = staticHeader & NetworkMessage.BIT_MASK;
         var messageLength:uint = 0;
         switch(byteLenDynamicHeader)
         {
            case 0:
               break;
            case 1:
               messageLength = src.readUnsignedByte();
               break;
            case 2:
               messageLength = src.readUnsignedShort();
               break;
            case 3:
               messageLength = ((src.readByte() & 255) << 16) + ((src.readByte() & 255) << 8) + (src.readByte() & 255);
         }
         return messageLength;
      }
      
      protected function lowReceive(src:IDataInput) : INetworkMessage
      {
         var messageLength:uint = 0;
         if(src.bytesAvailable < 2)
         {
            return null;
         }
         var staticHeader:uint = src.readUnsignedShort();
         var messageId:uint = this.getMessageId(staticHeader);
         if(src.bytesAvailable >= (staticHeader & NetworkMessage.BIT_MASK))
         {
            messageLength = this.readMessageLength(staticHeader,src);
            if(src.bytesAvailable >= messageLength)
            {
               return this.rawParser.parse(new CustomDataWrapper(src),messageId,messageLength);
            }
         }
         return null;
      }
      
      protected function receive(src:IDataInput, uri:Uri) : void
      {
         var msg:INetworkMessage = null;
         var byteAvaible:uint = src.bytesAvailable;
         while(src.bytesAvailable > 0)
         {
            msg = this.lowReceive(src);
            if(!msg)
            {
               if(byteAvaible == src.bytesAvailable)
               {
                  _log.error("Error while reading " + uri + " : malformated data");
                  return;
               }
               _log.error("Unknow message from " + uri);
               return;
            }
            byteAvaible = src.bytesAvailable;
            if(msg is INetworkDataContainerMessage)
            {
               while(INetworkDataContainerMessage(msg).content.bytesAvailable)
               {
                  this.receive(INetworkDataContainerMessage(msg).content,uri);
               }
            }
            else if(!this._whiteListCount || this._whiteList[Object(msg).constructor])
            {
               _log.info("Dispatch " + msg + " from " + uri);
               this.handler.process(msg);
            }
            else
            {
               _log.error("Packet " + msg + " cannot be used from a web server (uri: " + uri.toString() + ")");
            }
         }
      }
      
      private function onReceive(e:ResourceLoadedEvent) : void
      {
         --_requestCount;
         if(_requestCount == 0)
         {
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onReceive);
         }
         delete this._errorCallback[e.uri];
         var ts:Number = getTimer();
         this.receive(e.resource as ByteArray,e.uri);
         _log.info("Network packet parsed in " + (getTimer() - ts) + " ms");
      }
      
      private function onError(e:ResourceErrorEvent) : void
      {
         --_requestCount;
         if(_requestCount == 0)
         {
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onReceive);
         }
         _log.error("Cannot load " + e.uri + " : " + e.errorMsg);
         if(this._errorCallback[e.uri] != null)
         {
            this._errorCallback[e.uri]();
         }
         delete this._errorCallback[e.uri];
      }
   }
}
