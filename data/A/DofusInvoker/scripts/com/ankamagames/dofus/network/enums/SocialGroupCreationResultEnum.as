package com.ankamagames.dofus.network.enums
{
   public class SocialGroupCreationResultEnum
   {
      
      public static const SOCIAL_GROUP_CREATE_OK:uint = 1;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:uint = 2;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:uint = 3;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:uint = 4;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:uint = 5;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_LEAVE:uint = 6;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_CANCEL:uint = 7;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:uint = 8;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_EMBLEM_INVALID:uint = 9;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_TAG_INVALID:uint = 10;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_TAG_ALREADY_EXISTS:uint = 11;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_NEEDS_SUBGROUP:uint = 12;
      
      public static const SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:uint = 99;
       
      
      public function SocialGroupCreationResultEnum()
      {
         super();
      }
   }
}
