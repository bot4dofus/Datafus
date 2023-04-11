package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class ChinqStats implements IUiStats, IHookStats
   {
       
      
      private var _chinqStatsAction:StatsAction;
      
      public function ChinqStats(args:Array)
      {
         super();
         this._chinqStatsAction = new StatsAction(InternalStatisticTypeEnum.CHINQ);
      }
      
      private function prepareChinqDataStat(data:Object) : void
      {
         this._chinqStatsAction.user = StatsAction.getUserId();
         this._chinqStatsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._chinqStatsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         this._chinqStatsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         this._chinqStatsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._chinqStatsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         this._chinqStatsAction.setParam("button_random_utilisation",data.buttonsUtilisation["btn_randomCards"]);
         this._chinqStatsAction.setParam("button_previous_receptie_utilisation",data.buttonsUtilisation["btn_sameCards"]);
         this._chinqStatsAction.setParam("button_discard_cards_utilisation",data.buttonsUtilisation["btn_clearCards"]);
         this._chinqStatsAction.setParam("button_screen_shot_utilisation",data.buttonsUtilisation["btn_saveResult"]);
         this._chinqStatsAction.setParam("button_copy_receptie_utilisation",data.buttonsUtilisation["btn_copyResult"]);
         this._chinqStatsAction.setParam("button_play_utilisation",data.buttonsUtilisation["btn_play"]);
         this._chinqStatsAction.setParam("nb_cards_inputed_by_random",data.nbCardsInputedByRandom);
         this._chinqStatsAction.setParam("nb_cards_inputed_by_previous_receptie",data.nbCardsInputedByPrevious);
         this._chinqStatsAction.setParam("nb_cards_inputed_by_hand",data.nbCardsInputedByHand);
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
            case HookList.ChinqStats:
               this.prepareChinqDataStat(pArgs[0]);
               break;
            case BeriliaHookList.UiUnloaded:
               if(pArgs[0] == UIEnum.CHINQ_UI)
               {
                  this._chinqStatsAction.send();
               }
         }
      }
   }
}
