package com.ankamagames.berilia.utils.errors
{
   public class ApiError extends Error
   {
       
      
      public function ApiError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
