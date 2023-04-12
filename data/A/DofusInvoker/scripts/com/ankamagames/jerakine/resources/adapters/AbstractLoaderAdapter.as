package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.PoolableLoader;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.LoaderInfo;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractLoaderAdapter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractLoaderAdapter));
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      private var _ldr:PoolableLoader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      public function AbstractLoaderAdapter()
      {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         this._observer = observer;
         this._uri = uri;
         this._dispatchProgress = dispatchProgress;
         this.prepareLoader();
         this._ldr.load(new URLRequest((path.substr(0,2) == "//" ? "file://" : "") + path),uri.loaderContext);
      }
      
      public function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         this._observer = observer;
         this._uri = uri;
         this.prepareLoader();
         try
         {
            if(this._uri.loaderContext)
            {
               AirScanner.allowByteCodeExecution(this._uri.loaderContext,true);
            }
            else
            {
               this._uri.loaderContext = new LoaderContext();
               AirScanner.allowByteCodeExecution(this._uri.loaderContext,true);
            }
            this._ldr.loadBytes(data,this._uri.loaderContext);
         }
         catch(e:SecurityError)
         {
            throw e;
         }
      }
      
      public function free() : void
      {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(ldr:LoaderInfo) : *
      {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      public function getResourceType() : uint
      {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      private function prepareLoader() : void
      {
         this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
         this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onInit);
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseLoader() : void
      {
         if(this._ldr)
         {
            try
            {
               this._ldr.close();
            }
            catch(e:Error)
            {
            }
            this._ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onInit);
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            if(this._dispatchProgress)
            {
               this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            }
            if(this._ldr.loadCompleted)
            {
               PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
            }
            else
            {
               this._ldr.delayedCheckIn();
            }
         }
         this._ldr = null;
      }
      
      protected function init(ldr:LoaderInfo) : void
      {
         var res:* = this.getResource(LoaderInfo(ldr));
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),res);
      }
      
      protected function onInit(e:Event) : void
      {
         this._ldr.loadCompleted = true;
         this.init(LoaderInfo(e.target));
      }
      
      protected function onError(ee:ErrorEvent) : void
      {
         this._ldr.loadCompleted = true;
         this.releaseLoader();
         this._observer.onFailed(this._uri,ee.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      protected function onProgress(pe:ProgressEvent) : void
      {
         this._observer.onProgress(this._uri,pe.bytesLoaded,pe.bytesTotal);
      }
   }
}
