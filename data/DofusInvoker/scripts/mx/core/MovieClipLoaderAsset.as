package mx.core
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   use namespace mx_internal;
   
   [Event(name="complete",type="flash.events.Event")]
   public class MovieClipLoaderAsset extends MovieClipAsset implements IFlexAsset, IFlexDisplayObject
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var loader:Loader = null;
      
      private var initialized:Boolean = false;
      
      private var requestedWidth:Number;
      
      private var requestedHeight:Number;
      
      protected var initialWidth:Number = 0;
      
      protected var initialHeight:Number = 0;
      
      public function MovieClipLoaderAsset()
      {
         super();
         var loaderContext:LoaderContext = new LoaderContext();
         loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         if("allowLoadBytesCodeExecution" in loaderContext)
         {
            loaderContext["allowLoadBytesCodeExecution"] = true;
         }
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
         this.loader.loadBytes(this.movieClipData,loaderContext);
         addChild(this.loader);
      }
      
      override public function get height() : Number
      {
         if(!this.initialized)
         {
            return this.initialHeight;
         }
         return super.height;
      }
      
      override public function set height(value:Number) : void
      {
         if(!this.initialized)
         {
            this.requestedHeight = value;
         }
         else
         {
            this.loader.height = value;
         }
      }
      
      override public function get measuredHeight() : Number
      {
         return this.initialHeight;
      }
      
      override public function get measuredWidth() : Number
      {
         return this.initialWidth;
      }
      
      override public function get width() : Number
      {
         if(!this.initialized)
         {
            return this.initialWidth;
         }
         return super.width;
      }
      
      override public function set width(value:Number) : void
      {
         if(!this.initialized)
         {
            this.requestedWidth = value;
         }
         else
         {
            this.loader.width = value;
         }
      }
      
      public function get movieClipData() : ByteArray
      {
         return null;
      }
      
      private function completeHandler(event:Event) : void
      {
         this.initialized = true;
         this.initialWidth = this.loader.contentLoaderInfo.width;
         this.initialHeight = this.loader.contentLoaderInfo.height;
         if(!isNaN(this.requestedWidth))
         {
            this.loader.width = this.requestedWidth;
         }
         if(!isNaN(this.requestedHeight))
         {
            this.loader.height = this.requestedHeight;
         }
         dispatchEvent(event);
      }
   }
}
