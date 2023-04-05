package com.ankamagames.jerakine.handlers.messages
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public class FocusChangeMessage extends HumanInputMessage
   {
       
      
      public function FocusChangeMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, instance:FocusChangeMessage = null) : FocusChangeMessage
      {
         if(!instance)
         {
            instance = new FocusChangeMessage();
         }
         return HumanInputMessage.create(target,new Event("FocusChange"),instance) as FocusChangeMessage;
      }
   }
}
