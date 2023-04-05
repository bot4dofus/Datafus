package com.ankamagames.tubul.events
{
   import com.ankamagames.tubul.interfaces.ISound;
   import flash.events.Event;
   
   public class PlaylistEvent extends Event
   {
      
      public static const COMPLETE:String = "complete";
      
      public static const NEW_SOUND:String = "new_sound";
      
      public static const SOUND_ENDED:String = "sound_ended";
       
      
      public var newSound:ISound;
      
      public function PlaylistEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var pe:PlaylistEvent = new PlaylistEvent(type,bubbles,cancelable);
         pe.newSound = this.newSound;
         return pe;
      }
   }
}
