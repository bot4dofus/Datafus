package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseDownMessage extends MouseMessage
   {
       
      
      public function MouseDownMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseDownMessage
      {
         if(!instance)
         {
            instance = new MouseDownMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseDownMessage;
      }
   }
}
