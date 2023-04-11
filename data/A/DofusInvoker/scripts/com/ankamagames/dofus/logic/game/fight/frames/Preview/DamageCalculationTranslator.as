package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellBomb;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameContextBasicSpawnInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import damageCalculation.DamageCalculationInterface;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.fighterManagement.fighterstats.HaxeSimpleStat;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellState;
   import damageCalculation.tools.StatIds;
   
   public class DamageCalculationTranslator implements DamageCalculationInterface
   {
       
      
      public function DamageCalculationTranslator()
      {
         super();
      }
      
      public function createSpellFromId(spellId:uint, level:int) : HaxeSpell
      {
         var spell:Spell = Spell.getSpellById(spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(level);
         if(level != spellLevel.grade)
         {
            return null;
         }
         return DamagePreview.createHaxeSpell(spellLevel);
      }
      
      public function getBombCastOnFighterSpell(bombId:int, level:int) : HaxeSpell
      {
         var bombSpellId:int = SpellBomb.getSpellBombById(bombId).instantSpellId;
         var spellLevel:SpellLevel = Spell.getSpellById(bombSpellId).getSpellLevel(level);
         return DamagePreview.createHaxeSpell(spellLevel);
      }
      
      public function getLinkedExplosionSpellFromFighter(bomb:HaxeFighter) : HaxeSpell
      {
         var context:FightContextFrame = null;
         var infos:GameFightMonsterInformations = null;
         var spellId:int = 0;
         var spellLevel:SpellLevel = null;
         if(bomb.isBomb())
         {
            context = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(context == null)
            {
               return null;
            }
            infos = context.entitiesFrame.getEntityInfos(bomb.id) as GameFightMonsterInformations;
            if(infos == null)
            {
               return null;
            }
            spellId = SpellBomb.getSpellBombById(bomb.breed).chainReactionSpellId;
            spellLevel = Spell.getSpellById(spellId).spellLevelsInfo[infos.creatureGrade - 1];
            return DamagePreview.createHaxeSpell(spellLevel);
         }
         return null;
      }
      
      public function getBombExplosionSpellFromFighter(bomb:HaxeFighter) : HaxeSpell
      {
         var context:FightContextFrame = null;
         var infos:GameFightMonsterInformations = null;
         var spellId:int = 0;
         var spellLevel:SpellLevel = null;
         if(bomb != null && bomb.playerType == PlayerTypeEnum.MONSTER && bomb.data.isSummon())
         {
            context = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(context == null)
            {
               return null;
            }
            infos = context.entitiesFrame.getEntityInfos(bomb.id) as GameFightMonsterInformations;
            if(infos == null)
            {
               return null;
            }
            spellId = SpellBomb.getSpellBombById(bomb.breed).explodSpellId;
            spellLevel = Spell.getSpellById(spellId).spellLevelsInfo[infos.creatureGrade - 1];
            return DamagePreview.createHaxeSpell(spellLevel);
         }
         return null;
      }
      
      public function createStateFromId(stateId:uint) : HaxeSpellState
      {
         var effectId:int = 0;
         var state:SpellState = SpellState.getSpellStateById(stateId);
         var effects:Array = [];
         for each(effectId in state.effectsIds)
         {
            effects.push(effectId);
         }
         return new HaxeSpellState(stateId,effects);
      }
      
      public function summonMonster(caster:HaxeFighter, id:int, grade:int = -1) : HaxeFighter
      {
         var monsterGrade:MonsterGrade = null;
         var currentGrade:MonsterGrade = null;
         var infos:GameFightMonsterInformations = new GameFightMonsterInformations();
         infos.spawnInfo = new GameContextBasicSpawnInformation();
         infos.spawnInfo.alive = true;
         infos.spawnInfo.teamId = caster.teamId;
         infos.creatureGrade = grade;
         infos.creatureGenericId = id;
         infos.stats.summoned = true;
         infos.stats.summoner = caster.id;
         var fighter:HaxeFighter = new FighterTranslator(infos,EntitiesManager.getInstance().getFreeEntityId(),true);
         if(!fighter.level)
         {
            fighter.level = caster.level;
         }
         var monster:Monster = Monster.getMonsterById(id);
         if(monster !== null)
         {
            monsterGrade = null;
            for each(currentGrade in monster.grades)
            {
               if(currentGrade.grade === grade)
               {
                  monsterGrade = currentGrade;
                  break;
               }
            }
            switch(monsterGrade)
            {
               default:
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.LIFE_POINTS,monsterGrade.lifePoints));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.STRENGTH,monsterGrade.strength));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.INTELLIGENCE,monsterGrade.intelligence));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.CHANCE,monsterGrade.chance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.AGILITY,monsterGrade.agility));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.WISDOM,monsterGrade.wisdom));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.DODGE_PA_LOST_PROBABILITY,monsterGrade.paDodge));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.DODGE_PM_LOST_PROBABILITY,monsterGrade.pmDodge));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.EARTH_ELEMENT_RESIST_PERCENT,monsterGrade.earthResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.AIR_ELEMENT_RESIST_PERCENT,monsterGrade.airResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.FIRE_ELEMENT_RESIST_PERCENT,monsterGrade.fireResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.WATER_ELEMENT_RESIST_PERCENT,monsterGrade.waterResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.NEUTRAL_ELEMENT_RESIST_PERCENT,monsterGrade.neutralResistance));
                  break;
               case null:
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.LIFE_POINTS,monsterGrade.bonusCharacteristics.lifePoints));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.STRENGTH,monsterGrade.bonusCharacteristics.strength));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.INTELLIGENCE,monsterGrade.bonusCharacteristics.intelligence));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.CHANCE,monsterGrade.bonusCharacteristics.chance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.AGILITY,monsterGrade.bonusCharacteristics.agility));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.WISDOM,monsterGrade.bonusCharacteristics.wisdom));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.AIR_ELEMENT_RESIST_PERCENT,monsterGrade.bonusCharacteristics.airResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.FIRE_ELEMENT_RESIST_PERCENT,monsterGrade.bonusCharacteristics.fireResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.WATER_ELEMENT_RESIST_PERCENT,monsterGrade.bonusCharacteristics.waterResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.NEUTRAL_ELEMENT_RESIST_PERCENT,monsterGrade.bonusCharacteristics.neutralResistance));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.TACKLE_EVADE,monsterGrade.bonusCharacteristics.tackleEvade));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.TACKLE_BLOCK,monsterGrade.bonusCharacteristics.tackleBlock));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.EARTH_DAMAGE_BONUS,monsterGrade.bonusCharacteristics.bonusEarthDamage));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.FIRE_DAMAGE_BONUS,monsterGrade.bonusCharacteristics.bonusFireDamage));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.WATER_DAMAGE_BONUS,monsterGrade.bonusCharacteristics.bonusWaterDamage));
                  fighter.data.setStat(new HaxeSimpleStat(StatIds.AIR_DAMAGE_BONUS,monsterGrade.bonusCharacteristics.bonusAirDamage));
                  break;
               case null:
            }
         }
         return fighter;
      }
      
      public function getStartingSpell(fighter:HaxeFighter, grade:int = -1) : HaxeSpell
      {
         var monster:Monster = null;
         var currentMonsterGrade:MonsterGrade = null;
         var currentGrade:MonsterGrade = null;
         var spellLevel:SpellLevel = null;
         if(fighter.playerType == PlayerTypeEnum.MONSTER)
         {
            monster = Monster.getMonsterById(fighter.breed);
            if(monster)
            {
               for each(currentGrade in monster.grades)
               {
                  if(currentGrade.grade === grade)
                  {
                     currentMonsterGrade = currentGrade;
                     break;
                  }
               }
               spellLevel = SpellLevel.getLevelById(currentMonsterGrade.startingSpellId);
               if(spellLevel)
               {
                  return DamagePreview.createHaxeSpell(spellLevel);
               }
            }
         }
         return null;
      }
   }
}
