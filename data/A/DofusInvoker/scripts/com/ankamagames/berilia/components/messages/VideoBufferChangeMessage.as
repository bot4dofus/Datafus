package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class VideoBufferChangeMessage extends ComponentMessage
   {
       
      
      private var _state:uint;
      
      public function VideoBufferChangeMessage(target:InteractiveObject, state:uint)
      {
         super(target);
         this._state = state;
      }
      
      public function get state() : uint
      {
         return this._state;
      }
   }
}
