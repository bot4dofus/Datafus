package com.ankamagames.jerakine.utils.errors
{
   public class FileTypeError extends Error
   {
       
      
      public function FileTypeError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
