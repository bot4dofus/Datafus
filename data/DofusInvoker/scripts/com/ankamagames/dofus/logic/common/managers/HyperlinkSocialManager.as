package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkSocialManager
   {
       
      
      public function HyperlinkSocialManager()
      {
         super();
      }
      
      public static function openSocial(tab:int, subTab:int, ... args) : void
      {
         KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,tab,subTab,args);
      }
      
      public static function getLink(tab:int, subTab:int, args:Array, pText:String) : String
      {
         var text:String = !!pText ? "::" + pText : "";
         var params:String = args.join(",");
         if(params != "")
         {
            params = "," + params;
         }
         return "{openSocial," + tab + "," + subTab + params + text + "}";
      }
      
      public static function rollOver(pX:int, pY:int, tab:int, subTab:int, ... args) : void
      {
         var target:Rectangle = null;
         var info:TextTooltipInfo = null;
         if(tab == 1 && subTab == 2)
         {
            target = new Rectangle(pX,pY,10,10);
            info = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.taxCollectorUnderAttack"));
            TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
         }
      }
   }
}
