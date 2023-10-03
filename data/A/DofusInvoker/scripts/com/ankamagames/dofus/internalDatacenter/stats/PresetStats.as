package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.dofus.logic.common.managers.PresetStatsManager;
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public class PresetStats extends Stats implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PresetStats));
       
      
      private var _presetId:Uuid;
      
      public function PresetStats(presetId:Uuid)
      {
         super();
         this._presetId = presetId;
         _stats = new Dictionary();
      }
      
      public function get presetId() : Uuid
      {
         return this._presetId;
      }
      
      override protected function get isVerbose() : Boolean
      {
         return PresetStatsManager.getInstance().isVerbose;
      }
      
      override protected function getFormattedMessage(message:String) : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " (Preset ID: " + this._presetId.uuidString + "): " + message;
      }
      
      public function setStat(stat:PresetStat, isBulkUpdate:Boolean = true) : void
      {
         stat.presetId = this._presetId;
         _stats[stat.id.toString()] = stat;
         if(this.isVerbose)
         {
            _log.info("Set stat for preset with ID " + this._presetId.uuidString + ": " + stat.toString());
         }
         PresetStatsManager.getInstance().fireStatUpdate(stat,isBulkUpdate);
      }
      
      public function deleteStat(statId:Number, isBulkUpdate:Boolean = true) : void
      {
         if(!(statId in _stats))
         {
            return;
         }
         var statKey:String = statId.toString();
         var stat:PresetStat = _stats[statKey];
         stat.reset();
         PresetStatsManager.getInstance().fireStatUpdate(stat,isBulkUpdate);
         if(this.isVerbose)
         {
            _log.info("Deleted stat for preset with ID " + this.presetId.uuidString + ": " + stat.toString());
         }
         delete _stats[statKey];
      }
      
      public function resetStats() : void
      {
         var stat:PresetStat = null;
         var isCurLifeStatOnly:Boolean = _stats.length === 1 && StatIds.CUR_LIFE in _stats;
         for each(stat in _stats)
         {
            stat.reset();
            PresetStatsManager.getInstance().fireStatUpdate(stat,false);
         }
         if(this.isVerbose)
         {
            _log.info("Stats reset for preset with ID " + this.presetId.uuidString);
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
         var stat:PresetStat = _stats[key];
         if(stat is DetailedPresetStat)
         {
            return (stat as DetailedPresetStat).baseValue;
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
         var stat:PresetStat = _stats[key];
         if(stat is DetailedPresetStat)
         {
            return (stat as DetailedPresetStat).additionalValue;
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
         var stat:PresetStat = _stats[key];
         if(stat is DetailedPresetStat)
         {
            return (stat as DetailedPresetStat).objectsAndMountBonusValue;
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
         var stat:PresetStat = _stats[key];
         if(stat is DetailedPresetStat)
         {
            return (stat as DetailedPresetStat).alignGiftBonusValue;
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
         var stat:PresetStat = _stats[key];
         if(stat is DetailedPresetStat)
         {
            return (stat as DetailedPresetStat).contextModifValue;
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
         var stat:PresetStat = _stats[key];
         if(stat is UsablePresetStat)
         {
            return (stat as UsablePresetStat).usedValue;
         }
         return 0;
      }
      
      public function toString() : String
      {
         var statId:Number = NaN;
         var statsDump:String = "";
         var statIds:Vector.<Number> = new Vector.<Number>();
         var stat:PresetStat = null;
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
         var detailedVitalityStat:DetailedPresetStat = null;
         var vitalityStat:PresetStat = getStat(StatIds.VITALITY) as PresetStat;
         var effectiveVitality:Number = 0;
         if(vitalityStat is DetailedPresetStat)
         {
            detailedVitalityStat = vitalityStat as DetailedPresetStat;
            effectiveVitality = Math.max(0,detailedVitalityStat.baseValue + detailedVitalityStat.objectsAndMountBonusValue + detailedVitalityStat.additionalValue + detailedVitalityStat.alignGiftBonusValue) + detailedVitalityStat.contextModifValue;
         }
         else if(vitalityStat is PresetStat)
         {
            effectiveVitality = vitalityStat.totalValue;
         }
         return getStatTotalValue(StatIds.LIFE_POINTS) + effectiveVitality - getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE);
      }
   }
}
