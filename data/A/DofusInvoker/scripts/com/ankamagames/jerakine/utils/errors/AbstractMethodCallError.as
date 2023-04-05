package com.ankamagames.jerakine.utils.errors
{
   public class AbstractMethodCallError extends Error
   {
       
      
      public function AbstractMethodCallError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
