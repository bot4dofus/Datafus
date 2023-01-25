package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkZaapPosition
   {
      
      public static const LEFT_SEPARATOR:String = "[";
      
      public static const RIGHT_SEPARATOR:String = "]";
      
      public static const COORDINATES_SEPARATOR:String = ",";
       
      
      public function HyperlinkZaapPosition()
      {
         super();
      }
      
      public static function getLink(subareaId:int, pText:String = null) : String
      {
         var text:String = !!pText ? "::" + pText : "";
         return "{zaap," + subareaId + text + "}";
      }
      
      public static function showPosition(subareaId:int) : void
      {
         var subarea:SubArea = SubArea.getSubAreaById(subareaId);
         var posX:int = subarea.zaapMapPosition.posX;
         var posY:int = subarea.zaapMapPosition.posY;
         var elementName:String = subarea.name;
         var worldMapId:int = subarea.worldmap.id;
         KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_chat_" + posX + "_" + posY + "_" + elementName,(elementName != "" ? unescape(elementName) : I18n.getUiText("ui.cartography.chatFlag") + " ") + "(" + posX + "," + posY + ")",worldMapId,posX,posY,16737792,true);
      }
      
      public static function getText(subareaId:int) : String
      {
         var subarea:SubArea = SubArea.getSubAreaById(subareaId);
         var posX:int = subarea.zaapMapPosition.posX;
         var posY:int = subarea.zaapMapPosition.posY;
         var elementName:String = subarea.name;
         return unescape(elementName) + " " + LEFT_SEPARATOR + posX + COORDINATES_SEPARATOR + posY + RIGHT_SEPARATOR;
      }
      
      public static function rollOver(pX:int, pY:int, subareaId:int) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
