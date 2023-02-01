package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import damageCalculation.tools.StatIds;
   import flash.display.Sprite;
   
   public class FightSummonStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _summonerId:Number;
      
      private var _summonInfos:GameFightFighterInformations;
      
      public function FightSummonStep(summonerId:Number, summonInfos:GameFightFighterInformations)
      {
         super();
         this._summonerId = summonerId;
         this._summonInfos = summonInfos;
      }
      
      public function get stepType() : String
      {
         return "summon";
      }
      
      override public function start() : void
      {
         var gfsgmsg:GameFightShowFighterMessage = null;
         var buffs:Array = null;
         var buff:BasicBuff = null;
         var fighterInfos:GameFightFighterInformations = null;
         var stats:EntityStats = null;
         var fighterLifePoints:Number = NaN;
         var summonedCreature:Sprite = DofusEntities.getEntity(this._summonInfos.contextualId) as Sprite;
         if(summonedCreature)
         {
            summonedCreature.visible = true;
         }
         else
         {
            gfsgmsg = new GameFightShowFighterMessage();
            gfsgmsg.initGameFightShowFighterMessage(this._summonInfos);
            Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsgmsg);
         }
         if(EntitiesManager.getInstance().entitiesScheduledForDestruction[this._summonInfos.contextualId])
         {
            delete EntitiesManager.getInstance().entitiesScheduledForDestruction[this._summonInfos.contextualId];
         }
         SpellWrapper.refreshAllPlayerSpellHolder(this._summonerId);
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fightBattleFrame && fightBattleFrame.deadFightersList.indexOf(this._summonInfos.contextualId) != -1)
         {
            fightBattleFrame.deadFightersList.splice(fightBattleFrame.deadFightersList.indexOf(this._summonInfos.contextualId),1);
            buffs = BuffManager.getInstance().getAllBuff(this._summonInfos.contextualId);
            for each(buff in buffs)
            {
               if(buff is StateBuff)
               {
                  BuffManager.getInstance().updateBuff(buff);
               }
            }
         }
         var summonStats:EntityStats = StatsManager.getInstance().getStats(this._summonInfos.contextualId);
         var summonLifePoints:Number = summonStats.getHealthPoints();
         if(this._summonInfos.contextualId == PlayedCharacterManager.getInstance().id)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._summonInfos.contextualId) as GameFightFighterInformations;
            stats = StatsManager.getInstance().getStats(fighterInfos.contextualId);
            if(!fighterInfos || !stats || !summonStats)
            {
               super.executeCallbacks();
               return;
            }
            CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown(true);
            fighterLifePoints = summonLifePoints === 0 ? Number(summonStats.getMaxHealthPoints() / 2) : Number(summonLifePoints);
            stats.setStat(new Stat(StatIds.CUR_LIFE,fighterLifePoints - summonStats.getMaxHealthPoints() - summonStats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)));
            if(PlayedCharacterManager.getInstance().id == this._summonInfos.contextualId)
            {
               StatsManager.getInstance().getStats(PlayedCharacterManager.getInstance().id).setStat(new Stat(StatIds.CUR_LIFE,fighterLifePoints - summonStats.getMaxHealthPoints() - summonStats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)));
            }
         }
         else if(summonLifePoints === 0 && summonStats)
         {
            summonStats.setStat(new Stat(StatIds.CUR_LIFE,-(summonStats.getMaxHealthPoints() + summonStats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)) / 2));
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SUMMONED,[this._summonerId,this._summonInfos.contextualId],this._summonInfos.contextualId,castingSpellId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._summonInfos.contextualId];
      }
   }
}
