package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class SmithMagicAdvancedStats implements IUiStats, IHookStats
   {
       
      
      private var _actionsStack:Vector.<StatsAction>;
      
      public function SmithMagicAdvancedStats(args:Array)
      {
         super();
         this._actionsStack = new Vector.<StatsAction>();
      }
      
      private function CreateNewSmithMagicAdvancedStats(optionActivated:Boolean) : void
      {
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.SMITH_MAGIC);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         _statsAction.setParam("coche_option_avancee",optionActivated);
         this._actionsStack.push(_statsAction);
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
      }
      
      public function remove() : void
      {
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         if(pArgs == null || pArgs.length == 0)
         {
            return;
         }
         switch(pHook)
         {
            case BeriliaHookList.MouseClick:
               if(pArgs[0].name != "chk_advancedMode")
               {
                  return;
               }
               this.CreateNewSmithMagicAdvancedStats(!pArgs[0].selected);
               break;
            case BeriliaHookList.UiUnloaded:
               if(pArgs[0] == "smithMagic" || pArgs[0] == "smithMagicCoop")
               {
                  StatisticsManager.getInstance().sendActions(this._actionsStack);
               }
         }
      }
   }
}
