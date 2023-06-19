package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkShowQuestManager
   {
      
      private static var _questList:Array = new Array();
      
      private static var _questId:uint = 0;
       
      
      public function HyperlinkShowQuestManager()
      {
         super();
      }
      
      public static function showQuest(questId:uint) : void
      {
         var data:Object = null;
         var quest:Quest = Quest.getQuestById(_questList[questId].id);
         if(quest)
         {
            data = new Object();
            data.quest = quest;
            data.forceOpen = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"questTab",data);
         }
      }
      
      public static function addQuest(questId:uint) : String
      {
         var code:* = null;
         var quest:Quest = Quest.getQuestById(questId);
         if(quest)
         {
            _questList[_questId] = quest;
            code = "{chatquest," + _questId + "::[" + quest.name + "]}";
            ++_questId;
            return code;
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, questId:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.quest"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
