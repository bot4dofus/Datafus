package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class FightExchangePositionsStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterOne:Number;
      
      private var _fighterOneNewCell:int;
      
      private var _fighterTwo:Number;
      
      private var _fighterTwoNewCell:int;
      
      private var _fighterOneVisibility:int;
      
      public function FightExchangePositionsStep(fighterOne:Number, fighterOneNewCell:int, fighterTwo:Number, fighterTwoNewCell:int)
      {
         super();
         this._fighterOne = fighterOne;
         this._fighterOneNewCell = fighterOneNewCell;
         this._fighterTwo = fighterTwo;
         this._fighterTwoNewCell = fighterTwoNewCell;
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         this._fighterOneVisibility = infos.stats.invisibilityState;
         infos.disposition.cellId = this._fighterOneNewCell;
         infos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         infos.disposition.cellId = this._fighterTwoNewCell;
      }
      
      public function get stepType() : String
      {
         return "exchangePositions";
      }
      
      override public function start() : void
      {
         var fighterOneCarriedEntity:AnimatedCharacter = null;
         var fighterTwoCarriedEntity:AnimatedCharacter = null;
         if(this._fighterOneVisibility != GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            if(!this.doJump(this._fighterOne,this._fighterOneNewCell))
            {
               _log.warn("Unable to move unexisting fighter " + this._fighterOne + " (1) to " + this._fighterOneNewCell + " during a positions exchange.");
            }
         }
         if(!this.doJump(this._fighterTwo,this._fighterTwoNewCell))
         {
            _log.warn("Unable to move unexisting fighter " + this._fighterTwo + " (2) to " + this._fighterTwoNewCell + " during a positions exchange.");
         }
         var fighterInfosOne:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         var fighterInfosTwo:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         fighterInfosOne.disposition.cellId = this._fighterOneNewCell;
         fighterInfosTwo.disposition.cellId = this._fighterTwoNewCell;
         var fighterOne:AnimatedCharacter = EntitiesManager.getInstance().getEntity(this._fighterOne) as AnimatedCharacter;
         if(fighterOne)
         {
            this.showEntityTooltip(fighterOne,fighterInfosOne);
            if(fighterOne.carriedEntity)
            {
               fighterOneCarriedEntity = fighterOne.carriedEntity as AnimatedCharacter;
               this.showEntityTooltip(fighterOneCarriedEntity,FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterOneCarriedEntity.id) as GameFightFighterInformations);
            }
         }
         var fighterTwo:AnimatedCharacter = EntitiesManager.getInstance().getEntity(this._fighterTwo) as AnimatedCharacter;
         if(fighterTwo)
         {
            this.showEntityTooltip(fighterTwo,fighterInfosTwo);
            if(fighterTwo.carriedEntity)
            {
               fighterTwoCarriedEntity = fighterTwo.carriedEntity as AnimatedCharacter;
               this.showEntityTooltip(fighterTwoCarriedEntity,FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterTwoCarriedEntity.id) as GameFightFighterInformations);
            }
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTERS_POSITION_EXCHANGE,[this._fighterOne,this._fighterTwo],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._fighterOne);
         FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._fighterTwo);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterOne,this._fighterTwo];
      }
      
      private function showEntityTooltip(pEntity:AnimatedCharacter, pEntityInfos:GameFightFighterInformations) : void
      {
         var ttCacheName:String = null;
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(pEntity && (fightContextFrame.timelineOverEntity && fightContextFrame.timelineOverEntityId == pEntity.id || fightContextFrame.showPermanentTooltips && fightContextFrame.battleFrame.targetedEntities.indexOf(pEntity.id) != -1))
         {
            ttCacheName = pEntityInfos is GameFightCharacterInformations ? "PlayerShortInfos" + pEntity.id : "EntityShortInfos" + pEntity.id;
            TooltipManager.updatePosition(ttCacheName,"tooltipOverEntity_" + pEntity.id,pEntity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,pEntity.position.cellId);
         }
      }
      
      private function doJump(fighterId:Number, newCell:int) : Boolean
      {
         var fighterEntity:IMovable = null;
         if(newCell > -1)
         {
            fighterEntity = DofusEntities.getEntity(fighterId) as IMovable;
            if(!fighterEntity)
            {
               return false;
            }
            fighterEntity.jump(MapPoint.fromCellId(newCell));
         }
         return true;
      }
   }
}
