package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseDoubleClickMessage extends MouseMessage
   {
       
      
      public function MouseDoubleClickMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseDoubleClickMessage
      {
         if(!instance)
         {
            instance = new MouseDoubleClickMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseDoubleClickMessage;
      }
   }
}
