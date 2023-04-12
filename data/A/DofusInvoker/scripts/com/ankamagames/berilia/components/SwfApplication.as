package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SwfApplication extends GraphicContainer implements UIComponent
   {
       
      
      private var _ldr:Loader;
      
      private var _uri:Uri;
      
      private var _app:DisplayObject;
      
      public var loadedHandler:Function;
      
      public var loadErrorHandler:Function;
      
      public var loadProgressHandler:Function;
      
      public var autoResize:Boolean = true;
      
      public function SwfApplication()
      {
         super();
         mouseEnabled = true;
      }
      
      [Uri]
      public function set uri(v:Uri) : void
      {
         if(!getUi())
         {
            return;
         }
         this._uri = v;
         this.initLoader();
         this._ldr.load(new URLRequest(v.normalizedUri));
      }
      
      [Uri]
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function setByte(bytes:ByteArray, accessKey:Object) : void
      {
         SecureCenter.checkAccessKey(accessKey);
         this.initLoader();
         var lc:LoaderContext = new LoaderContext();
         lc.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         lc.allowCodeImport = true;
         lc.allowLoadBytesCodeExecution = true;
         this._ldr.loadBytes(bytes,lc);
      }
      
      override public function set width(nW:Number) : void
      {
         super.width = nW;
         if(this._app && this.autoResize)
         {
            this._app.width = nW;
         }
      }
      
      override public function set height(nH:Number) : void
      {
         super.height = nH;
         if(this._app && this.autoResize)
         {
            this._app.height = nH;
         }
      }
      
      override public function remove() : void
      {
         this.clearLoader();
         if(this._ldr)
         {
            if(this._ldr.contentLoaderInfo)
            {
               this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this.onInit);
               this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
               this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            }
            if(this._ldr.uncaughtErrorEvents)
            {
               this._ldr.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,trace);
            }
         }
         if(this._app)
         {
            this._app.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMouse);
         }
         this._ldr = null;
         this.loadedHandler = null;
         this.loadErrorHandler = null;
      }
      
      private function initLoader() : void
      {
         if(!this._ldr)
         {
            this._ldr = new Loader();
            this._ldr.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,trace,false,0,true);
            this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this.onInit);
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         else
         {
            this.clearLoader();
         }
      }
      
      private function clearLoader() : void
      {
         if(this._ldr)
         {
            this._ldr.unloadAndStop(true);
         }
         while(numChildren)
         {
            removeChildAt(0);
         }
      }
      
      private function onInit(e:Event) : void
      {
         this._app = this._ldr.content;
         addChild(this._app);
         this._app.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMouse);
         if(this.loadedHandler != null)
         {
            this.loadedHandler(this);
         }
      }
      
      private function onMouseMouse(e:MouseEvent) : void
      {
         stage.dispatchEvent(e);
      }
      
      private function onProgress(e:ProgressEvent) : void
      {
         if(this.loadProgressHandler != null)
         {
            this.loadProgressHandler(this,e);
         }
      }
      
      private function onError(e:Event) : void
      {
         this.clearLoader();
         if(this.loadErrorHandler != null)
         {
            this.loadErrorHandler(this,e);
         }
      }
   }
}

import flash.events.Event;

class AppEvent extends Event
{
    
   
   public var parameters:Object;
   
   function AppEvent(type:String, parameters:Object)
   {
      super(type,false,false);
      this.parameters = parameters;
   }
}
