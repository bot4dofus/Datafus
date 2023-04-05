package com.ankamagames.jerakine.resources.events
{
   import flash.events.Event;
   
   public class ResourceEvent extends Event
   {
       
      
      public function ResourceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new ResourceEvent(type,bubbles,cancelable);
      }
   }
}
