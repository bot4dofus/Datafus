package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.pools.PoolableLoader;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.errors.EOFError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SwlAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      protected var _swl:Swl;
      
      private var _ldr:PoolableLoader;
      
      private var _onInit:Function;
      
      public function SwlAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         return this._swl;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_SWL;
      }
      
      override protected function process(dataFormat:String, data:*) : void
      {
         var file:uint = 0;
         var version:uint = 0;
         var frameRate:uint = 0;
         var classesCount:uint = 0;
         var classesList:Array = null;
         var i:uint = 0;
         var swfData:ByteArray = null;
         try
         {
            file = (data as ByteArray).readByte();
            if(file != 76)
            {
               dispatchFailure("Malformated library file (wrong header).",ResourceErrorCode.SWL_MALFORMED_LIBRARY);
               return;
            }
            version = (data as ByteArray).readByte();
            frameRate = (data as ByteArray).readUnsignedInt();
            classesCount = (data as ByteArray).readInt();
            classesList = new Array();
            for(i = 0; i < classesCount; i++)
            {
               classesList.push((data as ByteArray).readUTF());
            }
            swfData = new ByteArray();
            (data as ByteArray).readBytes(swfData);
         }
         catch(eof:EOFError)
         {
            dispatchFailure("Malformated library file (end of file).",ResourceErrorCode.SWL_MALFORMED_LIBRARY);
            return;
         }
         this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
         this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this._onInit = this.onLibraryInit(frameRate,classesList));
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLibraryError);
         var loaderContext:LoaderContext = getUri().loaderContext;
         if(!loaderContext)
         {
            loaderContext = new LoaderContext();
         }
         AirScanner.allowByteCodeExecution(loaderContext,true);
         this._ldr.loadBytes(swfData,loaderContext);
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
      
      protected function releaseLoader() : void
      {
         this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this._onInit);
         this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLibraryError);
         PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
         this._ldr = null;
         this._onInit = null;
      }
      
      private function createResource(frameRate:uint, classesList:Array, appDomain:ApplicationDomain) : void
      {
         this._swl = new Swl(frameRate,classesList,appDomain);
         dispatchSuccess(null,null);
      }
      
      protected function onLibraryInit(frameRate:uint, classesList:Array) : Function
      {
         return function(e:Event):void
         {
            var l:* = undefined;
            var j:* = undefined;
            var numClip:* = undefined;
            var i:* = undefined;
            var child:* = undefined;
            var loaderInfo:* = e.target as LoaderInfo;
            var ap:* = loaderInfo.applicationDomain;
            var clip:* = loaderInfo.content as MovieClip;
            if(clip)
            {
               clip.stop();
               l = clip.totalFrames;
               for(j = 0; j < l; j++)
               {
                  numClip = clip.numChildren;
                  i = -1;
                  while(++i < numClip)
                  {
                     child = clip.removeChildAt(0) as MovieClip;
                     if(child)
                     {
                        child.stop();
                     }
                  }
               }
               if(l > 1 || numClip > 0)
               {
                  _log.warn("Found and cleaned multiple frames and/or children on the scene of " + getUri().toString() + ", its FLA should be cleaned though!");
               }
            }
            createResource(frameRate,classesList,ap);
            releaseLoader();
         };
      }
      
      private function onLibraryError(ee:ErrorEvent) : void
      {
         dispatchFailure("Library loading from binaries failed: " + ee.text,ResourceErrorCode.SWL_MALFORMED_BINARY);
         this.releaseLoader();
      }
   }
}
