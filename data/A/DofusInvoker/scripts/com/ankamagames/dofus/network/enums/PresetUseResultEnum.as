package com.ankamagames.dofus.network.enums
{
   public class PresetUseResultEnum
   {
      
      public static const PRESET_USE_OK:uint = 1;
      
      public static const PRESET_USE_OK_PARTIAL:uint = 2;
      
      public static const PRESET_USE_ERR_STATS_FIGHT_PREPARATION:uint = 3;
      
      public static const PRESET_USE_ERR_COOLDOWN:uint = 4;
      
      public static const PRESET_USE_ERR_BAD_PRESET_ID:uint = 5;
      
      public static const PRESET_USE_ERR_INVALID_STATE:uint = 6;
      
      public static const PRESET_USE_ERR_STATS:uint = 7;
      
      public static const PRESET_USE_ERR_CRITERION:uint = 8;
      
      public static const PRESET_USE_ERR_UNKNOWN:uint = 9;
      
      public static const PRESET_USE_ERR_INVALID_DATA:uint = 10;
       
      
      public function PresetUseResultEnum()
      {
         super();
      }
   }
}
