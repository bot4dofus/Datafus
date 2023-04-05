package com.ankamagames.tubul.resources.adapters
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.resources.TubulResourceType;
   import com.ankamagames.tubul.utils.error.TubulError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class MP3Adapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _sound:Sound;
      
      public function MP3Adapter()
      {
         super();
      }
      
      override public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         this._observer = observer;
         this._uri = uri;
         this._dispatchProgress = dispatchProgress;
         this._dispatchProgress = true;
         this.prepareLoader();
         this._sound.load(new URLRequest(path));
      }
      
      override public function free() : void
      {
         this.releaseLoader();
         this._uri = null;
         this._observer = null;
      }
      
      override public function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         throw new TubulError("loadFromData can\'t be call for an MP3 adapter ! A sound can\'t be load with byteArray");
      }
      
      private function releaseLoader() : void
      {
         this._sound.removeEventListener(Event.COMPLETE,this.onComplete);
         this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      private function prepareLoader() : void
      {
         this._sound = new Sound();
         this._sound.addEventListener(Event.COMPLETE,this.onComplete);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         return this._sound;
      }
      
      override public function getResourceType() : uint
      {
         return TubulResourceType.RESOURCE_MP3_SOUND;
      }
      
      override protected function onComplete(e:Event) : void
      {
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),this._sound);
      }
      
      override protected function onError(ee:ErrorEvent) : void
      {
         this.releaseLoader();
         this._observer.onFailed(this._uri,ee.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      override protected function onProgress(pe:ProgressEvent) : void
      {
         this._observer.onProgress(this._uri,pe.bytesLoaded,pe.bytesTotal);
      }
   }
}
