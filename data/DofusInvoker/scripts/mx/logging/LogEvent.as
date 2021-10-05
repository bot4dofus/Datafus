package mx.logging
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class LogEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const LOG:String = "log";
       
      
      public var level:int;
      
      public var message:String;
      
      public function LogEvent(message:String = "", level:int = 0)
      {
         super(LogEvent.LOG,false,false);
         this.message = message;
         this.level = level;
      }
      
      public static function getLevelString(value:uint) : String
      {
         switch(value)
         {
            case LogEventLevel.INFO:
               return "INFO";
            case LogEventLevel.DEBUG:
               return "DEBUG";
            case LogEventLevel.ERROR:
               return "ERROR";
            case LogEventLevel.WARN:
               return "WARN";
            case LogEventLevel.FATAL:
               return "FATAL";
            case LogEventLevel.ALL:
               return "ALL";
            default:
               return "UNKNOWN";
         }
      }
      
      override public function clone() : Event
      {
         return new LogEvent(this.message,this.level);
      }
   }
}
