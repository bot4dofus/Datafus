package com.ankamagames.dofus.network.enums
{
   public class NicknameErrorEnum
   {
      
      public static const ALREADY_USED:uint = 1;
      
      public static const SAME_AS_LOGIN:uint = 2;
      
      public static const TOO_SIMILAR_TO_LOGIN:uint = 3;
      
      public static const INVALID_NICK:uint = 4;
      
      public static const UNKNOWN_NICK_ERROR:uint = 99;
       
      
      public function NicknameErrorEnum()
      {
         super();
      }
   }
}
