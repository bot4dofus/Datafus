package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.progression.FeatureDescription;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.StatsHookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkGuidebookManager
   {
      
      public static const LEFT_SEPARATOR:String = "[";
      
      public static const RIGHT_SEPARATOR:String = "]";
       
      
      public function HyperlinkGuidebookManager()
      {
         super();
      }
      
      public static function openFeatureDescription(featureId:uint) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.OpenGuidebook,"gameGuide",[featureId]);
         KernelEventsManager.getInstance().processCallback(StatsHookList.GameGuideArticleSelectionType,featureId,"chatLink");
      }
      
      public static function getText(featureId:uint) : String
      {
         var feature:FeatureDescription = FeatureDescription.getFeatureDescriptionById(featureId);
         if(feature)
         {
            return LEFT_SEPARATOR + unescape(feature.name) + RIGHT_SEPARATOR;
         }
         return ";";
      }
      
      public static function rollOver(pX:int, pY:int, featureId:uint) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.guidebook.openInGameGuide"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP);
      }
      
      public static function moveToFeatureDescription(featureId:uint) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.MoveToFeatureDescription,[featureId]);
         KernelEventsManager.getInstance().processCallback(StatsHookList.GameGuideArticleSelectionType,featureId,"guideLink");
      }
      
      public static function itemRollOver(pX:int, pY:int, objectGID:uint, objectUID:uint = 0) : void
      {
         var item:ItemWrapper = ItemWrapper.create(0,0,objectGID,1,null);
         if(item != null)
         {
            TooltipManager.show(item,new Rectangle(pX,pY,10,10),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,true,null,null,{
               "header":true,
               "description":true,
               "equipped":false,
               "noFooter":true,
               "showEffects":true
            },null,false,StrataEnum.STRATA_TOOLTIP);
         }
      }
   }
}
