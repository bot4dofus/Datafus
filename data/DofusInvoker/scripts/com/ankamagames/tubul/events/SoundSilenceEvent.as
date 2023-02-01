package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class SoundSilenceEvent extends Event
   {
      
      public static const START:String = "start";
      
      public static const COMPLETE:String = "complete";
       
      
      public function SoundSilenceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new SoundSilenceEvent(this.type,this.bubbles,this.cancelable);
      }
   }
}
