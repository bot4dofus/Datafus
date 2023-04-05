package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightReleaseOutsideMessage extends MouseMessage
   {
       
      
      public function MouseRightReleaseOutsideMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage = null) : MouseRightReleaseOutsideMessage
      {
         if(!instance)
         {
            instance = new MouseRightReleaseOutsideMessage();
         }
         return MouseMessage.create(target,mouseEvent,instance) as MouseRightReleaseOutsideMessage;
      }
   }
}
