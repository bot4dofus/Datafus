package com.ankamagames.dofus.network.enums
{
   public class IdentificationFailureReasonEnum
   {
      
      public static const BAD_VERSION:uint = 1;
      
      public static const WRONG_CREDENTIALS:uint = 2;
      
      public static const BANNED:uint = 3;
      
      public static const KICKED:uint = 4;
      
      public static const IN_MAINTENANCE:uint = 5;
      
      public static const TOO_MANY_ON_IP:uint = 6;
      
      public static const TIME_OUT:uint = 7;
      
      public static const BAD_IPRANGE:uint = 8;
      
      public static const CREDENTIALS_RESET:uint = 9;
      
      public static const EMAIL_UNVALIDATED:uint = 10;
      
      public static const OTP_TIMEOUT:uint = 11;
      
      public static const LOCKED:uint = 12;
      
      public static const ANONYMOUS_IP_FORBIDDEN:uint = 13;
      
      public static const INVALID_SHIELD_CERTIFICATE:uint = 14;
      
      public static const ALREADY_CONNECTED:uint = 15;
      
      public static const SERVICE_UNAVAILABLE:uint = 53;
      
      public static const EXTERNAL_ACCOUNT_LINK_REFUSED:uint = 61;
      
      public static const EXTERNAL_ACCOUNT_ALREADY_LINKED:uint = 62;
      
      public static const UNKNOWN_AUTH_ERROR:uint = 99;
      
      public static const SPARE:uint = 100;
       
      
      public function IdentificationFailureReasonEnum()
      {
         super();
      }
   }
}
