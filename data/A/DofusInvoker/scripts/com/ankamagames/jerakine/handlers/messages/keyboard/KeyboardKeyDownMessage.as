package com.ankamagames.jerakine.handlers.messages.keyboard
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   
   public class KeyboardKeyDownMessage extends KeyboardMessage
   {
       
      
      public function KeyboardKeyDownMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, keyboardEvent:KeyboardEvent, instance:KeyboardMessage = null) : KeyboardKeyDownMessage
      {
         if(!instance)
         {
            instance = new KeyboardKeyDownMessage();
         }
         return KeyboardMessage.create(target,keyboardEvent,instance) as KeyboardKeyDownMessage;
      }
   }
}
