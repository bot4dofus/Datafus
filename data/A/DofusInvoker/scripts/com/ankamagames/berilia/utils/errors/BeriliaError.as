package com.ankamagames.berilia.utils.errors
{
   public class BeriliaError extends Error
   {
       
      
      public function BeriliaError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
