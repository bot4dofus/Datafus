package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.files.ZipLoader;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class ZipProtocol extends AbstractProtocol implements IProtocol
   {
      
      private static const ZIP_CACHE_PREFIX:String = "RES_ZIP_";
      
      private static var _singleLoadingZips:Dictionary = new Dictionary(true);
      
      private static var _loadingZips:Dictionary = new Dictionary(true);
       
      
      private var _uri:Uri;
      
      private var _forcedAdapter:Class;
      
      private var _zldr:ZipLoader;
      
      private var _cache:ICache;
      
      private var _dispatchProgress:Boolean;
      
      public function ZipProtocol()
      {
         super();
      }
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, uniqueFile:Boolean) : void
      {
         if(this._zldr)
         {
            throw new IllegalOperationError("A ZipProtocol can\'t handle more than one operation at a time.");
         }
         this._uri = uri;
         this._forcedAdapter = forcedAdapter;
         _observer = observer;
         this._cache = cache;
         this._dispatchProgress = dispatchProgress;
         if(this._cache && this._cache.contains(ZIP_CACHE_PREFIX + uri.path))
         {
            this._zldr = this._cache.peek(ZIP_CACHE_PREFIX + uri.path);
            this.onComplete(null);
         }
         else if(_loadingZips[uri.path])
         {
            _loadingZips[uri.path].push(this);
         }
         else
         {
            _loadingZips[uri.path] = [this];
            this.prepareZipLoader();
            this._zldr.load(new URLRequest(uri.path));
         }
      }
      
      override public function cancel() : void
      {
         super.cancel();
         this.release();
      }
      
      override protected function release() : void
      {
         this.releaseZipLoader();
         this._uri = null;
         _observer = null;
         this._cache = null;
      }
      
      private function prepareZipLoader() : void
      {
         this._zldr = new ZipLoader();
         this._zldr.addEventListener(Event.COMPLETE,this.onComplete);
         this._zldr.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._zldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._zldr.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseZipLoader() : void
      {
         if(this._zldr)
         {
            this._zldr.removeEventListener(Event.COMPLETE,this.onComplete);
            this._zldr.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._zldr.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
            this._zldr.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         this._zldr.destroy();
         this._zldr = null;
      }
      
      private function onComplete(e:Event) : void
      {
         var listener:ZipProtocol = null;
         for each(listener in _loadingZips[this._uri.path])
         {
            if(this._zldr.fileExists(listener._uri.subPath))
            {
               listener.loadFromData(listener._uri,this._zldr.getFileDatas(listener._uri.subPath),listener._observer,listener._dispatchProgress,listener._forcedAdapter);
            }
            else
            {
               listener._observer.onFailed(this._uri,"File " + listener._uri.subPath + " cannot be found in the ZIP file " + listener._uri.path + ".",ResourceErrorCode.ZIP_FILE_NOT_FOUND_IN_ARCHIVE);
            }
         }
         delete _loadingZips[this._uri.path];
         if(this._cache)
         {
            this._cache.store(ZIP_CACHE_PREFIX + this._uri.path,this._zldr);
         }
         this.releaseZipLoader();
      }
      
      private function onError(ee:ErrorEvent) : void
      {
         var listener:ZipProtocol = null;
         for each(listener in _loadingZips[this._uri.path])
         {
            listener._observer.onFailed(listener._uri,"Can\'t load the ZIP file " + listener._uri.path + ": " + ee.text,ResourceErrorCode.ZIP_NOT_FOUND);
         }
         delete _loadingZips[this._uri.path];
         this.releaseZipLoader();
      }
      
      private function onProgress(pe:ProgressEvent) : void
      {
         var listener:ZipProtocol = null;
         for each(listener in _loadingZips[this._uri.path])
         {
            listener._observer.onProgress(listener._uri,pe.bytesLoaded,pe.bytesTotal);
         }
      }
   }
}
