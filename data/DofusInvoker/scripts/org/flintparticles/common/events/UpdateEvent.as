package org.flintparticles.common.events
{
   import flash.events.Event;
   
   public class UpdateEvent extends Event
   {
      
      public static var UPDATE:String = "update";
       
      
      public var time:Number;
      
      public function UpdateEvent(type:String, time:Number = NaN, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.time = time;
      }
   }
}
