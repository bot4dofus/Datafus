package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.CodesAndGiftManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class OpenBoxStats implements IUiStats, IHookStats
   {
       
      
      private var _actionsStack:Vector.<StatsAction>;
      
      public function OpenBoxStats(args:Array)
      {
         super();
         this._actionsStack = new Vector.<StatsAction>();
      }
      
      private function CreateNewOpenBoxStats(kard_id:int, box_remaining:int, anim_skipped_time:int, animSkipped:Boolean) : void
      {
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.OPEN_BOX);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         _statsAction.setParam("kard_id",kard_id);
         _statsAction.setParam("box_opened",CodesAndGiftManager.getInstance().openedMB[kard_id]);
         _statsAction.setParam("box_remaining",box_remaining);
         if(animSkipped)
         {
            _statsAction.setParam("anim_skipped_time",anim_skipped_time);
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
               if(pArgs[0] == "mysteryBoxPopup")
               {
                  StatisticsManager.getInstance().sendActions(this._actionsStack);
               }
               break;
            case ExternalGameHookList.CodesAndGiftOpenBoxStats:
               this.CreateNewOpenBoxStats(pArgs[0],pArgs[1],pArgs[2],pArgs[3]);
         }
      }
   }
}
