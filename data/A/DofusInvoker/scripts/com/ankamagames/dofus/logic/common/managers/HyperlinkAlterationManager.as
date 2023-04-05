package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationSourceTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.AlterationFrame;
   import flash.geom.Rectangle;
   
   public class HyperlinkAlterationManager
   {
      
      private static const TOOLTIP_NAME:String = "standard";
      
      private static var lastIdOfAlterationDisplayed:Number = Number.MAX_VALUE;
       
      
      public function HyperlinkAlterationManager()
      {
         super();
      }
      
      public static function getLink(alteration:AlterationWrapper, linkName:String = null, linkColor:String = null, hoverColor:String = null) : String
      {
         linkColor = !!linkColor ? ",linkColor:" + linkColor : "";
         hoverColor = !!hoverColor ? ",hoverColor:" + hoverColor : "";
         linkName = !!linkName ? "::[".concat(linkName).concat("]") : "";
         return "{alteration,".concat(alteration.id).concat(",").concat(alteration.bddId).concat(",").concat(alteration.sourceType).concat(linkColor).concat(hoverColor).concat(linkName).concat("}");
      }
      
      public static function showPinnedTooltip(alterationId:Number = NaN, alterationBddId:uint = 4.294967295E9, alterationSourceType:uint = 0) : void
      {
         if(alterationId == lastIdOfAlterationDisplayed && TooltipManager.isVisible("Hyperlink"))
         {
            TooltipManager.hide("Hyperlink");
            lastIdOfAlterationDisplayed = -1;
            return;
         }
         lastIdOfAlterationDisplayed = alterationId;
         showAlterationTooltip(alterationId,alterationBddId,alterationSourceType,true);
      }
      
      public static function getText(alterationId:Number = NaN, alterationBddId:uint = 4.294967295E9, alterationSourceType:uint = 0) : String
      {
         var alteration:AlterationWrapper = getAlterationFromParameters(alterationId,alterationBddId,alterationSourceType);
         if(alteration === null)
         {
            return "[???]";
         }
         return "[".concat(unescape(alteration.name)).concat("]");
      }
      
      public static function rollOver(xPos:int, yPos:int, alterationId:Number = NaN, alterationBddId:uint = 4.294967295E9, alterationSourceType:uint = 0) : void
      {
         showAlterationTooltip(alterationId,alterationBddId,alterationSourceType,false,xPos,yPos);
      }
      
      private static function showAlterationTooltip(alterationId:Number = NaN, alterationBddId:uint = 4.294967295E9, alterationSourceType:uint = 0, isPinned:Boolean = false, xPos:int = 420, yPos:int = 220) : void
      {
         TooltipManager.hide(TOOLTIP_NAME);
         var alteration:AlterationWrapper = getAlterationFromParameters(alterationId,alterationBddId,alterationSourceType);
         if(alteration === null)
         {
            return;
         }
         var target:Rectangle = new Rectangle(xPos,yPos,10,10);
         var makerParams:Object = null;
         if(isPinned)
         {
            makerParams = {"pinnable":true};
         }
         TooltipManager.show(alteration,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,TOOLTIP_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,"alteration",null,makerParams,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
      
      private static function getAlterationFromParameters(alterationId:Number = NaN, alterationBddId:uint = 4.294967295E9, alterationSourceType:uint = 0) : AlterationWrapper
      {
         var alterationData:Alteration = null;
         var item:ItemWrapper = null;
         if(isNaN(alterationId))
         {
            return null;
         }
         var alterationFrame:AlterationFrame = Kernel.getWorker().getFrame(AlterationFrame) as AlterationFrame;
         var alteration:AlterationWrapper = null;
         if(alterationFrame !== null)
         {
            alteration = alterationFrame.getAlteration(alterationId);
         }
         if(alteration !== null)
         {
            return alteration;
         }
         if(alterationSourceType === AlterationSourceTypeEnum.ALTERATION)
         {
            alterationData = Alteration.getAlterationById(alterationBddId);
            if(alterationData !== null)
            {
               alteration = AlterationWrapper.create(alterationData,TimeManager.getInstance().getUtcTimestamp());
            }
         }
         else if(alterationSourceType === AlterationSourceTypeEnum.ITEM)
         {
            item = ItemWrapper.create(0,0,alterationBddId,0,null,true);
            if(item !== null)
            {
               alteration = AlterationWrapper.createFromItem(item);
            }
         }
         return alteration;
      }
   }
}
