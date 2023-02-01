package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowMonsterChatManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowMonsterChatManager));
      
      private static var _monsterList:Array = new Array();
      
      private static var _monsterId:uint = 0;
       
      
      public function HyperlinkShowMonsterChatManager()
      {
         super();
      }
      
      public static function showMonster(monsterId:uint) : void
      {
         var data:Object = new Object();
         data.monsterId = monsterId;
         data.forceOpen = true;
         TooltipManager.hideAll();
         KernelEventsManager.getInstance().processCallback(HookList.OpenEncyclopedia,"bestiaryTab",data);
      }
      
      public static function addMonster(monsterId:uint) : String
      {
         var code:* = null;
         var monster:Monster = Monster.getMonsterById(monsterId);
         if(monster)
         {
            _monsterList[_monsterId] = monster;
            code = "{chatmonster," + monsterId + "::[" + monster.name + "]}";
            ++_monsterId;
            return code;
         }
         return "[null]";
      }
      
      public static function getMonsterName(monsterId:uint) : String
      {
         var monster:Monster = Monster.getMonsterById(monsterId);
         if(monster)
         {
            return "[" + monster.name + "]";
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, monsterId:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.monster"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
