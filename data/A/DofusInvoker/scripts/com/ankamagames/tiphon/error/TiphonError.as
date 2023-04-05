package com.ankamagames.tiphon.error
{
   public class TiphonError extends Error
   {
       
      
      public function TiphonError(message:String, id:uint = 0)
      {
         super(message,id);
      }
   }
}
