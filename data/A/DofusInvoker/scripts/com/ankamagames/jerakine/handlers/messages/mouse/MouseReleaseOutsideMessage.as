package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseReleaseOutsideMessage extends MouseMessage
   {
       
      
      public function MouseReleaseOutsideMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseReleaseOutsideMessage
      {
         if(!instance)
         {
            instance = new MouseReleaseOutsideMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseReleaseOutsideMessage;
      }
   }
}
