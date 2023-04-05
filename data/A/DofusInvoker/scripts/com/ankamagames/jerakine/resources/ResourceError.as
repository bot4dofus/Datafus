package com.ankamagames.jerakine.resources
{
   public class ResourceError extends Error
   {
       
      
      public function ResourceError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
