package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import damageCalculation.tools.StatIds;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public class FightDeathStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _entityId:Number;
      
      private var _deathSubSequence:ISequencer;
      
      private var _naturalDeath:Boolean;
      
      private var _targetName:String;
      
      private var _needToWarn:Boolean = true;
      
      private var _timeOut:Boolean = false;
      
      public function FightDeathStep(entityId:Number, naturalDeath:Boolean = true)
      {
         super();
         this._entityId = entityId;
         this._naturalDeath = naturalDeath;
         var fightContexteFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fightContexteFrame)
         {
            this._targetName = fightContexteFrame.getFighterName(entityId);
         }
         else
         {
            this._targetName = "???";
         }
      }
      
      public function get stepType() : String
      {
         return "death";
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      override public function start() : void
      {
         var waitAnimation:Boolean = false;
         var dyingEntity:IEntity = DofusEntities.getEntity(this._entityId);
         if(!dyingEntity)
         {
            _log.warn("Unable to play death of an unexisting fighter " + this._entityId + ".");
            this._needToWarn = true;
            this.deathFinished();
            return;
         }
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
         var fighterStats:EntityStats = StatsManager.getInstance().getStats(fighterInfos.contextualId);
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fightBattleFrame)
         {
            fightBattleFrame.deadFightersList.push(this._entityId);
         }
         this._needToWarn = true;
         BuffManager.getInstance().dispell(dyingEntity.id,false,false,true);
         var impactedTarget:Array = BuffManager.getInstance().removeLinkedBuff(dyingEntity.id,false,true);
         BuffManager.getInstance().reaffectBuffs(dyingEntity.id);
         fighterStats.setStat(new Stat(StatIds.CUR_PERMANENT_DAMAGE,0));
         fighterStats.setStat(new Stat(StatIds.CUR_LIFE,-(fighterStats.getMaxHealthPoints() + fighterStats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE))));
         this._deathSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(dyingEntity is TiphonSprite)
         {
            if(fightBattleFrame && fightBattleFrame.deathPlayingNumber > 1)
            {
               this._deathSubSequence.addStep(new AddGfxEntityStep(3182,fighterInfos.disposition.cellId));
            }
            else
            {
               this._deathSubSequence.addStep(new PlayAnimationStep(dyingEntity as TiphonSprite,AnimationEnum.ANIM_MORT,true,false));
            }
            this._deathSubSequence.addStep(new CallbackStep(new Callback(this.onAnimEnd,dyingEntity)));
         }
         this._deathSubSequence.addStep(new CallbackStep(new Callback(this.manualRollOut,this._entityId)));
         var dyingEntitySprite:TiphonSprite = dyingEntity as TiphonSprite;
         if(!dyingEntitySprite || !dyingEntitySprite.parentSprite || dyingEntitySprite.parentSprite.carriedEntity != dyingEntitySprite)
         {
            waitAnimation = true;
            if(fighterInfos.disposition.cellId == -1 || dyingEntitySprite.carriedEntity !== null)
            {
               waitAnimation = false;
            }
            this._deathSubSequence.addStep(new FightDestroyEntityStep(dyingEntity,waitAnimation));
         }
         this._deathSubSequence.addEventListener(SequencerEvent.SEQUENCE_TIMEOUT,this.deathTimeOut);
         this._deathSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.deathFinished);
         this._deathSubSequence.start();
      }
      
      override public function clear() : void
      {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.clear();
         }
         super.clear();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._entityId];
      }
      
      private function manualRollOut(fighterId:Number) : void
      {
         var fightContextFrame:FightContextFrame = null;
         if(FightContextFrame.fighterEntityTooltipId == fighterId)
         {
            fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(fightContextFrame)
            {
               fightContextFrame.outEntity(fighterId);
            }
         }
      }
      
      private function onAnimEnd(dyingEntity:TiphonSprite) : void
      {
         var rider:TiphonSprite = dyingEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
         if(rider)
         {
            dyingEntity = rider;
         }
         var carriedEntity:DisplayObjectContainer = dyingEntity.getSubEntitySlot(FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX);
         if(carriedEntity)
         {
            dyingEntity.removeSubEntity(carriedEntity);
         }
      }
      
      private function deathTimeOut(e:Event = null) : void
      {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.deathFinished);
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_TIMEOUT,this.deathTimeOut);
         }
         this._timeOut = true;
      }
      
      private function deathFinished(e:Event = null) : void
      {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.deathFinished);
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_TIMEOUT,this.deathTimeOut);
            this._deathSubSequence = null;
         }
         if(this._needToWarn)
         {
            if(this._naturalDeath)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_DEATH,[this._entityId,this._targetName],this._entityId,castingSpellId,this._timeOut);
            }
            else
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVE,[this._entityId,this._targetName],this._entityId,castingSpellId,this._timeOut);
            }
         }
         executeCallbacks();
      }
   }
}
