package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   
   public class HyperlinkBakManager
   {
       
      
      public function HyperlinkBakManager()
      {
         super();
      }
      
      public static function openWeb(tab:String, ... args) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService,tab,args);
      }
   }
}
