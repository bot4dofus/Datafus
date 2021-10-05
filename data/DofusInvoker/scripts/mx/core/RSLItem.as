package mx.core
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import mx.events.RSLEvent;
   import mx.utils.LoaderUtil;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class RSLItem
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public var urlRequest:URLRequest;
      
      public var total:uint = 0;
      
      public var loaded:uint = 0;
      
      public var rootURL:String;
      
      protected var chainedProgressHandler:Function;
      
      protected var chainedCompleteHandler:Function;
      
      protected var chainedIOErrorHandler:Function;
      
      protected var chainedSecurityErrorHandler:Function;
      
      protected var chainedRSLErrorHandler:Function;
      
      private var completed:Boolean = false;
      
      private var errorText:String;
      
      protected var moduleFactory:IFlexModuleFactory;
      
      protected var url:String;
      
      public function RSLItem(url:String, rootURL:String = null, moduleFactory:IFlexModuleFactory = null)
      {
         super();
         this.url = url;
         this.rootURL = rootURL;
         this.moduleFactory = moduleFactory;
      }
      
      public function load(progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void
      {
         this.chainedProgressHandler = progressHandler;
         this.chainedCompleteHandler = completeHandler;
         this.chainedIOErrorHandler = ioErrorHandler;
         this.chainedSecurityErrorHandler = securityErrorHandler;
         this.chainedRSLErrorHandler = rslErrorHandler;
         var loader:Loader = new Loader();
         var loaderContext:LoaderContext = new LoaderContext();
         this.urlRequest = new URLRequest(LoaderUtil.createAbsoluteURL(this.rootURL,this.url));
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.itemProgressHandler);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.itemCompleteHandler);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.itemErrorHandler);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.itemErrorHandler);
         if(this.moduleFactory != null)
         {
            loaderContext.applicationDomain = this.moduleFactory.info()["currentDomain"];
         }
         else
         {
            loaderContext.applicationDomain = ApplicationDomain.currentDomain;
         }
         loader.load(this.urlRequest,loaderContext);
      }
      
      public function itemProgressHandler(event:ProgressEvent) : void
      {
         this.loaded = event.bytesLoaded;
         this.total = event.bytesTotal;
         if(this.chainedProgressHandler != null)
         {
            this.chainedProgressHandler(event);
         }
      }
      
      public function itemCompleteHandler(event:Event) : void
      {
         this.completed = true;
         if(this.chainedCompleteHandler != null)
         {
            this.chainedCompleteHandler(event);
         }
      }
      
      public function itemErrorHandler(event:ErrorEvent) : void
      {
         this.errorText = decodeURI(event.text);
         this.completed = true;
         this.loaded = 0;
         this.total = 0;
         trace(this.errorText);
         if(event.type == IOErrorEvent.IO_ERROR && this.chainedIOErrorHandler != null)
         {
            this.chainedIOErrorHandler(event);
         }
         else if(event.type == SecurityErrorEvent.SECURITY_ERROR && this.chainedSecurityErrorHandler != null)
         {
            this.chainedSecurityErrorHandler(event);
         }
         else if(event.type == RSLEvent.RSL_ERROR && this.chainedRSLErrorHandler != null)
         {
            this.chainedRSLErrorHandler(event);
         }
      }
   }
}
