package com.ankamagames.tubul.utils.error
{
   public class TubulError extends Error
   {
       
      
      public function TubulError(message:String = "", id:uint = 0)
      {
         super("[TUBUL ERROR]" + message,id);
      }
   }
}
