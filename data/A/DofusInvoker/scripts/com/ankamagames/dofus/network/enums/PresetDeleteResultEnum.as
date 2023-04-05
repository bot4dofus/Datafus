package com.ankamagames.dofus.network.enums
{
   public class PresetDeleteResultEnum
   {
      
      public static const PRESET_DEL_OK:uint = 1;
      
      public static const PRESET_DEL_ERR_UNKNOWN:uint = 2;
      
      public static const PRESET_DEL_ERR_BAD_PRESET_ID:uint = 3;
      
      public static const PRESET_DEL_ERR_SYSTEM_INACTIVE:uint = 4;
       
      
      public function PresetDeleteResultEnum()
      {
         super();
      }
   }
}
