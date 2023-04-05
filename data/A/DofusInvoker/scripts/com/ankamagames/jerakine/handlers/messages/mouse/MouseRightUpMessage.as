package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightUpMessage extends MouseMessage
   {
       
      
      public function MouseRightUpMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseRightUpMessage
      {
         if(!instance)
         {
            instance = new MouseRightUpMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseRightUpMessage;
      }
   }
}
