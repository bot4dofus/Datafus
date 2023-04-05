package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   
   public class HyperlinkOptionManager
   {
       
      
      public function HyperlinkOptionManager()
      {
         super();
      }
      
      public static function openOption(tab:String) : void
      {
         var mod:UiModule = null;
         if(tab)
         {
            mod = UiModuleManager.getInstance().getModule("Ankama_Common");
            mod.mainClass.openOptionMenu(false,tab);
         }
      }
   }
}
