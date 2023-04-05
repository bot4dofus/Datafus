package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import flash.events.Event;
   
   public class FpsManagerEvent extends Event
   {
       
      
      public var data:Object;
      
      public function FpsManagerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
