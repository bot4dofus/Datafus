package com.ankamagames.dofus.network.enums
{
   public class BidValidationEnum
   {
      
      public static const GENERIC_ERROR:uint = 0;
      
      public static const BUFFER_OVERLOAD:uint = 1;
      
      public static const OFFER_DOESNT_EXIST:uint = 2;
      
      public static const OFFER_ALREADY_EXISTS:uint = 3;
      
      public static const NOT_ENOUGH_KAMAS:uint = 4;
      
      public static const NOT_ENOUGH_OGRINES:uint = 5;
      
      public static const SERVER_MAINTENANCE:uint = 6;
      
      public static const PLAYER_IN_DEBT:uint = 7;
      
      public static const OFFER_IS_YOURS:uint = 8;
      
      public static const VALIDATION_SUCCESS:uint = 100;
       
      
      public function BidValidationEnum()
      {
         super();
      }
   }
}
