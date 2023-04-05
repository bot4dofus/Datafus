package com.ankamagames.dofus.misc.utils
{
   public class CharacterIdConverter
   {
       
      
      public function CharacterIdConverter()
      {
         super();
      }
      
      public static function extractServerCharacterIdFromInterserverCharacterId(interserverCharacterId:Number) : int
      {
         if(interserverCharacterId)
         {
            return Math.floor(interserverCharacterId / 65536);
         }
         return 0;
      }
   }
}
