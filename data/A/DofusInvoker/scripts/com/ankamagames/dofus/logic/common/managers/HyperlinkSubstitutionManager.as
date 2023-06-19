package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkSubstitutionManager
   {
       
      
      public function HyperlinkSubstitutionManager()
      {
         super();
      }
      
      public static function substitute(messageType:String, accountId:int) : String
      {
         switch(messageType)
         {
            case "autoanswer":
               return I18n.getUiText("ui.chat.status.autoanswer");
            default:
               return "Error";
         }
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, ornId:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.chat.status.autoanswertooltip"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),true,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
