package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseClickMessage extends MouseMessage
   {
       
      
      public function MouseClickMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseClickMessage
      {
         if(!instance)
         {
            instance = new MouseClickMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseClickMessage;
      }
   }
}
