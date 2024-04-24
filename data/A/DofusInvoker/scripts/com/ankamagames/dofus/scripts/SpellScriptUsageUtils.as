package com.ankamagames.dofus.scripts
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterionFactory;
   import com.ankamagames.dofus.datacenter.spells.BoundScriptUsageData;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.DisplayZone;
   import flash.utils.Dictionary;
   
   public class SpellScriptUsageUtils
   {
       
      
      public function SpellScriptUsageUtils()
      {
         super();
      }
      
      public static function isSpellLevelMatch(spell:SpellWrapper, spellLevels:Vector.<uint>) : Boolean
      {
         return spellLevels === null || spellLevels.length === 0 || spellLevels.indexOf(spell.spellLevel) !== -1;
      }
      
      public static function isCriterionMatch(rawCriterion:String) : Boolean
      {
         if(!rawCriterion)
         {
            return true;
         }
         var criterion:ItemCriterion = ItemCriterionFactory.create(rawCriterion);
         return criterion !== null && criterion.isRespected;
      }
      
      public static function isCasterMatch(casterId:Number, casterMask:String) : Boolean
      {
         if(!casterMask)
         {
            return true;
         }
         var relatedEffect:EffectInstance = new EffectInstance();
         relatedEffect.targetMask = casterMask;
         var casterPos:int = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getLastKnownEntityPosition(casterId);
         return DamageUtil.verifySpellEffectMask(casterId,casterId,relatedEffect,casterPos);
      }
      
      public static function generateScriptZone(targetZone:DisplayZone, activationZone:DisplayZone, casterId:Number, targetedCellId:int, activationMask:String, entityIds:Vector.<Number>) : Custom
      {
         var targetCellIds:Vector.<uint> = null;
         var targetCellId:uint = 0;
         var entityId:Number = NaN;
         var activationZoneCellId:int = 0;
         var entityInfo:GameContextActorInformations = null;
         var entityPos:int = 0;
         var cellIds:Vector.<uint> = new Vector.<uint>();
         if(!activationMask)
         {
            for each(activationZoneCellId in activationZone.getCells(targetedCellId))
            {
               targetCellIds = targetZone.getCells(activationZoneCellId);
               for each(targetCellId in targetCellIds)
               {
                  cellIds.push(targetCellId);
               }
            }
            return new Custom(cellIds);
         }
         var activationEffect:EffectInstance = new EffectInstance();
         activationEffect.targetMask = activationMask;
         activationEffect.zoneShape = targetZone.shape;
         activationEffect.zoneSize = targetZone.size;
         activationEffect.zoneMinSize = targetZone.otherSize;
         var activationZoneCellIds:Vector.<uint> = activationZone.getCells(targetedCellId);
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         for each(entityId in entityIds)
         {
            entityInfo = fightEntitiesFrame.getEntityInfos(entityId);
            entityPos = entityInfo.disposition.cellId;
            if(activationZoneCellIds.indexOf(entityPos) !== -1)
            {
               if(DamageUtil.verifySpellEffectMask(casterId,entityId,activationEffect,entityPos))
               {
                  targetCellIds = targetZone.getCells(entityPos);
                  for each(targetCellId in targetCellIds)
                  {
                     cellIds.push(targetCellId);
                  }
               }
            }
         }
         return new Custom(cellIds);
      }
      
      public static function isTargetMatch(scriptZone:Custom, casterId:Number, entityInfo:GameFightFighterInformations, targetEffect:EffectInstance) : Boolean
      {
         var entityCellId:int = entityInfo.disposition.cellId;
         if(targetEffect.targetMask && (casterId !== entityInfo.contextualId || targetEffect.targetMask.indexOf("C") === -1))
         {
            if(scriptZone.getCells().indexOf(entityCellId) === -1)
            {
               return false;
            }
         }
         return entityInfo.spawnInfo.alive && DamageUtil.verifySpellEffectMask(casterId,entityInfo.contextualId,targetEffect,entityCellId);
      }
      
      public static function getRandomizedUsageData(allUsageData:Vector.<BoundScriptUsageData>) : Vector.<BoundScriptUsageData>
      {
         var usageData:BoundScriptUsageData = null;
         var randomValue:Number = NaN;
         var selectedGroup:int = 0;
         var groupKey:* = null;
         var filteredUsageData:Vector.<BoundScriptUsageData> = null;
         var group:int = 0;
         var weight:int = 0;
         var weights:Dictionary = new Dictionary();
         var totalWeight:int = 0;
         for each(usageData in allUsageData)
         {
            if(usageData.randomGroup > 0)
            {
               weights[usageData.randomGroup] += weights.GetValueOrDefault(usageData.randomGroup) + usageData.random;
               totalWeight += usageData.random;
            }
         }
         randomValue = Math.random() * totalWeight;
         selectedGroup = -1;
         for(groupKey in weights)
         {
            group = Number(groupKey);
            weight = weights[group];
            if(randomValue < weight)
            {
               selectedGroup = group;
               break;
            }
            randomValue -= weight;
         }
         filteredUsageData = new Vector.<BoundScriptUsageData>();
         for each(usageData in allUsageData)
         {
            if(!(usageData.randomGroup > 0 && usageData.randomGroup != selectedGroup))
            {
               filteredUsageData.push(usageData);
            }
         }
         return filteredUsageData;
      }
   }
}
