package com.ankamagames.tubul.events
{
   import com.ankamagames.tubul.interfaces.ISound;
   import flash.events.Event;
   
   public class SoundCompleteEvent extends Event
   {
      
      public static const SOUND_COMPLETE:String = "sound_complete";
       
      
      public var sound:ISound;
      
      public function SoundCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var sce:SoundCompleteEvent = new SoundCompleteEvent(type,bubbles,cancelable);
         sce.sound = this.sound;
         return sce;
      }
   }
}
