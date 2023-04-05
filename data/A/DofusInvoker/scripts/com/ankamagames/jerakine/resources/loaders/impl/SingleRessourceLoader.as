package com.ankamagames.jerakine.resources.loaders.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.events.ResourceProgressEvent;
   import com.ankamagames.jerakine.resources.loaders.AbstractRessourceLoader;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.jerakine.types.Uri;
   import flash.errors.IllegalOperationError;
   
   public class SingleRessourceLoader extends AbstractRessourceLoader implements IResourceLoader, IResourceObserver
   {
       
      
      private var _uri:Uri;
      
      private var _protocol:IProtocol;
      
      public function SingleRessourceLoader()
      {
         super();
      }
      
      public function load(uri:*, cache:ICache = null, forcedAdapter:Class = null, singleFile:Boolean = false) : void
      {
         if(this._uri != null)
         {
            throw new IllegalOperationError("A single ressource loader can\'t handle more than one load at a time.");
         }
         if(uri == null)
         {
            throw new ArgumentError("Can\'t load a null uri.");
         }
         if(!(uri is Uri))
         {
            throw new ArgumentError("Can\'t load an array of URIs when using a LOADER_SINGLE loader.");
         }
         this._uri = uri;
         _cache = cache;
         _completed = false;
         _filesTotal = 1;
         if(!checkCache(this._uri))
         {
            this._protocol = ProtocolFactory.getProtocol(this._uri);
            this._protocol.load(this._uri,this,hasEventListener(ResourceProgressEvent.PROGRESS),_cache,forcedAdapter,singleFile);
         }
      }
      
      override public function cancel() : void
      {
         super.cancel();
         if(this._protocol)
         {
            this._protocol.cancel();
            this._protocol = null;
         }
         this._uri = null;
      }
      
      override public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         super.onLoaded(uri,resourceType,resource);
         this._protocol = null;
      }
      
      override public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         super.onFailed(uri,errorMsg,errorCode);
         this._protocol = null;
      }
   }
}
