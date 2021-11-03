package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.internalDatacenter.stats.UsableStat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifier;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import damageCalculation.fighterManagement.IFighterData;
   import damageCalculation.fighterManagement.fighterstats.HaxeDetailedStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeSimpleStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeUsableStat;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import mapTools.MapTools;
   
   public class FighterDataTranslator implements IFighterData
   {
       
      
      private var _stats:Dictionary;
      
      protected var _fighterInfos:GameFightFighterInformations;
      
      protected var _id:Number;
      
      protected var _monsterProperties:Monster = null;
      
      protected var itemSpellDamageModificator:Dictionary;
      
      protected var itemSpellBaseDamageModificator:Dictionary;
      
      public function FighterDataTranslator(fighterInfos:GameFightFighterInformations, fighterId:Number)
      {
         var monsterInfos:GameFightMonsterInformations = null;
         this.itemSpellDamageModificator = new Dictionary();
         this.itemSpellBaseDamageModificator = new Dictionary();
         super();
         this._fighterInfos = fighterInfos;
         this._id = fighterId;
         this.resetStats();
         if(this._fighterInfos is GameFightMonsterInformations)
         {
            monsterInfos = this._fighterInfos as GameFightMonsterInformations;
            this._monsterProperties = Monster.getMonsterById(monsterInfos.creatureGenericId);
         }
      }
      
      public function getUsedPM() : int
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._fighterInfos.contextualId);
         return stats !== null ? int(stats.getStatUsedValue(StatIds.MOVEMENT_POINTS)) : 0;
      }
      
      public function isSummon() : Boolean
      {
         return this._fighterInfos.stats.summoned;
      }
      
      public function useSummonSlot() : Boolean
      {
         return this._monsterProperties && this._monsterProperties.useSummonSlot;
      }
      
      public function getSummonerId() : Number
      {
         return this._fighterInfos.stats.summoner;
      }
      
      public function isInvisible() : Boolean
      {
         return this._fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE;
      }
      
      public function getBreed() : int
      {
         if(this._fighterInfos is GameFightCharacterInformations)
         {
            return (this._fighterInfos as GameFightCharacterInformations).breed;
         }
         if(this._fighterInfos is GameFightMonsterInformations)
         {
            return (this._fighterInfos as GameFightMonsterInformations).creatureGenericId;
         }
         return -1;
      }
      
      public function isAlly() : Boolean
      {
         var entities:Dictionary = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
         var fighter:GameFightFighterInformations = entities[this._id];
         if(fighter === null)
         {
            return false;
         }
         var playerId:Number = PlayedCharacterManager.getInstance().id;
         return entities[playerId] && fighter && (entities[playerId] as GameFightFighterInformations).spawnInfo.teamId == fighter.spawnInfo.teamId;
      }
      
      public function getCharacteristicValue(statId:int) : int
      {
         var stat:HaxeStat = null;
         var statKey:String = statId.toString();
         if(statKey in this._stats)
         {
            stat = this._stats[statKey];
            return stat.total;
         }
         return 0;
      }
      
      public function resolveDodge() : int
      {
         return -1;
      }
      
      public function getItemSpellDamageModification(spellId:int) : int
      {
         var spellModifier:SpellModifier = null;
         var spellModifierValue:Number = NaN;
         var spellModifiers:SpellModifiers = null;
         if(!(spellId in this.itemSpellDamageModificator))
         {
            spellModifier = null;
            spellModifierValue = 0;
            spellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(this._id,spellId);
            if(spellModifier !== null)
            {
               spellModifier = spellModifiers.getModifier(CharacterSpellModificationTypeEnum.DAMAGE);
               if(spellModifier !== null)
               {
                  spellModifierValue = spellModifier.baseValue + spellModifier.additionalValue + spellModifier.alignGiftBonusValue + spellModifier.objectsAndMountBonusValue;
               }
            }
            this.itemSpellDamageModificator[spellId] = spellModifierValue;
         }
         return this.itemSpellDamageModificator[spellId];
      }
      
      public function getItemSpellBaseDamageModification(spellId:int) : int
      {
         var spellModifier:SpellModifier = null;
         var spellModifierValue:Number = NaN;
         var spellModifiers:SpellModifiers = null;
         if(!(spellId in this.itemSpellBaseDamageModificator))
         {
            spellModifier = null;
            spellModifierValue = 0;
            spellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(this._id,spellId);
            if(spellModifier !== null)
            {
               spellModifier = spellModifiers.getModifier(CharacterSpellModificationTypeEnum.BASE_DAMAGE);
               if(spellModifier !== null)
               {
                  spellModifierValue = spellModifier.baseValue + spellModifier.additionalValue + spellModifier.alignGiftBonusValue + spellModifier.objectsAndMountBonusValue;
               }
            }
            this.itemSpellBaseDamageModificator[spellId] = spellModifierValue;
         }
         return this.itemSpellBaseDamageModificator[spellId];
      }
      
      public function canBreedSwitchPos() : Boolean
      {
         return !(this._monsterProperties != null && !this._monsterProperties.canSwitchPos);
      }
      
      public function canBreedSwitchPosOnTarget() : Boolean
      {
         return !(this._monsterProperties != null && !this._monsterProperties.canSwitchPosOnTarget);
      }
      
      public function canBreedUsePortals() : Boolean
      {
         return !(this._monsterProperties != null && !this._monsterProperties.canUsePortal);
      }
      
      public function canBreedBePushed() : Boolean
      {
         return !(this._monsterProperties != null && !this._monsterProperties.canBePushed);
      }
      
      public function canBreedBeCarried() : Boolean
      {
         return !(this._monsterProperties != null && !this._monsterProperties.canBeCarried);
      }
      
      public function getStartedPositionCell() : int
      {
         return this._fighterInfos.disposition.cellId;
      }
      
      public function getTurnBeginPosition() : int
      {
         return (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).getFighterRoundStartPosition(this._id);
      }
      
      public function getPreviousPosition() : int
      {
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fcf != null && fcf.getFighterPreviousPosition(this._id) != MapTools.INVALID_CELL_ID)
         {
            return fcf.getFighterPreviousPosition(this._id);
         }
         if(this._fighterInfos.previousPositions != null && this._fighterInfos.previousPositions.length > 0)
         {
            return this._fighterInfos.previousPositions[0];
         }
         return MapTools.INVALID_CELL_ID;
      }
      
      public function getStat(statId:int) : HaxeStat
      {
         var statKey:String = statId.toString();
         if(statKey in this._stats)
         {
            return this._stats[statKey];
         }
         return null;
      }
      
      public function setStat(stat:HaxeStat) : void
      {
         this._stats[stat.id.toString()] = stat;
      }
      
      public function getStatIds() : Array
      {
         var stat:HaxeStat = null;
         var toReturn:Array = [];
         if(this._stats !== null)
         {
            for each(stat in this._stats)
            {
               toReturn.push(stat.id);
            }
         }
         return toReturn;
      }
      
      public function resetStats() : void
      {
         var stat:Stat = null;
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         var usableStat:UsableStat = null;
         var detailedStat:DetailedStat = null;
         this._stats = new Dictionary();
         if(stats !== null)
         {
            for each(stat in stats.stats)
            {
               if(stat is UsableStat)
               {
                  usableStat = stat as UsableStat;
                  this._stats[usableStat.id] = new HaxeUsableStat(usableStat.id,usableStat.baseValue,usableStat.additionalValue,usableStat.objectsAndMountBonusValue,usableStat.alignGiftBonusValue,usableStat.contextModifValue,usableStat.usedValue);
               }
               else if(stat is DetailedStat)
               {
                  detailedStat = stat as DetailedStat;
                  this._stats[detailedStat.id] = new HaxeDetailedStat(detailedStat.id,detailedStat.baseValue,detailedStat.additionalValue,detailedStat.objectsAndMountBonusValue,detailedStat.alignGiftBonusValue,detailedStat.contextModifValue);
               }
               else if(stat is Stat)
               {
                  this._stats[stat.id] = new HaxeSimpleStat(stat.id,stat.totalValue);
               }
            }
         }
      }
      
      public function getHealthPoints() : int
      {
         return this.getMaxHealthPoints() + this.getCharacteristicValue(StatIds.CUR_LIFE) + this.getCharacteristicValue(StatIds.CUR_PERMANENT_DAMAGE);
      }
      
      public function getMaxHealthPoints() : int
      {
         var detailedVitalityStat:HaxeDetailedStat = null;
         var vitalityStat:HaxeStat = this._stats[StatIds.VITALITY];
         var effectiveVitality:Number = 0;
         if(vitalityStat is HaxeDetailedStat)
         {
            detailedVitalityStat = vitalityStat as HaxeDetailedStat;
            effectiveVitality = Math.max(0,detailedVitalityStat.base + detailedVitalityStat.objectsAndMountBonus + detailedVitalityStat.additional + detailedVitalityStat.alignGiftBonus) + detailedVitalityStat.contextModif;
         }
         else if(vitalityStat is HaxeStat)
         {
            effectiveVitality = vitalityStat.total;
         }
         return this.getCharacteristicValue(StatIds.LIFE_POINTS) + effectiveVitality - this.getCharacteristicValue(StatIds.CUR_PERMANENT_DAMAGE);
      }
   }
}
