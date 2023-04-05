package com.ankamagames.dofus.network.enums
{
   public class ServerConnectionErrorEnum
   {
      
      public static const SERVER_CONNECTION_ERROR_DUE_TO_STATUS:uint = 0;
      
      public static const SERVER_CONNECTION_ERROR_NO_REASON:uint = 1;
      
      public static const SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:uint = 2;
      
      public static const SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:uint = 3;
      
      public static const SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:uint = 4;
      
      public static const SERVER_CONNECTION_ERROR_MONOACCOUNT_CANNOT_VERIFY:uint = 5;
      
      public static const SERVER_CONNECTION_ERROR_MONOACCOUNT_ONLY:uint = 6;
      
      public static const SERVER_CONNECTION_ERROR_SERVER_OVERLOAD:uint = 7;
       
      
      public function ServerConnectionErrorEnum()
      {
         super();
      }
   }
}
