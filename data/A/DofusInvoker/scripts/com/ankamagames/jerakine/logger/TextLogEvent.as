package com.ankamagames.jerakine.logger
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import flash.events.Event;
   
   public class TextLogEvent extends LogEvent
   {
       
      
      public function TextLogEvent(category:String = null, message:String = null, logLevel:uint = 0)
      {
         super(category,message,logLevel);
         FpsManager.getInstance().watchObject(this,false,"TextLogEvent");
      }
      
      override public function clone() : Event
      {
         return new TextLogEvent(category,message,level);
      }
   }
}
