package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class FightThrowCharacterStep extends AbstractSequencable implements IFightStep
   {
      
      private static const THROWING_PROJECTILE_FX:uint = 21209;
       
      
      private var _fighterId:Number;
      
      private var _carriedId:Number;
      
      private var _cellId:int;
      
      private var _throwSubSequence:ISequencer;
      
      private var _isCreature:Boolean;
      
      public var portals:Vector.<MapPoint>;
      
      public var portalIds:Vector.<int>;
      
      public function FightThrowCharacterStep(fighterId:Number, carriedId:Number, cellId:int)
      {
         super();
         this._fighterId = fighterId;
         this._carriedId = carriedId;
         this._cellId = cellId;
         this._isCreature = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).isInCreaturesFightMode();
      }
      
      public function get stepType() : String
      {
         return "throwCharacter";
      }
      
      override public function start() : void
      {
         var fightTurnFrame:FightTurnFrame = null;
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
         var projectile:Projectile = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var carryingEntity:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         var carryingEntityInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(this._fighterId) as GameFightFighterInformations;
         var realCarryingEntity:IEntity = carryingEntity as IEntity;
         carryingEntity = TiphonUtility.getEntityWithoutMount(carryingEntity as TiphonSprite);
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         var carriedEntityInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(this._carriedId) as GameFightFighterInformations;
         var carryingFighterExist:Boolean = true;
         var carryingEntityTS:TiphonSprite = carryingEntity as TiphonSprite;
         var carriedEntityTS:TiphonSprite = carriedEntity as TiphonSprite;
         if(!carriedEntity || !carriedEntityInfos.spawnInfo.alive)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            this._throwSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
            if(carriedEntity)
            {
               this._throwSubSequence.addStep(new FightDestroyEntityStep(carriedEntity,true,true));
            }
            if(carryingEntityTS !== null)
            {
               carryingEntityTS.removeAnimationModifierByClass(CarrierAnimationModifier);
            }
            if(carryingEntityTS !== null)
            {
               this._throwSubSequence.addStep(new SetAnimationStep(carryingEntityTS,AnimationEnum.ANIM_STATIQUE));
            }
            this.startSubSequence();
            this.throwFinished();
            return;
         }
         if(!carryingEntity || !carryingEntityInfos.spawnInfo.alive)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            (carriedEntity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            if(carriedEntityTS !== null)
            {
               carriedEntityTS.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            carryingFighterExist = false;
         }
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._carriedId) as GameFightFighterInformations;
         if(this._cellId != -1)
         {
            fighterInfos.disposition.cellId = this._cellId;
         }
         if(this._carriedId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(fightTurnFrame)
            {
               fightTurnFrame.freePlayer();
            }
         }
         var invisibility:Boolean = false;
         if(fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            invisibility = true;
         }
         _log.debug(this._fighterId + " is throwing " + this._carriedId + " (invisibility : " + invisibility + ")");
         if(!invisibility)
         {
            FightEntitiesHolder.getInstance().unholdEntity(this._carriedId);
         }
         if(carryingEntityTS !== null)
         {
            carryingEntityTS.removeAnimationModifierByClass(CarrierAnimationModifier);
         }
         this._throwSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(carryingFighterExist)
         {
            if(this._cellId == -1 || invisibility)
            {
               this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
               if(carryingEntityTS !== null)
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(carryingEntityTS,AnimationEnum.ANIM_STATIQUE));
               }
               this.startSubSequence();
               return;
            }
         }
         if(this.portals && this.portals.length > 1)
         {
            entryPortalCell = this.portals[0];
            exitPortalCell = this.portals[this.portals.length - 1];
         }
         var finalTargetCell:MapPoint = MapPoint.fromCellId(this._cellId);
         var targetCell:MapPoint = entryPortalCell != null ? entryPortalCell : finalTargetCell;
         var targetDistance:int = realCarryingEntity !== null ? int(realCarryingEntity.position.distanceToCell(targetCell)) : 0;
         var targetDirection:int = realCarryingEntity !== null ? int(realCarryingEntity.position.advancedOrientationTo(targetCell)) : 0;
         if(!invisibility)
         {
            carriedEntity.position = finalTargetCell;
         }
         if(carryingEntityTS !== null)
         {
            this._throwSubSequence.addStep(new SetDirectionStep(carryingEntityTS.rootEntity,targetDirection));
         }
         if(targetDistance <= 1)
         {
            _log.debug("Dropping nearby.");
            if(carryingEntityTS !== null)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(carryingEntityTS,AnimationEnum.ANIM_DROP,invisibility,true,TiphonEvent.ANIMATION_END,1,!!invisibility ? AnimationEnum.ANIM_STATIQUE : ""));
                  if(entryPortalCell)
                  {
                     this.addCleanEntitiesSteps(carriedEntity,carryingEntity,false);
                     this.addPortalAnimationSteps();
                     projectile = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
                     projectile.position = exitPortalCell;
                     this._throwSubSequence.addStep(new AddWorldEntityStep(projectile));
                     this._throwSubSequence.addStep(new ParableGfxMovementStep(projectile,finalTargetCell,200,0.3,-70,true,1));
                     this._throwSubSequence.addStep(new FightDestroyEntityStep(projectile));
                  }
               }
               else
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(carryingEntityTS,AnimationEnum.ANIM_STATIQUE));
               }
            }
         }
         else
         {
            _log.debug("Throwing away.");
            if(carryingEntityTS !== null)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(carryingEntityTS,AnimationEnum.ANIM_THROW,invisibility,true,TiphonEvent.ANIMATION_SHOT,1,!!invisibility ? AnimationEnum.ANIM_STATIQUE : ""));
               }
               else
               {
                  carriedEntityTS.visible = false;
               }
            }
            if(!invisibility && realCarryingEntity)
            {
               projectile = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
               projectile.position = realCarryingEntity.position.getNearestCellInDirection(targetDirection);
               this._throwSubSequence.addStep(new AddWorldEntityStep(projectile));
               this._throwSubSequence.addStep(new ParableGfxMovementStep(projectile,targetCell,200,0.3,-70,true,1));
               this._throwSubSequence.addStep(new FightDestroyEntityStep(projectile));
               if(exitPortalCell)
               {
                  this.addCleanEntitiesSteps(carriedEntity,carryingEntity,false);
                  this.addPortalAnimationSteps();
                  projectile = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
                  projectile.position = exitPortalCell;
                  this._throwSubSequence.addStep(new AddWorldEntityStep(projectile));
                  this._throwSubSequence.addStep(new ParableGfxMovementStep(projectile,finalTargetCell,200,0.3,-70,true,1));
                  this._throwSubSequence.addStep(new FightDestroyEntityStep(projectile));
               }
            }
         }
         if(invisibility)
         {
            this.startSubSequence();
            return;
         }
         if(entryPortalCell)
         {
            this._throwSubSequence.addStep(new AddWorldEntityStep(carriedEntity));
         }
         else
         {
            this.addCleanEntitiesSteps(carriedEntity,carryingEntity,true);
         }
         this.startSubSequence();
         if(carryingEntity !== null)
         {
            carryingEntityTS.forceVisibilityRefresh();
         }
         if(carriedEntityTS !== null)
         {
            carriedEntityTS.forceVisibilityRefresh();
         }
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._carriedId];
      }
      
      private function startSubSequence() : void
      {
         this._throwSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
         this._throwSubSequence.start();
      }
      
      private function throwFinished(e:Event = null) : void
      {
         var parentEntity:TiphonSprite = null;
         var rider:DisplayObject = null;
         if(this._throwSubSequence)
         {
            this._throwSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
            this._throwSubSequence = null;
         }
         var carryingEntity:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         if(carryingEntity is TiphonSprite)
         {
            rider = (carryingEntity as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
            if(rider)
            {
               (carryingEntity as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
               carryingEntity = rider;
            }
         }
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         if(carryingEntity && carryingEntity is TiphonSprite)
         {
            (carryingEntity as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
            (carryingEntity as TiphonSprite).removeSubEntity(carriedEntity as DisplayObject);
         }
         if(carriedEntity)
         {
            (carriedEntity as TiphonSprite).visible = true;
            if(carriedEntity is IMovable)
            {
               IMovable(carriedEntity).movementBehavior.synchroniseSubEntitiesPosition(IMovable(carriedEntity));
            }
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_THROW,[this._fighterId,this._carriedId,this._cellId],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         if(FightEntitiesFrame.getCurrentInstance().hasIcon(this._fighterId))
         {
            FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._fighterId);
         }
         var parent:TiphonSprite = !!carriedEntity ? (carriedEntity as TiphonSprite).parentSprite : null;
         while(parent)
         {
            parentEntity = parent;
            parent = parent.parentSprite;
         }
         var parentEntityId:Number = !!parentEntity ? Number((parentEntity as AnimatedCharacter).id) : (!!carriedEntity ? Number((carriedEntity as AnimatedCharacter).id) : Number(NaN));
         if(!isNaN(parentEntityId))
         {
            if(FightEntitiesFrame.getCurrentInstance().hasIcon(parentEntityId))
            {
               FightEntitiesFrame.getCurrentInstance().forceIconUpdate(parentEntityId);
            }
         }
         executeCallbacks();
      }
      
      private function addCleanEntitiesSteps(carriedEntity:IEntity, carryingEntity:DisplayObject, addEntity:Boolean) : void
      {
         this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
         var direction:int = carryingEntity !== null ? int((carryingEntity as TiphonSprite).rootEntity.getDirection()) : 0;
         this._throwSubSequence.addStep(new SetDirectionStep(carriedEntity as TiphonSprite,direction));
         if(addEntity)
         {
            this._throwSubSequence.addStep(new AddWorldEntityStep(carriedEntity));
         }
         this._throwSubSequence.addStep(new SetAnimationStep(carriedEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         if(carryingEntity is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         }
      }
      
      private function addPortalAnimationSteps() : void
      {
         var previousAnimation:String = "";
         var glyph:Glyph = MarkedCellsManager.getInstance().getGlyph(this.portalIds[0]);
         if(glyph)
         {
            if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               previousAnimation = glyph.getAnimation();
               this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false));
            }
            else
            {
               previousAnimation = "";
            }
            this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT));
            if(previousAnimation != "")
            {
               this._throwSubSequence.addStep(new PlayAnimationStep(glyph,previousAnimation,false,false));
            }
         }
         for(var i:int = 1; i < this.portalIds.length - 1; i++)
         {
            glyph = MarkedCellsManager.getInstance().getGlyph(this.portalIds[i]);
            if(glyph)
            {
               if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
               {
                  previousAnimation = glyph.getAnimation();
                  this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false));
               }
               else
               {
                  previousAnimation = "";
               }
               this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT));
               if(previousAnimation != "")
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(glyph,previousAnimation,false,false));
               }
            }
         }
         glyph = MarkedCellsManager.getInstance().getGlyph(this.portalIds[this.portalIds.length - 1]);
         if(glyph)
         {
            if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               previousAnimation = glyph.getAnimation();
               this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false));
            }
            else
            {
               previousAnimation = "";
            }
            this._throwSubSequence.addStep(new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_EXIT_SPELL,false,false));
            if(previousAnimation != "")
            {
               this._throwSubSequence.addStep(new PlayAnimationStep(glyph,previousAnimation,false,false));
            }
         }
      }
      
      override public function toString() : String
      {
         return "[FightThrowCharacterStep(carrier=" + this._fighterId + ", carried=" + this._carriedId + ", cell=" + this._cellId + ")]";
      }
   }
}
