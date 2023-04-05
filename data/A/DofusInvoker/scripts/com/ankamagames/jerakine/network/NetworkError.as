package com.ankamagames.jerakine.network
{
   public class NetworkError extends Error
   {
       
      
      public function NetworkError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
