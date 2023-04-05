package com.ankamagames.jerakine.utils.errors
{
   public class JerakineError extends Error
   {
       
      
      public function JerakineError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
