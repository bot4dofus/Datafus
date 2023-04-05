package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseWheelMessage extends MouseMessage
   {
       
      
      public function MouseWheelMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseWheelMessage
      {
         if(!instance)
         {
            instance = new MouseWheelMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseWheelMessage;
      }
   }
}
