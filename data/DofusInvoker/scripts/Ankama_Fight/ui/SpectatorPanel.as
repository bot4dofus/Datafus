package Ankama_Fight.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import damageCalculation.tools.StatIds;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class SpectatorPanel
   {
      
      private static const ATTACKER_ID:int = 0;
      
      private static const DEFENDER_ID:int = 1;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lbl_attackersName:Label;
      
      public var lbl_defendersName:Label;
      
      public var lbl_time:Label;
      
      public var lbl_attackersLife:Label;
      
      public var lbl_defendersLife:Label;
      
      private var LIFEPOINTS_STR:String;
      
      private var _fightStartTime:Number;
      
      private var _ticker:BenchmarkTimer;
      
      private var _attackersName:String;
      
      private var _defendersName:String;
      
      private var _lifePoints:Array;
      
      private var _attackersLifeById:Dictionary;
      
      private var _defendersLifeById:Dictionary;
      
      private var _currentFighterId:Number;
      
      public var pb_defenders:ProgressBar;
      
      public function SpectatorPanel()
      {
         this._lifePoints = [];
         this._attackersLifeById = new Dictionary();
         this._defendersLifeById = new Dictionary();
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(HookList.FightersListUpdated,this.onGameFightTurnListUpdated);
         this.sysApi.addHook(FightHookList.UpdatePreFightersList,this.onUpdatePreFightersList);
         this.sysApi.addHook(FightHookList.SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(HookList.GameFightTurnStart,this.onTurnStart);
         this.sysApi.addHook(HookList.FighterLookChange,this.onFighterLookChange);
         this.sysApi.addHook(HookList.FightEvent,this.onFightEvent);
         var statsManager:StatsManager = StatsManager.getInstance();
         statsManager.addListenerToStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.SHIELD,this.onUpdateHealthPoints);
         this.LIFEPOINTS_STR = this.uiApi.getText("ui.short.lifePoints");
         this._fightStartTime = params[0];
         this._attackersName = params[1];
         this._defendersName = params[2];
         if(this._fightStartTime > 0)
         {
            this.startClock();
         }
         else
         {
            this.lbl_time.text = "-";
         }
         if(this._attackersName != "")
         {
            this.lbl_attackersName.text = this._attackersName;
         }
         else
         {
            this.lbl_attackersName.text = this.uiApi.getText("ui.common.attackers");
         }
         if(this._defendersName != "")
         {
            this.lbl_defendersName.text = this._defendersName;
         }
         else
         {
            this.lbl_defendersName.text = this.uiApi.getText("ui.common.defenders");
         }
         this.entityDisplayer.view = "timeline";
         this.onGameFightTurnListUpdated();
      }
      
      public function unload() : void
      {
         if(this._ticker)
         {
            this._ticker.removeEventListener(TimerEvent.TIMER,this.updateClock);
            this._ticker.stop();
         }
         var statsManager:StatsManager = StatsManager.getInstance();
         statsManager.removeListenerFromStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.SHIELD,this.onUpdateHealthPoints);
      }
      
      private function startClock() : void
      {
         if(this._ticker == null)
         {
            this.updateClock(null);
            this._ticker = new BenchmarkTimer(1000,0,"SpectatorPanel._ticker");
            this._ticker.addEventListener(TimerEvent.TIMER,this.updateClock);
            this._ticker.start();
         }
      }
      
      private function updateClock(te:TimerEvent) : void
      {
         if(!this.lbl_time || !this.timeApi)
         {
            return;
         }
         var duration:Number = new Date().getTime() - this._fightStartTime * 1000;
         this.lbl_time.text = "" + this.timeApi.getShortDuration(duration,true);
      }
      
      private function updateLifeOfOneFighter(fighterId:Number) : void
      {
         var infos:FighterInformations = this.fightApi.getFighterInformations(fighterId);
         var stats:EntityStats = StatsManager.getInstance().getStats(fighterId);
         if(infos && stats && (!infos.summoned || infos.fighterId > -1))
         {
            if(infos.team == "challenger")
            {
               this._attackersLifeById[fighterId] = stats.getHealthPoints() + stats.getStatTotalValue(StatIds.SHIELD);
            }
            else if(infos.team == "defender")
            {
               this._defendersLifeById[fighterId] = stats.getHealthPoints() + stats.getStatTotalValue(StatIds.SHIELD);
            }
            else if(this._attackersLifeById[fighterId])
            {
               this._attackersLifeById[fighterId] = 0;
            }
            else if(this._defendersLifeById[fighterId])
            {
               this._defendersLifeById[fighterId] = 0;
            }
            this.updateLifeBalance();
         }
      }
      
      private function updateLifeBalance() : void
      {
         var lp:int = 0;
         this._lifePoints[ATTACKER_ID] = 0;
         for each(lp in this._attackersLifeById)
         {
            this._lifePoints[ATTACKER_ID] += lp;
         }
         this._lifePoints[DEFENDER_ID] = 0;
         for each(lp in this._defendersLifeById)
         {
            this._lifePoints[DEFENDER_ID] += lp;
         }
         this.lbl_attackersLife.text = this._lifePoints[ATTACKER_ID] + " " + this.LIFEPOINTS_STR;
         this.lbl_defendersLife.text = this._lifePoints[DEFENDER_ID] + " " + this.LIFEPOINTS_STR;
         this.pb_defenders.value = 1 - this._lifePoints[ATTACKER_ID] / (this._lifePoints[DEFENDER_ID] + this._lifePoints[ATTACKER_ID]);
      }
      
      private function onGameFightTurnListUpdated() : void
      {
         var id:Number = NaN;
         var infos:FighterInformations = null;
         var stats:EntityStats = null;
         var fightersId:Vector.<Number> = this.fightApi.getFighters();
         if(!fightersId)
         {
            return;
         }
         for(var pos:int = fightersId.length - 1; pos >= 0; pos--)
         {
            id = fightersId[pos];
            infos = this.fightApi.getFighterInformations(id);
            stats = StatsManager.getInstance().getStats(id);
            if(infos && (!infos.summoned || infos.fighterId > -1))
            {
               if(infos.team == "challenger")
               {
                  this._attackersLifeById[id] = stats.getHealthPoints() + stats.getStatTotalValue(StatIds.SHIELD);
               }
               else
               {
                  this._defendersLifeById[id] = stats.getHealthPoints() + stats.getStatTotalValue(StatIds.SHIELD);
               }
            }
         }
         this.updateLifeBalance();
      }
      
      private function onUpdatePreFightersList(id:Number = 0) : void
      {
         this.updateLifeOfOneFighter(id);
      }
      
      private function onGameFightStart(... params) : void
      {
         if(this._fightStartTime == 0)
         {
            this._fightStartTime = new Date().getTime() / 1000;
            this.startClock();
         }
      }
      
      private function onFighterLookChange(actorId:Number, look:Object) : void
      {
         if(actorId == this._currentFighterId)
         {
            this.updateCurrentPlayerEntity();
         }
      }
      
      private function onTurnStart(fighterId:Number, waitingTime:uint, remainingTime:uint, picture:Boolean) : void
      {
         this._currentFighterId = fighterId;
         this.updateCurrentPlayerEntity();
      }
      
      private function updateCurrentPlayerEntity() : void
      {
         this.entityDisplayer.look = this.fightApi.getFighterInformations(this._currentFighterId).look;
         this.entityDisplayer.setAnimationAndDirection("AnimArtwork",1);
         this.entityDisplayer.visible = true;
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void
      {
         if(fightStartTime == 0)
         {
            return;
         }
         this._fightStartTime = fightStartTime;
         this.startClock();
      }
      
      private function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void
      {
         var targetId:Number = NaN;
         if(targetList == null)
         {
            targetList = [];
            if(params.length)
            {
               targetList[0] = params[0];
            }
         }
         var num:int = targetList.length;
         for(var i:int = 0; i < num; i++)
         {
            targetId = targetList[i];
            switch(eventName)
            {
               case "fighterLifeGain":
               case "fighterLifeLoss":
               case "fighterShieldLoss":
               case "fighterGotDispelled":
               case "fighterTemporaryBoosted":
               case "fighterDeath":
               case "fighterLeave":
                  this.updateLifeOfOneFighter(targetId);
                  break;
               case "fighterSummoned":
                  break;
            }
         }
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function onUpdateHealthPoints(stat:Stat) : void
      {
         this.updateLifeOfOneFighter(stat.entityId);
      }
   }
}
