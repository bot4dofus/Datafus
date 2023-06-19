package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.StatsHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class LogBookStats implements IUiStats, IHookStats
   {
       
      
      private var _logBookStatsAction:StatsAction;
      
      private var _journalBtnUsed:String = "";
      
      public function LogBookStats(args:Array)
      {
         super();
      }
      
      private function sendLogBookHistoryStatAction(tab:String, scrollUsed:Boolean, scrollValue:uint) : void
      {
         this._logBookStatsAction = new StatsAction(InternalStatisticTypeEnum.LOG_BOOK_HISTORY);
         this._logBookStatsAction.user = StatsAction.getUserId();
         this._logBookStatsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._logBookStatsAction.setParam("character_account_id",PlayerManager.getInstance().accountId);
         this._logBookStatsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         this._logBookStatsAction.setParam("guild_id",SocialFrame.getInstance().guild.groupId);
         this._logBookStatsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._logBookStatsAction.setParam("interface_name",tab);
         this._logBookStatsAction.setParam("ui_scroll",scrollUsed);
         this._logBookStatsAction.setParam("journal_last_item",scrollValue);
         this._logBookStatsAction.send();
      }
      
      private function sendJournalStats() : void
      {
         this._logBookStatsAction = new StatsAction(InternalStatisticTypeEnum.JOURNAL);
         this._logBookStatsAction.user = StatsAction.getUserId();
         this._logBookStatsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._logBookStatsAction.setParam("character_account_id",PlayerManager.getInstance().accountId);
         this._logBookStatsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         this._logBookStatsAction.setParam("guild_id",SocialFrame.getInstance().guild.groupId);
         this._logBookStatsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._logBookStatsAction.setParam("journal_action_type",this._journalBtnUsed);
         this._logBookStatsAction.send();
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
      }
      
      public function remove() : void
      {
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         var btn:ButtonContainer = null;
         var lbl:Label = null;
         if(pArgs == null || pArgs.length == 0)
         {
            return;
         }
         switch(pHook)
         {
            case StatsHookList.LogBookHistoryStats:
               this.sendLogBookHistoryStatAction(pArgs[0],pArgs[1],pArgs[2]);
               this.sendJournalStats();
               break;
            case BeriliaHookList.MouseClick:
               if(pArgs[0] is ButtonContainer)
               {
                  btn = pArgs[0] as ButtonContainer;
                  if(btn.id == "btn_chestLog" || btn.id == "btn_generalLog" || btn.id == "btn_edit" || btn.id == "btn_valid")
                  {
                     if(this._journalBtnUsed.indexOf(btn.id) == -1)
                     {
                        this._journalBtnUsed += this._journalBtnUsed != "" ? ", " + btn.id : btn.id;
                     }
                  }
               }
               else if(pArgs[0] is Label)
               {
                  lbl = pArgs[0] as Label;
                  if(lbl.name == "lbl_cancel")
                  {
                     if(this._journalBtnUsed.indexOf(lbl.name) == -1)
                     {
                        this._journalBtnUsed += this._journalBtnUsed != "" ? ", " + lbl.name : lbl.name;
                     }
                  }
               }
         }
      }
   }
}
