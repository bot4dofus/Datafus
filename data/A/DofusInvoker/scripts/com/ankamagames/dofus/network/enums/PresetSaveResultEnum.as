package com.ankamagames.dofus.network.enums
{
   public class PresetSaveResultEnum
   {
      
      public static const PRESET_SAVE_OK:uint = 1;
      
      public static const PRESET_SAVE_ERR_UNKNOWN:uint = 2;
      
      public static const PRESET_SAVE_ERR_TOO_MANY:uint = 3;
      
      public static const PRESET_SAVE_ERR_INVALID_PLAYER_STATE:uint = 4;
      
      public static const PRESET_SAVE_ERR_SYSTEM_INACTIVE:uint = 5;
      
      public static const PRESET_SAVE_ERR_INVALID_ID:uint = 6;
       
      
      public function PresetSaveResultEnum()
      {
         super();
      }
   }
}
