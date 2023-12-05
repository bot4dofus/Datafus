package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuideBookAction;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   
   public class HyperlinkOpenPvpArena
   {
       
      
      public function HyperlinkOpenPvpArena()
      {
         super();
      }
      
      public static function getLink(text:String) : String
      {
         return "{openArena::" + text + "}";
      }
      
      public static function getOpenRewardsLink(text:String) : String
      {
         return "{openArenaRewards::" + text + "}";
      }
      
      public static function open() : void
      {
         var ui:UiRootContainer = Berilia.getInstance().getUi(UIEnum.PVP_ARENA);
         if(ui)
         {
            Berilia.getInstance().setUiStrata(ui.name,StrataEnum.STRATA_TOP);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
         }
      }
      
      public static function openArenaRewardTab() : void
      {
         Kernel.getWorker().process(OpenGuideBookAction.create("kolizeumTab"));
      }
   }
}
