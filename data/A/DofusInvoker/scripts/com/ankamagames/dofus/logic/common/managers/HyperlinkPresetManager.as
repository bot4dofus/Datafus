package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkPresetManager
   {
       
      
      public function HyperlinkPresetManager()
      {
         super();
      }
      
      public static function openPresets(buildId:uint) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.OpenCharacterBuilds,buildId);
      }
   }
}
