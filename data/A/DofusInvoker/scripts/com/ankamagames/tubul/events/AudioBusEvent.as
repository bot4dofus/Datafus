package com.ankamagames.tubul.events
{
   import com.ankamagames.tubul.interfaces.ISound;
   import flash.events.Event;
   
   public class AudioBusEvent extends Event
   {
      
      public static const ADD_SOUND_IN_BUS:String = "add_sound_in_bus";
      
      public static const REMOVE_SOUND_IN_BUS:String = "remove_sound_in_bus";
       
      
      public var sound:ISound;
      
      public function AudioBusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var abe:AudioBusEvent = new AudioBusEvent(type,bubbles,cancelable);
         abe.sound = this.sound;
         return abe;
      }
   }
}
