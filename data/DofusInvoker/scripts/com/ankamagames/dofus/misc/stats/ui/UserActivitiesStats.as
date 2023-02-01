package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class UserActivitiesStats implements IUiStats, IHookStats
   {
       
      
      public function UserActivitiesStats(args:Array)
      {
         super();
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
         if(pHook == ChatServiceHookList.ChatServiceUserUpdateHisActivity)
         {
            this.CreateAndSendNewStat(pArgs[0]);
         }
      }
      
      private function CreateAndSendNewStat(activity_type:uint) : void
      {
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.USER_ACTIVITIES);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         _statsAction.setParam("activity_type",activity_type);
         StatisticsManager.getInstance().sendAction(_statsAction);
      }
   }
}
