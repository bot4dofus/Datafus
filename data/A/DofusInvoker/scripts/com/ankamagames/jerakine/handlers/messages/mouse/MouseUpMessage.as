package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseUpMessage extends MouseMessage
   {
       
      
      public function MouseUpMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseUpMessage
      {
         if(!instance)
         {
            instance = new MouseUpMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseUpMessage;
      }
   }
}
