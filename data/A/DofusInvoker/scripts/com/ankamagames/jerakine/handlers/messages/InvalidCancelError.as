package com.ankamagames.jerakine.handlers.messages
{
   public class InvalidCancelError extends Error
   {
       
      
      public function InvalidCancelError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
