package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class BakNavigationStats implements IUiStats, IHookStats
   {
       
      
      private var _actionsStack:Vector.<StatsAction>;
      
      public function BakNavigationStats(args:Array)
      {
         super();
         this._actionsStack = new Vector.<StatsAction>();
      }
      
      private function CreateNewBakNavigationStats(type:String, action:String, amount:* = null) : void
      {
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.BAK_NAVIGATION);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("event_id",InternalStatisticTypeEnum.BAK_NAVIGATION);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("date",new Date().getTime());
         _statsAction.setParam("type",type);
         _statsAction.setParam("action",action);
         _statsAction.setParam("amount",amount);
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
               if(pArgs[0] == "bakTab")
               {
                  StatisticsManager.getInstance().sendActions(this._actionsStack);
               }
               break;
            case ExternalGameHookList.BakTabStats:
               this.CreateNewBakNavigationStats(pArgs[0],pArgs[1],pArgs[2]);
         }
      }
   }
}
