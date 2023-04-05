package com.ankamagames.berilia.types
{
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class BeriliaOptions extends OptionManager
   {
       
      
      public function BeriliaOptions()
      {
         super("berilia");
         add("uiShadows",true);
         add("uiAnimations",true);
      }
   }
}
