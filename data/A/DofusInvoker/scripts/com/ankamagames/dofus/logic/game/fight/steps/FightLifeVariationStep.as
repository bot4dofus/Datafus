package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import damageCalculation.tools.StatIds;
   
   public class FightLifeVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public static const COLOR:uint = 16711680;
      
      private static const BLOCKING:Boolean = false;
       
      
      private var _delta:int;
      
      private var _permanentDamages:int;
      
      private var _elementId:int;
      
      public var skipTextEvent:Boolean = false;
      
      public var _fighterInfo:GameFightFighterInformations = null;
      
      public function FightLifeVariationStep(entityId:Number, delta:int, permanentDamages:int, elementId:int)
      {
         super(COLOR,delta.toString(),entityId,GameContextEnum.FIGHT,BLOCKING);
         _virtual = true;
         this._delta = delta;
         this._permanentDamages = permanentDamages;
         this._elementId = elementId;
      }
      
      public function get stepType() : String
      {
         return "lifeVariation";
      }
      
      public function get value() : int
      {
         return this._delta;
      }
      
      public function get delta() : int
      {
         return this._delta;
      }
      
      public function get permanentDamages() : int
      {
         return this._permanentDamages;
      }
      
      public function get elementId() : int
      {
         return this._elementId;
      }
      
      override public function start() : void
      {
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
         if(!FightEntitiesFrame.getCurrentInstance())
         {
            _log.warn("FightEntitiesFrame does not exist anymore, we don\'t execute this step.");
            return;
         }
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            _log.warn("Player does not seem to be fighting, we don\'t execute this step.");
            return;
         }
         var stats:EntityStats = StatsManager.getInstance().getStats(_targetId);
         var res:int = stats.getHealthPoints() + this._delta;
         var maxLifePoints:Number = Math.max(1,stats.getMaxHealthPoints() + this._permanentDamages);
         var lifePoints:Number = Math.min(Math.max(0,res),maxLifePoints);
         stats.setStat(new EntityStat(StatIds.CUR_PERMANENT_DAMAGE,stats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE) - this._permanentDamages));
         stats.setStat(new EntityStat(StatIds.CUR_LIFE,lifePoints - maxLifePoints - stats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)));
         if(this._fighterInfo is GameFightCharacterInformations)
         {
            TooltipManager.updateContent("PlayerShortInfos" + this._fighterInfo.contextualId,"tooltipOverEntity_" + this._fighterInfo.contextualId,this._fighterInfo);
         }
         else
         {
            TooltipManager.updateContent("EntityShortInfos" + this._fighterInfo.contextualId,"tooltipOverEntity_" + this._fighterInfo.contextualId,this._fighterInfo);
         }
         if(this._delta < 0 || this._delta == 0 && !this.skipTextEvent)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_LOSS,[_targetId,Math.abs(this._delta),this._elementId],_targetId,castingSpellId,false,2);
            if(_targetId == PlayedCharacterManager.getInstance().id)
            {
               SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_LOOSE_LIFE);
            }
            else if(this._fighterInfo.spawnInfo.teamId == PlayedCharacterManager.getInstance().teamId)
            {
               SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_ALLIED_LOOSE_LIFE);
            }
            else
            {
               SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_ENEMY_LOOSE_LIFE);
            }
         }
         else if(this._delta > 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_GAIN,[_targetId,Math.abs(this._delta),this._elementId],_targetId,castingSpellId,false,2);
         }
         if(this._permanentDamages < 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_PERMANENT_DAMAGE,[_targetId,Math.abs(this._permanentDamages),this._elementId],_targetId,castingSpellId,false,2);
         }
         super.start();
      }
   }
}
