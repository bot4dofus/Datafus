package com.ankamagames.dofus.kernel.sound
{
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.types.Uri;
   
   public class TubulSoundConfiguration
   {
      
      public static const TIME_FADE_IN_MUSIC:Number = 2;
      
      public static const TIME_FADE_OUT_MUSIC:Number = 5;
      
      public static const TIME_FADE_IN_AMBIANCE:Number = 2;
      
      public static const TIME_FADE_OUT_AMBIANCE:Number = 2;
      
      public static const MUSIC_LOOPS:Number = 4;
      
      public static const TIME_FADE_IN_INTRO:Number = 3;
      
      public static const TIME_FADE_OUT_INTRO:Number = 1.5;
      
      public static const TIME_FADE_SWITCH_INTRO:Number = 3;
      
      public static const BUS_MUSIC_ID:uint = 0;
      
      public static const BUS_AMBIENT_2D_ID:uint = 1;
      
      public static const BUS_AMBIENT_3D_ID:uint = 2;
      
      public static const BUS_SFX_ID:uint = 3;
      
      public static const BUS_UI_ID:uint = 4;
      
      public static const BUS_NPC_FOLEYS_ID:uint = 5;
      
      public static const BUS_FIGHT_ID:uint = 6;
      
      public static const BUS_BARKS_ID:uint = 7;
      
      public static const BUS_GFX_ID:uint = 8;
      
      public static const BUS_FIGHT_MUSIC_ID:uint = 9;
      
      public static const BUS_MUSIC_VOLUME:Number = 0.8;
      
      public static const BUS_AMBIENT_2D_VOLUME:Number = 0.7;
      
      public static const BUS_AMBIENT_3D_VOLUME:Number = 0.7;
      
      public static const BUS_SFX_VOLUME:Number = 0.5;
      
      public static const BUS_UI_VOLUME:Number = 0.7;
      
      public static const BUS_NPC_FOLEYS_VOLUME:Number = 0.7;
      
      public static const BUS_FIGHT_VOLUME:Number = 0.77;
      
      public static const BUS_BARKS_VOLUME:Number = 0.77;
      
      public static const BUS_GFX_VOLUME:Number = 0.77;
      
      public static const BUS_FIGHT_MUSIC_VOLUME:Number = 0.8;
      
      public static const CHANNEL_MUSIC:String = "MUSIC";
      
      public static const CHANNEL_AMBIENT_2D:String = "AMBIANCE";
      
      public static const CHANNEL_UI:String = "USER INTERFACE";
      
      public static const CHANNEL_SFX:String = "SFX";
      
      public static const CHANNEL_FIGHT:String = "FIGHT";
      
      public static const CHANNEL_BARKS:String = "BARKS";
      
      public static const CHANNEL_AMBIENT_3D:String = "LOCALIZED SOUNDS";
      
      public static const CHANNEL_NPC_FOLEYS:String = "NPC FOLEYS";
      
      public static const CHANNEL_GFX:String = "GFX";
      
      public static const CHANNEL_FIGHT_MUSIC:String = "FIGHT MUSIC";
      
      public static const ID_SOUND_MUSIC:String = "20";
      
      public static const ID_SOUND_AMBIANT_2D:String = "17";
      
      public static const ID_SOUND_AMBIANT_3D:String = "18";
      
      public static const ID_SOUND_SFX:String = "15";
      
      public static const ID_SOUND_INTERFACE:String = "16";
      
      public static const ID_SOUND_NPC_FOLEYS:String = "31";
      
      public static const ID_SOUND_BONE_1_FOLEYS:String = "11";
      
      public static const ID_SOUND_FIGHT_CHARA_SPELL:String = "10";
      
      public static const ID_SOUND_FIGHT_MONSTER_SPELL:String = "30";
      
      public static const ID_SOUND_FIGHT_SPELL_EFFECT:String = "40";
      
      public static const ID_SOUND_FIGHT_SPELL_IMPACT:String = "50";
      
      public static const ID_SOUND_BARKS_MONSTER:String = "14";
      
      public static const ID_SOUND_BARKS_CHARACTER:String = "21";
      
      public static const ID_SOUND_FIGHT_MUSIC:String = "29";
      
      private static const ROLLOFF_FILENAME:String = "presetsRollOff";
      
      public static const ROLLOFF_PRESET:Uri = new Uri(LangManager.getInstance().getEntry("config.audio.presets") + ROLLOFF_FILENAME + ".xml");
      
      public static const fightMusicIds:Array = new Array("29001","29002","29003","29004","29005");
       
      
      public function TubulSoundConfiguration()
      {
         super();
      }
   }
}
