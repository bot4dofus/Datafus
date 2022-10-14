package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkShowAllianceManager
   {
       
      
      public function HyperlinkShowAllianceManager()
      {
         super();
      }
      
      public static function getLink(pAlliance:*, pText:String = null, pLinkColor:String = null, pHoverColor:String = null) : String
      {
         var text:String = !!pText ? "::" + pText : "";
         var linkColor:String = !!pLinkColor ? ",linkColor:" + pLinkColor : "";
         var hoverColor:String = !!pHoverColor ? ",hoverColor:" + pHoverColor : "";
         return "{alliance," + pAlliance.allianceId + "," + pAlliance.allianceTag + linkColor + hoverColor + text + "}";
      }
      
      public static function showAlliance(... params) : void
      {
         var allianceId:int = params[0];
         if(allianceId > int.MAX_VALUE || allianceId < 0)
         {
            allianceId = 0;
         }
         var afrmsg:AllianceFactsRequestMessage = new AllianceFactsRequestMessage();
         afrmsg.initAllianceFactsRequestMessage(allianceId);
         ConnectionsHandler.getConnection().send(afrmsg);
      }
      
      public static function getAllianceName(allianceId:uint, allianceTag:String) : String
      {
         return "[" + allianceTag + "]";
      }
      
      public static function rollOver(pX:int, pY:int, allianceId:uint, allianceTag:String = null) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.shortcuts.openSocialAlliance"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
