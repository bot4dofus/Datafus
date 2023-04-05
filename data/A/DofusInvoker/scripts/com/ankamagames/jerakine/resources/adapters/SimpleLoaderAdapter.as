package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.pools.PoolableLoader;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.LoaderInfo;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class SimpleLoaderAdapter implements IAdapter
   {
       
      
      private var _ldr:PoolableLoader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _signedFileAdapter:SignedFileAdapter;
      
      public function SimpleLoaderAdapter()
      {
         super();
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
         if(uri.fileType.charAt(uri.fileType.length - 1) == "s")
         {
            this._signedFileAdapter = new SignedFileAdapter(null,true);
            this._signedFileAdapter.loadDirectly(uri,path,new ResourceObserverWrapper(this.onSignedFileLoaded,this.onSignedFileError),false);
         }
         else
         {
            this.prepareLoader();
            this._ldr.load(new URLRequest(path),uri.loaderContext);
         }
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
         this._ldr.loadBytes(data,uri.loaderContext);
      }
      
      public function free() : void
      {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(ldr:LoaderInfo) : *
      {
         return this._ldr;
      }
      
      public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_NONE;
      }
      
      private function prepareLoader() : void
      {
         this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
         this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this.onInit,false,0,true);
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError,false,0,true);
         if(this._dispatchProgress)
         {
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
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
            this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this.onInit);
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
            this._ldr = null;
         }
      }
      
      protected function onInit(e:Event) : void
      {
         var res:* = this.getResource(LoaderInfo(e.target));
         this._observer.onLoaded(this._uri,this.getResourceType(),res);
         this._uri = null;
      }
      
      protected function onError(ee:ErrorEvent) : void
      {
         this.releaseLoader();
         this._observer.onFailed(this._uri,ee.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
         this._uri = null;
      }
      
      protected function onProgress(pe:ProgressEvent) : void
      {
         this._observer.onProgress(this._uri,pe.bytesLoaded,pe.bytesTotal);
      }
      
      private function onSignedFileLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         this.loadFromData(uri,resource as ByteArray,this._observer,this._dispatchProgress);
      }
      
      private function onSignedFileError(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         this.onError(new ErrorEvent(errorMsg));
      }
   }
}
