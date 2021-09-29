package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowOrnamentManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowOrnamentManager));
      
      private static var _ornList:Array = new Array();
      
      private static var _ornId:uint = 0;
       
      
      public function HyperlinkShowOrnamentManager()
      {
         super();
      }
      
      public static function showOrnament(ornId:uint) : void
      {
         var data:Object = new Object();
         data.id = _ornList[ornId].id;
         data.idIsTitle = false;
         data.forceOpen = true;
         KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"titleTab",data);
      }
      
      public static function addOrnament(ornId:uint) : String
      {
         var code:* = null;
         var orn:Ornament = Ornament.getOrnamentById(ornId);
         if(orn)
         {
            _ornList[_ornId] = orn;
            code = "{chatornament," + _ornId + "::[" + orn.name + "]}";
            ++_ornId;
            return code;
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, ornId:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.ornament"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
