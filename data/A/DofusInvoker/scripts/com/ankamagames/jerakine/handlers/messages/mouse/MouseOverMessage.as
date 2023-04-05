package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseOverMessage extends MouseMessage
   {
       
      
      public function MouseOverMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseOverMessage
      {
         if(!instance)
         {
            instance = new MouseOverMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseOverMessage;
      }
   }
}
