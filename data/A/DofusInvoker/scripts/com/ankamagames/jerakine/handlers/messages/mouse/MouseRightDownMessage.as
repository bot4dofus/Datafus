package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightDownMessage extends MouseMessage
   {
       
      
      public function MouseRightDownMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseRightDownMessage
      {
         if(!instance)
         {
            instance = new MouseRightDownMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseRightDownMessage;
      }
   }
}
