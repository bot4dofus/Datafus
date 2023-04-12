package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   
   public class FightEntityMovementStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _entityId:Number;
      
      private var _entity:AnimatedCharacter;
      
      private var _path:MovementPath;
      
      private var _fightContextFrame:FightContextFrame;
      
      private var _ttCacheName:String;
      
      private var _ttName:String;
      
      public function FightEntityMovementStep(entityId:Number, path:MovementPath)
      {
         super();
         this._entityId = entityId;
         this._path = path;
         timeout = path.length * 1000;
         this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
      
      public function get stepType() : String
      {
         return "entityMovement";
      }
      
      override public function start() : void
      {
         var fighterInfos:GameFightFighterInformations = null;
         this._entity = DofusEntities.getEntity(this._entityId) as AnimatedCharacter;
         if(this._entity)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            fighterInfos.disposition.cellId = this._path.end.cellId;
            this._ttCacheName = fighterInfos is GameFightCharacterInformations ? "PlayerShortInfos" + this._entityId : "EntityShortInfos" + this._entityId;
            this._ttName = "tooltipOverEntity_" + this._entityId;
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.MOVEMENT_STEP);
            this._entity.move(this._path,this.movementEnd);
         }
         else
         {
            _log.warn("Unable to move unknown entity " + this._entityId + ".");
            this.movementEnd();
         }
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._entityId];
      }
      
      private function showCarriedEntityTooltip() : void
      {
         var carriedEntityInfos:GameFightFighterInformations = null;
         var ttCacheName:String = null;
         var carriedEntity:AnimatedCharacter = this._entity.carriedEntity as AnimatedCharacter;
         if(carriedEntity && (this._fightContextFrame.timelineOverEntity && this._fightContextFrame.timelineOverEntityId == carriedEntity.id || this._fightContextFrame.showPermanentTooltips && this._fightContextFrame.battleFrame.targetedEntities.indexOf(carriedEntity.id) != -1))
         {
            carriedEntityInfos = this._fightContextFrame.entitiesFrame.getEntityInfos(carriedEntity.id) as GameFightFighterInformations;
            ttCacheName = carriedEntityInfos is GameFightCharacterInformations ? "PlayerShortInfos" + carriedEntity.id : "EntityShortInfos" + carriedEntity.id;
            TooltipManager.updatePosition(ttCacheName,"tooltipOverEntity_" + carriedEntity.id,carriedEntity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
      }
      
      private function updateCarriedEntitiesPosition() : void
      {
         var infos:GameFightFighterInformations = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var carriedEntity:AnimatedCharacter = this._entity.carriedEntity as AnimatedCharacter;
         while(carriedEntity)
         {
            infos = entitiesFrame.getEntityInfos(carriedEntity.id) as GameFightFighterInformations;
            if(infos && carriedEntity.position.cellId != -1)
            {
               infos.disposition.cellId = this._entity.position.cellId;
            }
            carriedEntity = carriedEntity.carriedEntity as AnimatedCharacter;
         }
      }
      
      private function movementEnd() : void
      {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         if(this._fightContextFrame.timelineOverEntity || this._fightContextFrame.showPermanentTooltips && this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) != -1)
         {
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
         this.showCarriedEntityTooltip();
         this.updateCarriedEntitiesPosition();
         FightSpellCastFrame.updateRangeAndTarget();
         if(FightEntitiesFrame.getCurrentInstance().hasIcon(this._entityId))
         {
            FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._entityId);
         }
         executeCallbacks();
      }
      
      private function onEnterFrame(pEvent:Event) : void
      {
         if(this._fightContextFrame.timelineOverEntity || this._fightContextFrame.showPermanentTooltips && this._fightContextFrame.battleFrame && this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) != -1)
         {
            if(!this._entity || !this._entity.position)
            {
               EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
               return;
            }
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
         this.showCarriedEntityTooltip();
      }
   }
}
