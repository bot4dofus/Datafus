package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightClickMessage extends MouseMessage
   {
       
      
      public function MouseRightClickMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseRightClickMessage
      {
         if(!instance)
         {
            instance = new MouseRightClickMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseRightClickMessage;
      }
   }
}
