package mx.preloaders
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Timer;
   import mx.core.RSLItem;
   import mx.core.RSLListLoader;
   import mx.core.ResourceModuleRSLItem;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.RSLEvent;
   import mx.managers.SystemManagerGlobals;
   import mx.resources.IResourceManager;
   
   use namespace mx_internal;
   
   public class Preloader extends Sprite
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var displayClass:IPreloaderDisplay = null;
      
      private var timer:Timer;
      
      private var showDisplay:Boolean;
      
      private var rslListLoader:RSLListLoader;
      
      private var resourceModuleListLoader:RSLListLoader;
      
      private var rslDone:Boolean = false;
      
      private var loadingRSLs:Boolean = false;
      
      private var waitingToLoadResourceModules:Boolean = false;
      
      private var sentDocFrameReady:Boolean = false;
      
      private var app:IEventDispatcher = null;
      
      private var applicationDomain:ApplicationDomain = null;
      
      private var waitedAFrame:Boolean = false;
      
      public function Preloader()
      {
         super();
      }
      
      public function initialize(showDisplay:Boolean, displayClassName:Class, backgroundColor:uint, backgroundAlpha:Number, backgroundImage:Object, backgroundSize:String, displayWidth:Number, displayHeight:Number, libs:Array = null, sizes:Array = null, rslList:Array = null, resourceModuleURLs:Array = null, applicationDomain:ApplicationDomain = null) : void
      {
         var n:int = 0;
         var i:int = 0;
         var node:RSLItem = null;
         var resourceModuleNode:ResourceModuleRSLItem = null;
         if((libs != null || sizes != null) && rslList != null)
         {
            throw new Error("RSLs may only be specified by using libs and sizes or rslList, not both.");
         }
         this.applicationDomain = applicationDomain;
         root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         if(libs && libs.length > 0)
         {
            if(rslList == null)
            {
               rslList = [];
            }
            n = libs.length;
            for(i = 0; i < n; i++)
            {
               node = new RSLItem(libs[i]);
               rslList.push(node);
            }
         }
         var resourceModuleList:Array = [];
         if(resourceModuleURLs && resourceModuleURLs.length > 0)
         {
            n = resourceModuleURLs.length;
            for(i = 0; i < n; i++)
            {
               resourceModuleNode = new ResourceModuleRSLItem(resourceModuleURLs[i],applicationDomain);
               resourceModuleList.push(resourceModuleNode);
            }
         }
         this.rslListLoader = new RSLListLoader(rslList);
         if(resourceModuleList.length)
         {
            this.resourceModuleListLoader = new RSLListLoader(resourceModuleList);
         }
         this.showDisplay = showDisplay;
         this.timer = new Timer(10);
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.timer.start();
         if(showDisplay)
         {
            this.displayClass = new displayClassName();
            this.displayClass.addEventListener(Event.COMPLETE,this.displayClassCompleteHandler);
            addChild(DisplayObject(this.displayClass));
            this.displayClass.backgroundColor = backgroundColor;
            this.displayClass.backgroundAlpha = backgroundAlpha;
            this.displayClass.backgroundImage = backgroundImage;
            this.displayClass.backgroundSize = backgroundSize;
            this.displayClass.stageWidth = displayWidth;
            this.displayClass.stageHeight = displayHeight;
            this.displayClass.initialize();
            this.displayClass.preloader = this;
            this.addEventListener(Event.ENTER_FRAME,this.waitAFrame);
         }
         if(this.rslListLoader.getItemCount() > 0)
         {
            this.rslListLoader.load(this.rslProgressHandler,this.rslCompleteHandler,this.rslErrorHandler,this.rslErrorHandler,this.rslErrorHandler);
            this.loadingRSLs = true;
         }
         else if(this.resourceModuleListLoader && this.resourceModuleListLoader.getItemCount() > 0)
         {
            if(applicationDomain.hasDefinition("mx.resources::ResourceManager"))
            {
               this.rslListLoader = this.resourceModuleListLoader;
               this.rslListLoader.load(this.rslProgressHandler,this.rslCompleteHandler,this.rslErrorHandler,this.rslErrorHandler,this.rslErrorHandler);
            }
            else
            {
               this.waitingToLoadResourceModules = true;
               this.rslDone = true;
            }
         }
         else
         {
            this.rslDone = true;
         }
      }
      
      public function registerApplication(app:IEventDispatcher) : void
      {
         app.addEventListener("validatePropertiesComplete",this.appProgressHandler);
         app.addEventListener("validateSizeComplete",this.appProgressHandler);
         app.addEventListener("validateDisplayListComplete",this.appProgressHandler);
         app.addEventListener(FlexEvent.CREATION_COMPLETE,this.appCreationCompleteHandler);
         this.app = app;
      }
      
      private function getByteValues() : Object
      {
         var rslTotal:int = 0;
         var li:LoaderInfo = root.loaderInfo;
         var loaded:int = li.bytesLoaded;
         var total:int = li.bytesTotal;
         var n:int = !!this.rslListLoader ? int(this.rslListLoader.getItemCount()) : 0;
         for(var i:int = 0; i < n; i++)
         {
            loaded += this.rslListLoader.getItem(i).loaded;
            rslTotal = this.rslListLoader.getItem(i).total;
            total += rslTotal;
         }
         return {
            "loaded":loaded,
            "total":total
         };
      }
      
      private function dispatchAppEndEvent(event:Object = null) : void
      {
         dispatchEvent(new FlexEvent(FlexEvent.INIT_COMPLETE));
         if(!this.showDisplay)
         {
            this.displayClassCompleteHandler(null);
         }
      }
      
      mx_internal function rslProgressHandler(event:ProgressEvent) : void
      {
         var index:int = this.rslListLoader.getIndex();
         var item:RSLItem = this.rslListLoader.getItem(index);
         var rslEvent:RSLEvent = new RSLEvent(RSLEvent.RSL_PROGRESS);
         rslEvent.isResourceModule = this.rslListLoader == this.resourceModuleListLoader;
         rslEvent.bytesLoaded = event.bytesLoaded;
         rslEvent.bytesTotal = event.bytesTotal;
         rslEvent.rslIndex = index;
         rslEvent.rslTotal = this.rslListLoader.getItemCount();
         rslEvent.url = item.urlRequest;
         dispatchEvent(rslEvent);
      }
      
      mx_internal function rslCompleteHandler(event:Event) : void
      {
         var index:int = this.rslListLoader.getIndex();
         var item:RSLItem = this.rslListLoader.getItem(index);
         var rslEvent:RSLEvent = new RSLEvent(RSLEvent.RSL_COMPLETE);
         rslEvent.isResourceModule = this.rslListLoader == this.resourceModuleListLoader;
         rslEvent.bytesLoaded = item.total;
         rslEvent.bytesTotal = item.total;
         rslEvent.loaderInfo = event.target as LoaderInfo;
         rslEvent.rslIndex = index;
         rslEvent.rslTotal = this.rslListLoader.getItemCount();
         rslEvent.url = item.urlRequest;
         dispatchEvent(rslEvent);
         if(this.loadingRSLs && this.resourceModuleListLoader && index + 1 == rslEvent.rslTotal)
         {
            this.loadingRSLs = false;
            this.waitingToLoadResourceModules = true;
         }
         this.rslDone = index + 1 == rslEvent.rslTotal;
      }
      
      mx_internal function rslErrorHandler(event:ErrorEvent) : void
      {
         var index:int = this.rslListLoader.getIndex();
         var item:RSLItem = this.rslListLoader.getItem(index);
         var rslEvent:RSLEvent = new RSLEvent(RSLEvent.RSL_ERROR);
         rslEvent.isResourceModule = this.rslListLoader == this.resourceModuleListLoader;
         rslEvent.bytesLoaded = 0;
         rslEvent.bytesTotal = 0;
         rslEvent.rslIndex = index;
         rslEvent.rslTotal = this.rslListLoader.getItemCount();
         rslEvent.url = item.urlRequest;
         rslEvent.errorText = decodeURI(event.text);
         dispatchEvent(rslEvent);
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         var resourceManager:IResourceManager = null;
         var localeChainList:String = null;
         var resourceManagerClass:Class = null;
         if(!root)
         {
            return;
         }
         var bytes:Object = this.getByteValues();
         var loaded:int = bytes.loaded;
         var total:int = bytes.total;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,loaded,total));
         if(this.waitingToLoadResourceModules)
         {
            if(this.applicationDomain.hasDefinition("mx.resources::ResourceManager"))
            {
               this.waitingToLoadResourceModules = false;
               this.rslListLoader = this.resourceModuleListLoader;
               this.rslDone = false;
               this.rslListLoader.load(this.rslProgressHandler,this.rslCompleteHandler,this.rslErrorHandler,this.rslErrorHandler,this.rslErrorHandler);
            }
         }
         if(this.rslDone && (loaded >= total && total > 0 || total == 0 && loaded > 0 || root is MovieClip && MovieClip(root).totalFrames > 2 && MovieClip(root).framesLoaded >= 2))
         {
            if(!this.sentDocFrameReady)
            {
               if(this.showDisplay && !this.waitedAFrame)
               {
                  return;
               }
               this.sentDocFrameReady = true;
               dispatchEvent(new FlexEvent(FlexEvent.PRELOADER_DOC_FRAME_READY));
               return;
            }
            if(this.waitingToLoadResourceModules)
            {
               if(this.applicationDomain.hasDefinition("mx.resources::ResourceManager"))
               {
                  this.waitingToLoadResourceModules = false;
                  this.rslListLoader = this.resourceModuleListLoader;
                  this.rslDone = false;
                  this.rslListLoader.load(this.rslProgressHandler,this.rslCompleteHandler,this.rslErrorHandler,this.rslErrorHandler,this.rslErrorHandler);
                  return;
               }
            }
            if(this.resourceModuleListLoader)
            {
               if(this.applicationDomain.hasDefinition("mx.resources::ResourceManager"))
               {
                  resourceManagerClass = Class(this.applicationDomain.getDefinition("mx.resources::ResourceManager"));
                  resourceManager = IResourceManager(resourceManagerClass["getInstance"]());
               }
               localeChainList = SystemManagerGlobals.parameters["localeChain"];
               if(localeChainList != null && localeChainList != "")
               {
                  resourceManager.localeChain = localeChainList.split(",");
               }
            }
            this.timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
            this.timer.reset();
            dispatchEvent(new Event(Event.COMPLETE));
            dispatchEvent(new FlexEvent(FlexEvent.INIT_PROGRESS));
         }
      }
      
      private function ioErrorHandler(event:IOErrorEvent) : void
      {
      }
      
      private function displayClassCompleteHandler(event:Event) : void
      {
         if(this.displayClass)
         {
            this.displayClass.removeEventListener(Event.COMPLETE,this.displayClassCompleteHandler);
         }
         if(root)
         {
            root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         }
         if(this.app)
         {
            this.app.removeEventListener("validatePropertiesComplete",this.appProgressHandler);
            this.app.removeEventListener("validateSizeComplete",this.appProgressHandler);
            this.app.removeEventListener("validateDisplayListComplete",this.appProgressHandler);
            this.app.removeEventListener(FlexEvent.CREATION_COMPLETE,this.appCreationCompleteHandler);
            this.app = null;
         }
         dispatchEvent(new FlexEvent(FlexEvent.PRELOADER_DONE));
      }
      
      private function appCreationCompleteHandler(event:FlexEvent) : void
      {
         this.dispatchAppEndEvent();
      }
      
      private function appProgressHandler(event:Event) : void
      {
         dispatchEvent(new FlexEvent(FlexEvent.INIT_PROGRESS));
      }
      
      private function waitAFrame(event:Event) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.waitAFrame);
         this.waitedAFrame = true;
      }
   }
}
