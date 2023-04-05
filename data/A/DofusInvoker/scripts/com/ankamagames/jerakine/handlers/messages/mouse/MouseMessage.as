package com.ankamagames.jerakine.handlers.messages.mouse
{
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseMessage extends HumanInputMessage
   {
       
      
      public function MouseMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseMessage
      {
         if(!instance)
         {
            instance = new MouseMessage();
         }
         return HumanInputMessage.create(target,mouseEvent,instance) as MouseMessage;
      }
      
      public function get mouseEvent() : MouseEvent
      {
         return MouseEvent(_nativeEvent);
      }
   }
}
