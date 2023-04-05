package com.ankamagames.jerakine.messages.events
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.events.Event;
   
   public class FramePulledEvent extends Event
   {
      
      public static const EVENT_FRAME_PULLED:String = "event_frame_pulled";
       
      
      private var _frame:Frame;
      
      public function FramePulledEvent(frame:Frame)
      {
         super(EVENT_FRAME_PULLED,false,false);
         this._frame = frame;
      }
      
      public function get frame() : Frame
      {
         return this._frame;
      }
   }
}
