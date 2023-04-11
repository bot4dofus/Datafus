package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowTitleManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowTitleManager));
      
      private static var _titleList:Array = new Array();
      
      private static var _titleId:uint = 0;
       
      
      public function HyperlinkShowTitleManager()
      {
         super();
      }
      
      public static function showTitle(titleId:uint) : void
      {
         var data:Object = new Object();
         data.id = _titleList[titleId].id;
         data.idIsTitle = true;
         data.forceOpen = true;
         KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"titleTab",data);
      }
      
      public static function addTitle(titleId:uint) : String
      {
         var code:* = null;
         var title:Title = Title.getTitleById(titleId);
         if(title)
         {
            _titleList[_titleId] = title;
            code = "{chattitle," + _titleId + "::[" + title.name + "]}";
            ++_titleId;
            return code;
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, titleId:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.title"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
