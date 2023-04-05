package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightClickOutsideMessage extends MouseMessage
   {
       
      
      public function MouseRightClickOutsideMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseRightClickOutsideMessage
      {
         if(!instance)
         {
            instance = new MouseRightClickOutsideMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseRightClickOutsideMessage;
      }
   }
}
