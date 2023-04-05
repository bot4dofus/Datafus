package com.ankamagames.jerakine.handlers.messages.keyboard
{
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   
   public class KeyboardMessage extends HumanInputMessage
   {
       
      
      public function KeyboardMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, keyboardEvent:KeyboardEvent, instance:KeyboardMessage = null) : KeyboardMessage
      {
         if(!instance)
         {
            instance = new KeyboardMessage();
         }
         return HumanInputMessage.create(target,keyboardEvent,instance) as KeyboardMessage;
      }
      
      public function get keyboardEvent() : KeyboardEvent
      {
         return KeyboardEvent(_nativeEvent);
      }
   }
}
