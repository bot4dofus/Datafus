package com.ankamagames.dofus.network.enums
{
   public class NameComplianceResultEnum
   {
      
      public static const NAME_OK:uint = 0;
      
      public static const ERROR_SERVICE_UNAVAILABLE:uint = 1;
      
      public static const ERROR_NAME_ALREADY_EXISTS:uint = 2;
      
      public static const ERROR_NAME_BAD_ALPHABET:uint = 3;
      
      public static const ERROR_NAME_BAD_LENGTH:uint = 4;
      
      public static const ERROR_BAD_CHAR:uint = 5;
      
      public static const ERROR_INVALID_DASH_POSITION:uint = 6;
      
      public static const ERROR_NAME_WITH_BAD_CASE:uint = 7;
      
      public static const ERROR_TOO_MANY_CONSECUTIVE_IDENTICAL:uint = 8;
      
      public static const ERROR_TOO_MANY_SPECIAL:uint = 9;
      
      public static const ERROR_FORBIDDEN_NAME:uint = 10;
      
      public static const ERROR_RESERVED_NAME:uint = 11;
       
      
      public function NameComplianceResultEnum()
      {
         super();
      }
   }
}
