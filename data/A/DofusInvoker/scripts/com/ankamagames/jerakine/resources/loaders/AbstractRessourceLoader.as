package com.ankamagames.jerakine.resources.loaders
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.events.ResourceProgressEvent;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractRessourceLoader extends EventDispatcher implements IResourceObserver
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractRessourceLoader));
      
      public static var MEMORY_TEST:Dictionary = new Dictionary(true);
      
      protected static const RES_CACHE_PREFIX:String = "RES_";
       
      
      protected var _cache:ICache;
      
      protected var _completed:Boolean;
      
      protected var _filesLoaded:uint = 0;
      
      protected var _filesTotal:uint = 0;
      
      public function AbstractRessourceLoader()
      {
         super();
      }
      
      protected function checkCache(uri:Uri) : Boolean
      {
         var cr:CacheableResource = this.getCachedValue(uri);
         if(cr != null)
         {
            this.dispatchSuccess(uri,cr.resourceType,cr.resource);
            return true;
         }
         return false;
      }
      
      private function getCachedValue(uri:Uri) : CacheableResource
      {
         var cr:CacheableResource = null;
         var resourceUrl:String = null;
         if(uri.protocol == "pak" || uri.fileType != "swf" || !uri.subPath || uri.subPath.length == 0)
         {
            resourceUrl = RES_CACHE_PREFIX + uri.toSum();
         }
         else
         {
            resourceUrl = RES_CACHE_PREFIX + new Uri(uri.path).toSum();
         }
         if(this._cache && this._cache.contains(resourceUrl))
         {
            cr = this._cache.peek(resourceUrl);
         }
         return cr;
      }
      
      public function isInCache(uri:Uri) : Boolean
      {
         return this.getCachedValue(uri) != null;
      }
      
      public function cancel() : void
      {
         this._filesTotal = 0;
         this._filesLoaded = 0;
         this._completed = false;
         this._cache = null;
      }
      
      protected function dispatchSuccess(uri:Uri, resourceType:uint, resource:*) : void
      {
         var resourceUrl:String = null;
         var cr:CacheableResource = null;
         var rle:ResourceLoadedEvent = null;
         var rlpe:ResourceLoaderProgressEvent = null;
         if(uri.fileType != "swf" || !uri.subPath || uri.subPath.length == 0)
         {
            resourceUrl = RES_CACHE_PREFIX + uri.toSum();
         }
         else
         {
            resourceUrl = RES_CACHE_PREFIX + new Uri(uri.path).toSum();
         }
         if(this._cache && !this._cache.contains(resourceUrl))
         {
            cr = new CacheableResource(resourceType,resource);
            this._cache.store(resourceUrl,cr);
         }
         ++this._filesLoaded;
         if(hasEventListener(ResourceLoadedEvent.LOADED))
         {
            rle = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
            rle.uri = uri;
            rle.resourceType = resourceType;
            rle.resource = resource;
            dispatchEvent(rle);
         }
         if(hasEventListener(ResourceLoaderProgressEvent.LOADER_PROGRESS))
         {
            rlpe = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_PROGRESS);
            rlpe.uri = uri;
            rlpe.filesTotal = this._filesTotal;
            rlpe.filesLoaded = this._filesLoaded;
            dispatchEvent(rlpe);
         }
         if(this._filesLoaded == this._filesTotal)
         {
            this.dispatchComplete();
         }
      }
      
      protected function dispatchFailure(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         var ree:ResourceErrorEvent = null;
         if(this._filesTotal == 0)
         {
            return;
         }
         ++this._filesLoaded;
         if(hasEventListener(ResourceErrorEvent.ERROR))
         {
            ree = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
            ree.uri = uri;
            ree.errorMsg = errorMsg;
            ree.errorCode = errorCode;
            dispatchEvent(ree);
         }
         else
         {
            _log.error("[Error code " + errorCode.toString(16) + "] Unable to load resource " + uri + ": " + errorMsg);
         }
         if(this._filesLoaded == this._filesTotal)
         {
            this.dispatchComplete();
         }
      }
      
      private function dispatchComplete() : void
      {
         var rlpe:ResourceLoaderProgressEvent = null;
         if(!this._completed)
         {
            this._completed = true;
            rlpe = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_COMPLETE);
            rlpe.filesTotal = this._filesTotal;
            rlpe.filesLoaded = this._filesLoaded;
            dispatchEvent(rlpe);
         }
      }
      
      public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         MEMORY_TEST[resource] = 1;
         this.dispatchSuccess(uri,resourceType,resource);
      }
      
      public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         this.dispatchFailure(uri,errorMsg,errorCode);
      }
      
      public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void
      {
         var rpe:ResourceProgressEvent = new ResourceProgressEvent(ResourceProgressEvent.PROGRESS);
         rpe.uri = uri;
         rpe.bytesLoaded = bytesLoaded;
         rpe.bytesTotal = bytesTotal;
         dispatchEvent(rpe);
      }
   }
}
