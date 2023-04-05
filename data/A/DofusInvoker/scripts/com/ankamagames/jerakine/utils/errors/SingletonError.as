package com.ankamagames.jerakine.utils.errors
{
   public class SingletonError extends Error
   {
       
      
      public function SingletonError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
