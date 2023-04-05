package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkZaapManager
   {
       
      
      public function HyperlinkZaapManager()
      {
         super();
      }
      
      public static function saveCurrentZaap() : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.SaveCurrentZaap);
      }
   }
}
