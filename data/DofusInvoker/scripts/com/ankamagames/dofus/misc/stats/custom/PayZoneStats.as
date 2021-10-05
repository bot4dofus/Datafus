package com.ankamagames.dofus.misc.stats.custom
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.IStatsClass;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class PayZoneStats implements IHookStats, IStatsClass
   {
       
      
      public function PayZoneStats(pArgs:Array)
      {
         super();
         var action:StatsAction = new StatsAction(InternalStatisticTypeEnum.PAY_ZONE);
         action.user = StatsAction.getUserId();
         action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         action.setParam("account_id",PlayerManager.getInstance().accountId);
         action.setParam("server_id",PlayerManager.getInstance().server.id);
         action.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         action.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         action.setParam("map_id",PlayedCharacterManager.getInstance().currentMap.mapId);
         action.setParam("type","ARRIVE");
         action.send();
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
      }
      
      public function remove() : void
      {
      }
   }
}
