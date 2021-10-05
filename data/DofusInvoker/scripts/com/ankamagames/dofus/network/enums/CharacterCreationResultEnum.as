package com.ankamagames.dofus.network.enums
{
   public class CharacterCreationResultEnum
   {
      
      public static const OK:uint = 0;
      
      public static const ERR_NO_REASON:uint = 1;
      
      public static const ERR_INVALID_NAME:uint = 2;
      
      public static const ERR_NAME_ALREADY_EXISTS:uint = 3;
      
      public static const ERR_TOO_MANY_CHARACTERS:uint = 4;
      
      public static const ERR_NOT_ALLOWED:uint = 5;
      
      public static const ERR_NEW_PLAYER_NOT_ALLOWED:uint = 6;
      
      public static const ERR_RESTRICED_ZONE:uint = 7;
      
      public static const ERR_INCONSISTENT_COMMUNITY:uint = 8;
       
      
      public function CharacterCreationResultEnum()
      {
         super();
      }
   }
}
