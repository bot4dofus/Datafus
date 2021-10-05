package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.StatsHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class GameGuideStats implements IUiStats, IHookStats
   {
      
      private static const EVENT_ID:uint = 726;
       
      
      public function GameGuideStats(args:Array)
      {
         super();
      }
      
      private function CreateNewGameGuideStats(articleId:uint, accessType:String) : void
      {
         var _statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.GAME_GUIDE);
         _statsAction.user = StatsAction.getUserId();
         _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         _statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         _statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         _statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         _statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         _statsAction.setParam("article_id",articleId);
         _statsAction.setParam("article_access_type",accessType);
         _statsAction.send();
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
         if(pHook == StatsHookList.GameGuideArticleSelectionType)
         {
            this.CreateNewGameGuideStats(pArgs[0],pArgs[1]);
         }
      }
   }
}
