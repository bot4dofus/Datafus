package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.Dictionary;
   
   public class SuggestionsStats implements IUiStats, IHookStats
   {
       
      
      private var _actionsStack:Vector.<StatsAction>;
      
      public function SuggestionsStats(args:Array)
      {
         super();
         this._actionsStack = new Vector.<StatsAction>();
      }
      
      private function CreateNewSuggestionsStats(params:Dictionary) : void
      {
         var statsAction:StatsAction = null;
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.SUGGESTIONS);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         _statsAction.setParam("card_id",params["cardId"]);
         _statsAction.setParam("category_name",params["categoryName"]);
         _statsAction.setParam("card_action",params["cardAction"]);
         _statsAction.setParam("activity_type",params["activityType"]);
         _statsAction.setParam("filter_zone",params["filterZone"]);
         _statsAction.setParam("filter_level_min",params["filterLevelMin"]);
         _statsAction.setParam("filter_level_max",params["filterLevelMax"]);
         _statsAction.setParam("refreshed_used",params["referehedUsed"]);
         _statsAction.setParam("print_source",params["printSource"]);
         var duplicata:StatsAction = null;
         for each(statsAction in this._actionsStack)
         {
            if(statsAction.params["card_id"] == _statsAction.params["card_id"])
            {
               duplicata = statsAction;
            }
         }
         if(duplicata != null)
         {
            this._actionsStack.removeAt(this._actionsStack.indexOf(duplicata));
         }
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
            case BeriliaHookList.UiUnloaded:
               if(pArgs[0] == "guidebook")
               {
                  StatisticsManager.getInstance().sendActions(this._actionsStack);
               }
               break;
            case HookList.SuggestionsStats:
               this.CreateNewSuggestionsStats(pArgs[0]);
         }
      }
   }
}
