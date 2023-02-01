package com.ankamagames.dofus.network.enums
{
   public class ExchangeErrorEnum
   {
      
      public static const REQUEST_IMPOSSIBLE:int = 1;
      
      public static const REQUEST_CHARACTER_OCCUPIED:int = 2;
      
      public static const REQUEST_CHARACTER_JOB_NOT_EQUIPED:int = 3;
      
      public static const REQUEST_CHARACTER_TOOL_TOO_FAR:int = 4;
      
      public static const REQUEST_CHARACTER_OVERLOADED:int = 5;
      
      public static const REQUEST_CHARACTER_NOT_SUSCRIBER:int = 6;
      
      public static const REQUEST_CHARACTER_RESTRICTED:int = 7;
      
      public static const REQUEST_CHARACTER_GUEST:int = 8;
      
      public static const SELL_ERROR:int = 63;
      
      public static const BUY_ERROR:int = 64;
      
      public static const MOUNT_PADDOCK_ERROR:int = 10;
      
      public static const BID_SEARCH_ERROR:int = 11;
       
      
      public function ExchangeErrorEnum()
      {
         super();
      }
   }
}
