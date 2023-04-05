package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class LoopEvent extends Event
   {
      
      public static const SOUND_LOOP:String = "sound_loop";
      
      public static const SOUND_LOOP_ALL_COMPLETE:String = "sound_loop_all_complete";
       
      
      public var sound;
      
      public var loop:uint;
      
      public function LoopEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var le:LoopEvent = new LoopEvent(type,bubbles,cancelable);
         le.sound = this.sound;
         le.loop = this.loop;
         return le;
      }
   }
}
