package com.ankamagames.dofus.kernel.sound.utils
{
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.jerakine.managers.LangManager;
   
   public class SoundUtil
   {
       
      
      public function SoundUtil()
      {
         super();
      }
      
      public static function getBusIdBySoundId(pSoundId:String) : uint
      {
         var soundIdBeginning:String = pSoundId.slice(0,2);
         switch(soundIdBeginning)
         {
            case TubulSoundConfiguration.ID_SOUND_MUSIC:
               return TubulSoundConfiguration.BUS_MUSIC_ID;
            case TubulSoundConfiguration.ID_SOUND_AMBIANT_2D:
               return TubulSoundConfiguration.BUS_AMBIENT_2D_ID;
            case TubulSoundConfiguration.ID_SOUND_AMBIANT_3D:
               return TubulSoundConfiguration.BUS_AMBIENT_3D_ID;
            case TubulSoundConfiguration.ID_SOUND_SFX:
               return TubulSoundConfiguration.BUS_SFX_ID;
            case TubulSoundConfiguration.ID_SOUND_INTERFACE:
               return TubulSoundConfiguration.BUS_UI_ID;
            case TubulSoundConfiguration.ID_SOUND_NPC_FOLEYS:
            case TubulSoundConfiguration.ID_SOUND_BONE_1_FOLEYS:
               return TubulSoundConfiguration.BUS_NPC_FOLEYS_ID;
            case TubulSoundConfiguration.ID_SOUND_FIGHT_CHARA_SPELL:
            case TubulSoundConfiguration.ID_SOUND_FIGHT_MONSTER_SPELL:
            case TubulSoundConfiguration.ID_SOUND_FIGHT_SPELL_IMPACT:
               return TubulSoundConfiguration.BUS_FIGHT_ID;
            case TubulSoundConfiguration.ID_SOUND_BARKS_CHARACTER:
            case TubulSoundConfiguration.ID_SOUND_BARKS_MONSTER:
               return TubulSoundConfiguration.BUS_BARKS_ID;
            case TubulSoundConfiguration.ID_SOUND_FIGHT_SPELL_EFFECT:
               return TubulSoundConfiguration.BUS_GFX_ID;
            case TubulSoundConfiguration.ID_SOUND_FIGHT_MUSIC:
               return TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID;
            default:
               return TubulSoundConfiguration.BUS_UI_ID;
         }
      }
      
      public static function getConfigEntryByBusId(pBusId:uint) : String
      {
         switch(pBusId)
         {
            case TubulSoundConfiguration.BUS_MUSIC_ID:
            case TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID:
               return LangManager.getInstance().getEntry("config.audio.music");
            case TubulSoundConfiguration.BUS_AMBIENT_2D_ID:
               return LangManager.getInstance().getEntry("config.audio.ambient");
            case TubulSoundConfiguration.BUS_AMBIENT_3D_ID:
               return LangManager.getInstance().getEntry("config.audio.local");
            case TubulSoundConfiguration.BUS_SFX_ID:
               return LangManager.getInstance().getEntry("config.audio.sfx");
            case TubulSoundConfiguration.BUS_UI_ID:
               return LangManager.getInstance().getEntry("config.audio.ui");
            case TubulSoundConfiguration.BUS_NPC_FOLEYS_ID:
               return LangManager.getInstance().getEntry("config.audio.foleys");
            case TubulSoundConfiguration.BUS_FIGHT_ID:
               return LangManager.getInstance().getEntry("config.audio.fight");
            case TubulSoundConfiguration.BUS_BARKS_ID:
               return LangManager.getInstance().getEntry("config.audio.barks");
            case TubulSoundConfiguration.BUS_GFX_ID:
               return LangManager.getInstance().getEntry("config.audio.gfx");
            default:
               throw new Error("The Bus Id seems not matching to any sound folder");
         }
      }
   }
}
