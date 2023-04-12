package com.ankamagames.jerakine.logger
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public static const LOG_EVENT:String = "logEvent";
       
      
      public var message:String;
      
      public var level:uint;
      
      public var category:String;
      
      public var timestamp:Date;
      
      public var time:Number;
      
      public var stackTrace:String;
      
      public function LogEvent(category:String = null, message:String = null, logLevel:uint = 0, timestamp:Date = null, stackTrace:String = "")
      {
         var tmpStack:String = null;
         var tmpArrStack:Array = null;
         super(LOG_EVENT,false,false);
         this.category = category;
         this.message = message;
         this.level = logLevel;
         this.timestamp = !!timestamp ? timestamp : new Date();
         this.time = this.timestamp.time;
         this.stackTrace = stackTrace;
         if(!stackTrace && (logLevel == LogLevel.ERROR || logLevel == LogLevel.FATAL || logLevel == LogLevel.WARN || logLevel == LogLevel.DEBUG))
         {
            tmpStack = new Error().getStackTrace();
            if(tmpStack && tmpStack.length > 0)
            {
               tmpArrStack = tmpStack.split("\n");
               if(tmpArrStack && tmpArrStack.length > 5)
               {
                  tmpArrStack.splice(0,5);
                  tmpStack = tmpArrStack.join("\n");
                  this.stackTrace = tmpStack;
               }
            }
         }
      }
      
      public function get formattedTimestamp() : String
      {
         var str:String = this.timestamp.toTimeString().split(" ")[0];
         var ms:String = this.timestamp.milliseconds.toString();
         while(ms.length < 3)
         {
            ms = "0" + ms;
         }
         return str + (":" + ms);
      }
      
      override public function clone() : Event
      {
         return new LogEvent(this.category,this.message,this.level,this.timestamp);
      }
   }
}
