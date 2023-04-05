package com.ankamagames.jerakine.handlers.messages.keyboard
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   
   public class KeyboardKeyUpMessage extends KeyboardMessage
   {
       
      
      public function KeyboardKeyUpMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, keyboardEvent:KeyboardEvent, instance:KeyboardMessage = null) : KeyboardKeyUpMessage
      {
         if(!instance)
         {
            instance = new KeyboardKeyUpMessage();
         }
         return KeyboardMessage.create(target,keyboardEvent,instance) as KeyboardKeyUpMessage;
      }
   }
}
