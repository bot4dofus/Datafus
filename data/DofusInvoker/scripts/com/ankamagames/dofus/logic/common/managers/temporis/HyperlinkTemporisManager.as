package com.ankamagames.dofus.logic.common.managers.temporis
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuidebookAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkTemporisManager
   {
      
      private static const ACHIEVEMENT_CAT_ID_TO_OPEN:uint = 112;
       
      
      public function HyperlinkTemporisManager()
      {
         super();
      }
      
      public static function openTemporisSuccesses() : void
      {
         Kernel.getWorker().process(OpenBookAction.create("achievementTab",{"achievementCategoryId":ACHIEVEMENT_CAT_ID_TO_OPEN}));
      }
      
      public static function openTemporisTab() : void
      {
         Kernel.getWorker().process(OpenGuidebookAction.create("temporisTab"));
      }
      
      public static function locatePorisAssistant() : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.LocatePorisAssistant);
      }
   }
}
