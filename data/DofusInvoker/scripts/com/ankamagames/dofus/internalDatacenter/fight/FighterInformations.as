package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public class FighterInformations implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FighterInformations));
       
      
      private var _fighterId:Number;
      
      private var _look:TiphonEntityLook;
      
      private var _currentCell:int;
      
      private var _currentOrientation:int;
      
      private var _isAlive:Boolean;
      
      private var _team:String;
      
      private var _wave:int;
      
      private var _rank:int;
      
      private var _hiddenInPrefight:Boolean;
      
      private var _summoner:int;
      
      private var _summoned:Boolean;
      
      private var _stats:EntityStats = null;
      
      public function FighterInformations(fighterId:Number)
      {
         super();
         var fightFrame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         var statsManager:StatsManager = StatsManager.getInstance();
         this._stats = statsManager !== null ? statsManager.getStats(fighterId) : null;
         if(!fightFrame || !(fightFrame as FightContextFrame).entitiesFrame)
         {
            return;
         }
         var fighterInfos:GameFightFighterInformations = (fightFrame as FightContextFrame).entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
         if(!fighterInfos)
         {
            return;
         }
         this._fighterId = fighterId;
         this._look = EntityLookAdapter.fromNetwork(fighterInfos.look);
         this._look = TiphonUtility.getLookWithoutMount(this._look);
         var entity:IEntity = DofusEntities.getEntity(fighterId);
         if(entity && entity.position)
         {
            this._currentCell = entity.position.cellId;
         }
         else
         {
            this._currentCell = fighterInfos.disposition.cellId;
         }
         this._currentOrientation = fighterInfos.disposition.direction;
         this._isAlive = fighterInfos.spawnInfo.alive;
         switch(fighterInfos.spawnInfo.teamId)
         {
            case TeamEnum.TEAM_CHALLENGER:
               this._team = "challenger";
               break;
            case TeamEnum.TEAM_DEFENDER:
               this._team = "defender";
               break;
            case TeamEnum.TEAM_SPECTATOR:
               this._team = "spectator";
               break;
            default:
               _log.warn("Unknown teamId " + fighterInfos.spawnInfo.teamId + " ?!");
               this._team = "unknown";
         }
         this._wave = fighterInfos.wave;
         if(fighterInfos is GameFightFighterNamedInformations)
         {
            this._rank = (fighterInfos as GameFightFighterNamedInformations).leagueId;
            this._hiddenInPrefight = (fighterInfos as GameFightFighterNamedInformations).hiddenInPrefight;
         }
         this._summoner = fighterInfos.stats.summoner;
         this._summoned = fighterInfos.stats.summoned;
      }
      
      public function get fighterId() : Number
      {
         return this._fighterId;
      }
      
      public function get look() : TiphonEntityLook
      {
         return this._look;
      }
      
      public function get currentCell() : int
      {
         return this._currentCell;
      }
      
      public function get currentOrientation() : int
      {
         return this._currentOrientation;
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function get team() : String
      {
         return this._team;
      }
      
      public function get wave() : int
      {
         return this._wave;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function get hiddenInPrefight() : Boolean
      {
         return this._hiddenInPrefight;
      }
      
      public function get summoner() : int
      {
         return this._summoner;
      }
      
      public function get summoned() : Boolean
      {
         return this._summoned;
      }
      
      public function get stats() : EntityStats
      {
         return this._stats;
      }
   }
}
