package mx.logging
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class LogLogger extends EventDispatcher implements ILogger
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var resourceManager:IResourceManager;
      
      private var _category:String;
      
      public function LogLogger(category:String)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._category = category;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function log(level:int, msg:String, ... rest) : void
      {
         var message:String = null;
         var i:int = 0;
         if(level < LogEventLevel.DEBUG)
         {
            message = this.resourceManager.getString("logging","levelLimit");
            throw new ArgumentError(message);
         }
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,level));
         }
      }
      
      public function debug(msg:String, ... rest) : void
      {
         var i:int = 0;
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,LogEventLevel.DEBUG));
         }
      }
      
      public function error(msg:String, ... rest) : void
      {
         var i:int = 0;
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,LogEventLevel.ERROR));
         }
      }
      
      public function fatal(msg:String, ... rest) : void
      {
         var i:int = 0;
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,LogEventLevel.FATAL));
         }
      }
      
      public function info(msg:String, ... rest) : void
      {
         var i:int = 0;
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,LogEventLevel.INFO));
         }
      }
      
      public function warn(msg:String, ... rest) : void
      {
         var i:int = 0;
         if(hasEventListener(LogEvent.LOG))
         {
            for(i = 0; i < rest.length; i++)
            {
               msg = msg.replace(new RegExp("\\{" + i + "\\}","g"),rest[i]);
            }
            dispatchEvent(new LogEvent(msg,LogEventLevel.WARN));
         }
      }
   }
}
