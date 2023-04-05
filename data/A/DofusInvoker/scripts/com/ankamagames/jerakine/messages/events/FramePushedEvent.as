package com.ankamagames.jerakine.messages.events
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.events.Event;
   
   public class FramePushedEvent extends Event
   {
      
      public static const EVENT_FRAME_PUSHED:String = "event_frame_pushed";
       
      
      private var _frame:Frame;
      
      public function FramePushedEvent(frame:Frame)
      {
         super(EVENT_FRAME_PUSHED,false,false);
         this._frame = frame;
      }
      
      public function get frame() : Frame
      {
         return this._frame;
      }
   }
}
