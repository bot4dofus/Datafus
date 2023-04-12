package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   
   public class FrameIdManager
   {
      
      private static var _init:Boolean;
      
      private static var _frameId:uint;
       
      
      public function FrameIdManager()
      {
         super();
      }
      
      public static function get frameId() : uint
      {
         return _frameId;
      }
      
      public static function init() : void
      {
         if(_init)
         {
            return;
         }
         EnterFrameDispatcher.addEventListener(onEnterFrame,EnterFrameConst.FRAME_ID_MANAGER);
         _init = true;
      }
      
      private static function onEnterFrame(e:Event) : void
      {
         ++_frameId;
      }
   }
}
