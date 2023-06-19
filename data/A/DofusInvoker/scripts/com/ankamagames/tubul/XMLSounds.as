package com.ankamagames.tubul
{
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.types.Uri;
   
   public class XMLSounds
   {
      
      private static const BREED_BONES_FILENAME:String = "2100000000.xml";
      
      public static const ROLLOFF_FILENAME:String = "presetsRollOff";
      
      public static const BREED_BONES_BARKS:Uri = new Uri(LangManager.getInstance().getEntry("config.audio.barks") + BREED_BONES_FILENAME);
      
      public static const ROLLOFF_PRESET:Uri = new Uri(LangManager.getInstance().getEntry("config.audio.presets") + ROLLOFF_FILENAME + ".xml");
       
      
      public function XMLSounds()
      {
         super();
      }
   }
}
