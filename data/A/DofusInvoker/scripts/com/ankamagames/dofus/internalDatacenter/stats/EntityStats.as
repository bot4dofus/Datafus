package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public class EntityStats extends Stats implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityStats));
       
      
      private var _entityId:Number = NaN;
      
      public function EntityStats(entityId:Number)
      {
         super();
         this._entityId = entityId;
         _stats = new Dictionary();
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      override protected function get isVerbose() : Boolean
      {
         return StatsManager.getInstance().isVerbose;
      }
      
      override protected function getFormattedMessage(message:String) : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " (Entity ID: " + this._entityId.toString() + "): " + message;
      }
      
      public function setStat(stat:EntityStat, isBulkUpdate:Boolean = true) : void
      {
         stat.entityId = this._entityId;
         _stats[stat.id.toString()] = stat;
         if(this.isVerbose)
         {
            _log.info("Set stat for entity with ID " + this.entityId.toString() + ": " + stat.toString());
         }
         StatsManager.getInstance().fireStatUpdate(stat,isBulkUpdate);
      }
      
      public function deleteStat(statId:Number, isBulkUpdate:Boolean = true) : void
      {
         if(!(statId in _stats))
         {
            return;
         }
         var statKey:String = statId.toString();
         var stat:EntityStat = _stats[statKey];
         stat.reset();
         StatsManager.getInstance().fireStatUpdate(stat,isBulkUpdate);
         if(this.isVerbose)
         {
            _log.info("Deleted stat for entity with ID " + this.entityId.toString() + ": " + stat.toString());
         }
         delete _stats[statKey];
      }
      
      public function resetStats() : void
      {
         var stat:EntityStat = null;
         var isCurLifeStatOnly:Boolean = _stats.length === 1 && StatIds.CUR_LIFE in _stats;
         for each(stat in _stats)
         {
            stat.reset();
            StatsManager.getInstance().fireStatUpdate(stat,false);
         }
         StatsManager.fireStatBulkUpdate(this._entityId,isCurLifeStatOnly);
         if(this.isVerbose)
         {
            _log.info("Stats reset for entity with ID " + this.entityId.toString());
         }
         _stats = new Dictionary();
      }
      
      public function getStatBaseValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is DetailedStat)
         {
            return (stat as DetailedStat).baseValue;
         }
         return 0;
      }
      
      override public function getStatAdditionalValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is DetailedStat)
         {
            return (stat as DetailedStat).additionalValue;
         }
         return 0;
      }
      
      override public function getStatObjectsAndMountBonusValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is DetailedStat)
         {
            return (stat as DetailedStat).objectsAndMountBonusValue;
         }
         return 0;
      }
      
      override public function getStatAlignGiftBonusValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is DetailedStat)
         {
            return (stat as DetailedStat).alignGiftBonusValue;
         }
         return 0;
      }
      
      override public function getStatContextModifValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is DetailedStat)
         {
            return (stat as DetailedStat).contextModifValue;
         }
         return 0;
      }
      
      override public function getStatUsedValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in _stats))
         {
            return 0;
         }
         var stat:EntityStat = _stats[key];
         if(stat is UsableStat)
         {
            return (stat as UsableStat).usedValue;
         }
         return 0;
      }
      
      public function toString() : String
      {
         var statId:Number = NaN;
         var statsDump:String = "";
         var statIds:Vector.<Number> = new Vector.<Number>();
         var stat:EntityStat = null;
         for each(stat in _stats)
         {
            statIds.push(stat.id);
         }
         statIds.sort(Array.NUMERIC);
         for each(statId in statIds)
         {
            stat = _stats[statId.toString()];
            statsDump += "\n\t" + stat.toString();
         }
         if(!statsDump)
         {
            statsDump = "\n\tNo stats to display.";
         }
         return this.getFormattedMessage(statsDump);
      }
      
      public function getHealthPoints() : Number
      {
         return this.getMaxHealthPoints() + getStatTotalValue(StatIds.CUR_LIFE) + getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE);
      }
      
      public function getMaxHealthPoints() : Number
      {
         var detailedVitalityStat:DetailedStat = null;
         var vitalityStat:EntityStat = getStat(StatIds.VITALITY) as EntityStat;
         var effectiveVitality:Number = 0;
         if(vitalityStat is DetailedStat)
         {
            detailedVitalityStat = vitalityStat as DetailedStat;
            effectiveVitality = Math.max(0,detailedVitalityStat.baseValue + detailedVitalityStat.objectsAndMountBonusValue + detailedVitalityStat.additionalValue + detailedVitalityStat.alignGiftBonusValue) + detailedVitalityStat.contextModifValue;
         }
         else if(vitalityStat is EntityStat)
         {
            effectiveVitality = vitalityStat.totalValue;
         }
         return getStatTotalValue(StatIds.LIFE_POINTS) + effectiveVitality - getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE);
      }
   }
}
