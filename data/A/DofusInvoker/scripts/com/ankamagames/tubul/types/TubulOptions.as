package com.ankamagames.tubul.types
{
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class TubulOptions extends OptionManager
   {
       
      
      public function TubulOptions()
      {
         super("tubul");
         add("allowSoundEffects",true);
         add("tubulIsDesactivated",false);
         add("muteMusic",false);
         add("muteSound",false);
         add("muteAmbientSound",false);
         add("globalVolume",1);
         add("volumeMusic",0.6);
         add("volumeSound",0.6);
         add("volumeAmbientSound",0.6);
         add("playSoundForGuildMessage",true);
         add("playSoundAtTurnStart",true);
      }
   }
}
