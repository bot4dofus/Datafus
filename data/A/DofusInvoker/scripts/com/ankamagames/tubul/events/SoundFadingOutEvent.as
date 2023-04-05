package com.ankamagames.tubul.events
{
   import com.ankamagames.tubul.interfaces.ISound;
   import flash.events.Event;
   
   public class SoundFadingOutEvent extends Event
   {
      
      public static const SOUND_FADING_OUT:String = "sound_fading_out";
       
      
      public var sound:ISound;
      
      public function SoundFadingOutEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var sfoe:SoundFadingOutEvent = new SoundFadingOutEvent(type,bubbles,cancelable);
         sfoe.sound = this.sound;
         return sfoe;
      }
   }
}
