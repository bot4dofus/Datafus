package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkOpenBook
   {
       
      
      public function HyperlinkOpenBook()
      {
         super();
      }
      
      public static function open(tab:String, subTab:String = null, strata:int = 1, forceOpen:String = "false") : void
      {
         var ui:UiRootContainer = Berilia.getInstance().getUi(tab);
         if(ui && forceOpen == "true")
         {
            Berilia.getInstance().setUiStrata(ui.name,strata);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.OpenBook,tab,!!subTab ? [subTab,null] : null,false,strata);
         }
      }
   }
}
