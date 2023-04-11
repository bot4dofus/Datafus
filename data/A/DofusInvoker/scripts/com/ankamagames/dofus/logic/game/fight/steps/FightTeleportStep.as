package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class FightTeleportStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _destinationCell:MapPoint;
      
      public function FightTeleportStep(fighterId:Number, destinationCell:MapPoint)
      {
         super();
         this._fighterId = fighterId;
         this._destinationCell = destinationCell;
      }
      
      public function get stepType() : String
      {
         return "teleport";
      }
      
      override public function start() : void
      {
         var carriedEntityInfos:GameFightFighterInformations = null;
         var fightTurnFrame:FightTurnFrame = null;
         var entity:IMovable = DofusEntities.getEntity(this._fighterId) as IMovable;
         if(entity)
         {
            entity.jump(this._destinationCell);
            if(FightEntitiesFrame.getCurrentInstance().hasIcon(this._fighterId))
            {
               FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._fighterId);
            }
         }
         else
         {
            _log.warn("Unable to teleport unknown entity " + this._fighterId + ".");
         }
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
         infos.disposition.cellId = this._destinationCell.cellId;
         var carryingEntity:AnimatedCharacter = DofusEntities.getEntity(this._fighterId) as AnimatedCharacter;
         var carriedEntity:AnimatedCharacter = !!carryingEntity.carriedEntity ? carryingEntity.carriedEntity as AnimatedCharacter : null;
         if(carriedEntity)
         {
            carriedEntityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(carriedEntity.id) as GameFightFighterInformations;
            carriedEntityInfos.disposition.cellId = infos.disposition.cellId;
         }
         if(this._fighterId == PlayedCharacterManager.getInstance().id)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(fightTurnFrame && fightTurnFrame.myTurn)
            {
               fightTurnFrame.drawPath();
            }
         }
         FightSpellCastFrame.updateRangeAndTarget();
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fightContextFrame.showPermanentTooltips && fightContextFrame.battleFrame.targetedEntities.indexOf(entity.id) != -1)
         {
            TooltipManager.updatePosition(infos is GameFightCharacterInformations ? "PlayerShortInfos" + this._fighterId : "EntityShortInfos" + this._fighterId,"tooltipOverEntity_" + this._fighterId,(entity as AnimatedCharacter).absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,entity.position.cellId);
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TELEPORTED,[this._fighterId],0,castingSpellId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
