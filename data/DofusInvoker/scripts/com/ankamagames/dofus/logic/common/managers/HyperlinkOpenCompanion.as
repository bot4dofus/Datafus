package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkOpenCompanion
   {
       
      
      public function HyperlinkOpenCompanion()
      {
         super();
      }
      
      public static function open(companionId:int = -1) : void
      {
         var companion:Companion = null;
         if(companionId != -1)
         {
            companion = Companion.getCompanionById(companionId);
         }
         var param:Object = null;
         if(companion != null)
         {
            param = {};
            param.companion = companion;
         }
         KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"companionTab",param);
      }
   }
}
