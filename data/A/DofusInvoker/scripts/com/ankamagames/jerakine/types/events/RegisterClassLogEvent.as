package com.ankamagames.jerakine.types.events
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.events.Event;
   
   public class RegisterClassLogEvent extends LogEvent
   {
       
      
      private var _className:String;
      
      public function RegisterClassLogEvent(className:String)
      {
         super(null,null,0);
         this._className = className;
      }
      
      public function get className() : String
      {
         return this._className;
      }
      
      override public function clone() : Event
      {
         return new RegisterClassLogEvent(this._className);
      }
   }
}
