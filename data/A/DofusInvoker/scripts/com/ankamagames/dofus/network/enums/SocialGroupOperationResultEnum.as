package com.ankamagames.dofus.network.enums
{
   public class SocialGroupOperationResultEnum
   {
      
      public static const SOCIAL_GROUP_OPERATION_OK:uint = 1;
      
      public static const SOCIAL_GROUP_ERROR_NAME_INVALID:uint = 2;
      
      public static const SOCIAL_GROUP_ERROR_ALREADY_IN_GROUP:uint = 3;
      
      public static const SOCIAL_GROUP_ERROR_NAME_ALREADY_EXISTS:uint = 4;
      
      public static const SOCIAL_GROUP_ERROR_LEAVE:uint = 5;
      
      public static const SOCIAL_GROUP_ERROR_CANCEL:uint = 6;
      
      public static const SOCIAL_GROUP_ERROR_REQUIREMENT_UNMET:uint = 7;
      
      public static const SOCIAL_GROUP_ERROR_EMBLEM_INVALID:uint = 8;
      
      public static const SOCIAL_GROUP_ERROR_TAG_INVALID:uint = 9;
      
      public static const SOCIAL_GROUP_ERROR_TAG_ALREADY_EXISTS:uint = 10;
      
      public static const SOCIAL_GROUP_ERROR_UNKNOWN:uint = 99;
       
      
      public function SocialGroupOperationResultEnum()
      {
         super();
      }
   }
}
