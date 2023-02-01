package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.LoaderInfo;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import org.audiofx.mp3.MP3FileReferenceLoader;
   import org.audiofx.mp3.MP3SoundEvent;
   
   public class MP3Adapter implements IAdapter
   {
       
      
      private var _sound:Sound;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _mp3BinaryLoader:MP3FileReferenceLoader;
      
      public function MP3Adapter()
      {
         super();
      }
      
      public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         if(this._sound)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         this._observer = observer;
         this._uri = uri;
         this._dispatchProgress = dispatchProgress;
         this.prepareLoader();
         this._sound.load(new URLRequest(path));
      }
      
      public function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         this._observer = observer;
         this._uri = uri;
         this._dispatchProgress = dispatchProgress;
         this._mp3BinaryLoader = new MP3FileReferenceLoader();
         this._mp3BinaryLoader.addEventListener(MP3SoundEvent.COMPLETE,this.onMp3BinaryParsed);
         this._mp3BinaryLoader.loadMP3ByteArray(data);
      }
      
      public function free() : void
      {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(ldr:LoaderInfo) : *
      {
         return this._sound;
      }
      
      public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_MP3;
      }
      
      private function prepareLoader() : void
      {
         this._sound = new Sound();
         this._sound.addEventListener(Event.COMPLETE,this.onInit);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseLoader() : void
      {
         if(this._sound)
         {
            try
            {
               this._sound.close();
            }
            catch(e:Error)
            {
            }
            this._sound.removeEventListener(Event.COMPLETE,this.onInit);
            this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         this._sound = null;
      }
      
      private function onMp3BinaryParsed(e:MP3SoundEvent) : void
      {
         (e.target as MP3FileReferenceLoader).removeEventListener(MP3SoundEvent.COMPLETE,this.onMp3BinaryParsed);
         var res:* = e.sound;
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),res);
      }
      
      protected function onInit(e:Event) : void
      {
         var res:* = e.target as Sound;
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),res);
      }
      
      protected function onError(ee:ErrorEvent) : void
      {
         this.releaseLoader();
         this._observer.onFailed(this._uri,ee.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      protected function onProgress(pe:ProgressEvent) : void
      {
         this._observer.onProgress(this._uri,pe.bytesLoaded,pe.bytesTotal);
      }
   }
}
