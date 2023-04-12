package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.messages.Message;
   import flash.events.TimerEvent;
   
   public class CartographyStats implements IHookStats, IUiStats
   {
      
      private static const MAP_MENU_EVENT_ID:uint = 728;
       
      
      private var _worldmapEventTimer:BenchmarkTimer;
      
      private var _worldmapStatsAction:StatsAction;
      
      public function CartographyStats(args:Array)
      {
         this._worldmapEventTimer = new BenchmarkTimer(2000,1,"CartographyStats._worldmapEventTimer");
         super();
         this._worldmapEventTimer.addEventListener(TimerEvent.TIMER,this.onHookTimer);
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         if(pArgs == null || pArgs.length == 0)
         {
            return;
         }
         if(pHook == HookList.DisplayWorldmap)
         {
            this.prepareWorldmapDisplayedStat(pArgs[0]);
         }
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
      }
      
      public function remove() : void
      {
         this._worldmapEventTimer.removeEventListener(TimerEvent.TIMER,this.onHookTimer);
      }
      
      private function prepareWorldmapDisplayedStat(worldmap:WorldMap) : void
      {
         this._worldmapStatsAction = new StatsAction(MAP_MENU_EVENT_ID);
         this._worldmapStatsAction.user = StatsAction.getUserId();
         this._worldmapStatsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._worldmapStatsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         this._worldmapStatsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         this._worldmapStatsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._worldmapStatsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         this._worldmapStatsAction.setParam("worldmap_id",worldmap.id);
         this._worldmapStatsAction.setParam("worldmap_name",worldmap.name);
         this._worldmapEventTimer.reset();
         this._worldmapEventTimer.start();
      }
      
      private function onHookTimer(t:TimerEvent = null) : void
      {
         this._worldmapEventTimer.reset();
         if(this._worldmapStatsAction)
         {
            this._worldmapStatsAction.send();
         }
      }
   }
}
