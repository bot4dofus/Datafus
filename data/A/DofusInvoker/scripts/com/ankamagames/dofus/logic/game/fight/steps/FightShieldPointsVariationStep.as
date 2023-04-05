package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import damageCalculation.tools.StatIds;
   
   public class FightShieldPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public static const COLOR:uint = 10053324;
      
      private static const BLOCKING:Boolean = false;
       
      
      private var _intValue:int;
      
      private var _elementId:int;
      
      private var _entityStats:EntityStats = null;
      
      private var _newShieldStat:EntityStat = null;
      
      private var _fighterInfo:GameFightFighterInformations = null;
      
      private var _target:AnimatedCharacter = null;
      
      public function FightShieldPointsVariationStep(entityId:Number, value:int, elementId:int)
      {
         super(COLOR,value.toString(),entityId,GameContextEnum.FIGHT,BLOCKING);
         this._intValue = value;
         this._elementId = elementId;
         _virtual = false;
         this._entityStats = StatsManager.getInstance().getStats(_targetId);
         if(this._entityStats !== null)
         {
            this._newShieldStat = this._entityStats.getStat(StatIds.SHIELD) as EntityStat;
         }
      }
      
      public function get stepType() : String
      {
         return "shieldPointsVariation";
      }
      
      public function get value() : int
      {
         return this._intValue;
      }
      
      public function set virtual(pValue:Boolean) : void
      {
         _virtual = pValue;
      }
      
      override public function start() : void
      {
         this._target = DofusEntities.getEntity(_targetId) as AnimatedCharacter;
         if(this._target && this._target.isPlayingAnimation())
         {
            this._target.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            return;
         }
         this._fighterInfo = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(!this._fighterInfo)
         {
            super.executeCallbacks();
            return;
         }
         EnterFrameDispatcher.worker.addSingleTreatment(StatsManager.getInstance(),this.apply,[]);
      }
      
      private function apply() : void
      {
         var ttCacheName:String = null;
         var ttName:String = "tooltipOverEntity_" + this._fighterInfo.contextualId;
         if(this._fighterInfo is GameFightCharacterInformations)
         {
            ttCacheName = "PlayerShortInfos" + this._fighterInfo.contextualId;
         }
         else
         {
            ttCacheName = "EntityShortInfos" + this._fighterInfo.contextualId;
         }
         TooltipManager.updateContent(ttCacheName,ttName,this._fighterInfo);
         if(this._target && target && target.position)
         {
            TooltipManager.updatePosition(ttCacheName,ttName,this._target.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,target.position.cellId);
         }
         if(this._intValue < 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_LOSS,[_targetId,Math.abs(this._intValue),this._elementId],_targetId,castingSpellId);
         }
         else if(this._intValue == 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_NO_CHANGE,[_targetId],_targetId,castingSpellId);
         }
         super.start();
      }
      
      private function onAnimationEnd(pEvent:TiphonEvent) : void
      {
         var target:TiphonSprite = pEvent.currentTarget as TiphonSprite;
         target.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         this.start();
      }
   }
}
