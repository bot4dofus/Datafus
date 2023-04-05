package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class AudioBusVolumeEvent extends Event
   {
      
      public static const VOLUME_CHANGED:String = "volume_changed";
       
      
      public var newVolume:Number;
      
      public function AudioBusVolumeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var abve:AudioBusVolumeEvent = new AudioBusVolumeEvent(type,bubbles,cancelable);
         abve.newVolume = this.newVolume;
         return abve;
      }
   }
}
