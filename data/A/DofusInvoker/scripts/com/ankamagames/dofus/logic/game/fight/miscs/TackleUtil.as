package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import damageCalculation.tools.StatIds;
   import mapTools.MapTools;
   
   public class TackleUtil
   {
       
      
      public function TackleUtil()
      {
         super();
      }
      
      public static function getTackle(playerInfos:GameFightFighterInformations, position:MapPoint) : Number
      {
         var x:int = 0;
         var y:int = 0;
         var tackleEvadeStat:EntityStat = null;
         var evade:int = 0;
         var entities:Array = null;
         var evadePercent:Number = NaN;
         var entity:IEntity = null;
         var infos:GameFightFighterInformations = null;
         var tacklerStats:EntityStats = null;
         var tackle:Number = NaN;
         var mod:Number = NaN;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var stats:EntityStats = StatsManager.getInstance().getStats(playerInfos.contextualId);
         if(Constants.DETERMINIST_TACKLE)
         {
            if(!canBeTackled(playerInfos,position))
            {
               return 1;
            }
            x = position.x;
            y = position.y;
            tackleEvadeStat = stats.getStat(StatIds.TACKLE_EVADE) as EntityStat;
            evade = tackleEvadeStat !== null ? int(tackleEvadeStat.totalValue) : 0;
            if(evade < 0)
            {
               evade = 0;
            }
            entities = new Array();
            if(MapPoint.isInMap(x - 1,y))
            {
               entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x - 1,y)));
            }
            if(MapPoint.isInMap(x + 1,y))
            {
               entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x + 1,y)));
            }
            if(MapPoint.isInMap(x,y - 1))
            {
               entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x,y - 1)));
            }
            if(MapPoint.isInMap(x,y + 1))
            {
               entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x,y + 1)));
            }
            evadePercent = 1;
            for each(entity in entities)
            {
               if(entity)
               {
                  infos = entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
                  if(canBeTackler(infos,playerInfos))
                  {
                     tacklerStats = StatsManager.getInstance().getStats(entity.id);
                     tackle = tacklerStats !== null ? Number(tacklerStats.getStatTotalValue(StatIds.TACKLE_BLOCK)) : Number(0);
                     if(tackle < 0)
                     {
                        tackle = 0;
                     }
                     mod = (evade + 2) / (tackle + 2) / 2;
                     if(mod < 1)
                     {
                        evadePercent *= mod;
                     }
                  }
               }
            }
            return evadePercent;
         }
         return 1;
      }
      
      public static function getTackleForFighter(tackler:GameFightFighterInformations, tackled:GameFightFighterInformations) : Number
      {
         if(!Constants.DETERMINIST_TACKLE)
         {
            return 1;
         }
         if(!canBeTackled(tackled))
         {
            return 1;
         }
         if(!canBeTackler(tackler,tackled))
         {
            return 1;
         }
         var tackledStats:EntityStats = StatsManager.getInstance().getStats(tackled.contextualId);
         var evade:int = tackledStats !== null ? int(tackledStats.getStatTotalValue(StatIds.TACKLE_EVADE)) : 0;
         if(evade < 0)
         {
            evade = 0;
         }
         var tacklerStats:EntityStats = StatsManager.getInstance().getStats(tackler.contextualId);
         var tackle:int = tacklerStats !== null ? int(tacklerStats.getStatTotalValue(StatIds.TACKLE_BLOCK)) : 0;
         if(tackle < 0)
         {
            tackle = 0;
         }
         return (evade + 2) / (tackle + 2) / 2;
      }
      
      public static function getTacklerOnCell(cellId:int) : AnimatedCharacter
      {
         var entity:AnimatedCharacter = null;
         var infos:GameFightFighterInformations = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId,AnimatedCharacter);
         for each(entity in entities)
         {
            infos = entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
            if(infos && infos.disposition is FightEntityDispositionInformations)
            {
               if(!FightersStateManager.getInstance().hasState(entity.id,DataEnum.SPELL_STATE_CARRIED))
               {
                  return entity;
               }
            }
         }
         return null;
      }
      
      public static function canBeTackled(fighter:GameFightFighterInformations, position:MapPoint = null) : Boolean
      {
         var fedi:FightEntityDispositionInformations = null;
         if(FightersStateManager.getInstance().hasState(fighter.contextualId,DataEnum.SPELL_STATE_CANT_BE_LOCKED) || FightersStateManager.getInstance().hasState(fighter.contextualId,DataEnum.SPELL_STATE_ROOTED) || fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED || FightersStateManager.getInstance().getStatus(fighter.contextualId).cantBeTackled)
         {
            return false;
         }
         if(fighter.disposition is FightEntityDispositionInformations)
         {
            fedi = fighter.disposition as FightEntityDispositionInformations;
            if(fedi.carryingCharacterId && (!position || fighter.disposition.cellId == position.cellId))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function canBeTackler(fighter:GameFightFighterInformations, target:GameFightFighterInformations) : Boolean
      {
         var monster:Monster = null;
         if(FightersStateManager.getInstance().hasState(fighter.contextualId,DataEnum.SPELL_STATE_CARRIED) || FightersStateManager.getInstance().hasState(fighter.contextualId,DataEnum.SPELL_STATE_ROOTED) || FightersStateManager.getInstance().hasState(fighter.contextualId,DataEnum.SPELL_STATE_CANT_LOCK) || fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED || FightersStateManager.getInstance().getStatus(fighter.contextualId).cantTackle)
         {
            return false;
         }
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var infos:GameFightFighterInformations = entitiesFrame.getEntityInfos(fighter.contextualId) as GameFightFighterInformations;
         if(infos && infos.spawnInfo.teamId == target.spawnInfo.teamId)
         {
            return false;
         }
         if(fighter is GameFightMonsterInformations)
         {
            monster = Monster.getMonsterById((fighter as GameFightMonsterInformations).creatureGenericId);
            if(!monster.canTackle)
            {
               return false;
            }
         }
         return fighter.spawnInfo.alive;
      }
      
      public static function isTackling(pPlayer:GameFightFighterInformations, pTackler:GameFightFighterInformations, pPlayerPath:MovementPath) : Boolean
      {
         var pe:PathElement = null;
         var x:int = 0;
         var y:int = 0;
         var playerEvasion:int = 0;
         var tacklerBlock:int = 0;
         var i:int = 0;
         var j:int = 0;
         var ac:AnimatedCharacter = null;
         var tackling:Boolean = false;
         var stats:EntityStats = StatsManager.getInstance().getStats(pPlayer.contextualId);
         var tackleEvadeStat:EntityStat = stats.getStat(StatIds.TACKLE_EVADE) as EntityStat;
         var evade:int = tackleEvadeStat !== null ? int(tackleEvadeStat.totalValue) : 0;
         var tackleBlockStat:EntityStat = stats.getStat(StatIds.TACKLE_BLOCK) as EntityStat;
         var block:int = tackleBlockStat !== null ? int(tackleBlockStat.totalValue) : 0;
         if(pPlayerPath && canBeTackler(pTackler,pPlayer))
         {
            for each(pe in pPlayerPath.path)
            {
               if(canBeTackled(pPlayer,pe.step))
               {
                  x = pe.step.x;
                  y = pe.step.y;
                  for(i = x - 1; i <= x + 1; i++)
                  {
                     for(j = y - 1; j <= y + 1; j++)
                     {
                        ac = getTacklerOnCell(MapTools.getCellIdByCoord(i,j));
                        if(ac && ac.id == pTackler.contextualId)
                        {
                           playerEvasion = evade < 0 ? 0 : int(evade);
                           tacklerBlock = block < 0 ? 0 : int(block);
                           return (playerEvasion + 2) / (tacklerBlock + 2) / 2 < 1;
                        }
                     }
                  }
               }
            }
         }
         return tackling;
      }
   }
}
