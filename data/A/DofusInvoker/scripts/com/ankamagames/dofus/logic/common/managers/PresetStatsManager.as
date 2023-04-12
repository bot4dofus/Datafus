package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedPresetStat;
   import com.ankamagames.dofus.internalDatacenter.stats.PresetStat;
   import com.ankamagames.dofus.internalDatacenter.stats.PresetStats;
   import com.ankamagames.dofus.internalDatacenter.stats.UsablePresetStat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristic;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicValue;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterUsableCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.uuid;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class PresetStatsManager
   {
      
      private static var _singleton:PresetStatsManager = null;
      
      private static var _dataStoreType:DataStoreType = null;
      
      private static var DATA_STORE_CATEGORY:String = "ComputerModule_statsManager";
      
      private static var DATA_STORE_KEY_IS_VERBOSE:String = "statsManagerIsVerbose";
      
      private static var DEFAULT_IS_VERBOSE:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsManager));
       
      
      private var _presetStats:Dictionary;
      
      private var _isVerbose:Boolean;
      
      private var _statListeners:Dictionary;
      
      public function PresetStatsManager()
      {
         this._presetStats = new Dictionary();
         this._isVerbose = DEFAULT_IS_VERBOSE;
         this._statListeners = new Dictionary();
         super();
         _log.info("Instantiating stats manager");
         if(_dataStoreType === null)
         {
            _dataStoreType = new DataStoreType(DATA_STORE_CATEGORY,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
         var rawIsVerbose:* = StoreDataManager.getInstance().getData(_dataStoreType,DATA_STORE_KEY_IS_VERBOSE);
         this._isVerbose = rawIsVerbose is Boolean ? Boolean(rawIsVerbose) : Boolean(DEFAULT_IS_VERBOSE);
      }
      
      public static function getInstance() : PresetStatsManager
      {
         if(_singleton === null)
         {
            _singleton = new PresetStatsManager();
         }
         return _singleton;
      }
      
      public function get isVerbose() : Boolean
      {
         return this._isVerbose;
      }
      
      public function set isVerbose(isVerbose:Boolean) : void
      {
         if(this._isVerbose === isVerbose)
         {
            return;
         }
         this._isVerbose = isVerbose;
         StoreDataManager.getInstance().setData(_dataStoreType,DATA_STORE_KEY_IS_VERBOSE,this._isVerbose);
         var verboseAction:String = !!this._isVerbose ? "enabled" : "disabled";
         _log.info("Verbose mode has been " + verboseAction);
      }
      
      public function reset() : void
      {
         _singleton = null;
         _log.info("Singleton instance has been destroyed");
      }
      
      public function setStats(stats:PresetStats) : Boolean
      {
         if(stats === null)
         {
            _log.error("Tried to set null stats. Aborting");
            return false;
         }
         this._presetStats[stats.presetId.uuidString] = stats;
         return true;
      }
      
      public function getStats(presetId:uuid) : PresetStats
      {
         var key:String = presetId.uuidString;
         if(!(key in this._presetStats))
         {
            return null;
         }
         return this._presetStats[key];
      }
      
      public function addRawStats(presetId:uuid, rawStats:Vector.<CharacterCharacteristic>) : void
      {
         var rawStat:CharacterCharacteristic = null;
         var emoticonFrame:EmoticonFrame = null;
         var presetKey:String = presetId.uuidString;
         var presetStats:PresetStats = this._presetStats[presetKey];
         var isCurLifeStatOnly:Boolean = rawStats.length === 1 && rawStats[0] !== null && rawStats[0].characteristicId === StatIds.CUR_LIFE;
         if(presetStats === null)
         {
            presetStats = new PresetStats(presetId);
            this.setStats(presetStats);
         }
         var rawUsableStat:CharacterUsableCharacteristicDetailed = null;
         var rawDetailedStat:CharacterCharacteristicDetailed = null;
         var presetStat:PresetStat = null;
         for each(rawStat in rawStats)
         {
            if(rawStat is CharacterUsableCharacteristicDetailed)
            {
               rawUsableStat = rawStat as CharacterUsableCharacteristicDetailed;
               presetStat = new UsablePresetStat(rawUsableStat.characteristicId,rawUsableStat.base,rawUsableStat.additional,rawUsableStat.objectsAndMountBonus,rawUsableStat.alignGiftBonus,rawUsableStat.contextModif,rawUsableStat.used);
            }
            else if(rawStat is CharacterCharacteristicDetailed)
            {
               rawDetailedStat = rawStat as CharacterCharacteristicDetailed;
               presetStat = new DetailedPresetStat(rawDetailedStat.characteristicId,rawDetailedStat.base,rawDetailedStat.additional,rawDetailedStat.objectsAndMountBonus,rawDetailedStat.alignGiftBonus,rawDetailedStat.contextModif);
            }
            else
            {
               if(!(rawStat is CharacterCharacteristicValue))
               {
                  continue;
               }
               presetStat = new PresetStat(rawStat.characteristicId,(rawStat as CharacterCharacteristicValue).total);
            }
            emoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            if(presetStat.id === StatIds.CUR_LIFE && emoticonFrame !== null && emoticonFrame.isHpRegen)
            {
               if(presetStat is DetailedPresetStat)
               {
                  emoticonFrame.updateHpStartRegenValue((presetStat as DetailedPresetStat).baseValue);
               }
               else if(presetStat is PresetStat)
               {
                  emoticonFrame.updateHpStartRegenValue(presetStat.totalValue);
               }
            }
            presetStats.setStat(presetStat,false);
         }
      }
      
      public function deleteStats(presetId:uuid) : Boolean
      {
         var presetKey:String = presetId.uuidString;
         if(!(presetKey in this._presetStats))
         {
            _log.error("Tried to delete stats for preset with ID " + presetKey + ", but none were found. Aborting");
            return false;
         }
         delete this._presetStats[presetKey];
         _log.info("Stats for preset with ID " + presetKey + " deleted");
         return true;
      }
      
      private function isStatHasListener(statId:Number, listener:Function) : Boolean
      {
         return this.getFeatureListenerIndex(statId,listener) !== -1;
      }
      
      private function getFeatureListenerIndex(statId:Number, listener:Function) : Number
      {
         var key:String = statId.toString();
         var listeners:Vector.<Function> = this._statListeners[key];
         if(listeners === null)
         {
            return -1;
         }
         if(listeners.length <= 0)
         {
            delete this._statListeners[key];
            return -1;
         }
         return listeners.indexOf(listener);
      }
      
      public function addListenerToStat(statId:Number, listener:Function) : Boolean
      {
         if(listener === null)
         {
            _log.error("Listener provided is null");
            return false;
         }
         var isListenerAdded:Boolean = false;
         var key:String = statId.toString();
         if(!this.isStatHasListener(statId,listener))
         {
            if(!this._statListeners[key])
            {
               this._statListeners[key] = new Vector.<Function>();
            }
            this._statListeners[key].push(listener);
            isListenerAdded = true;
         }
         if(isListenerAdded)
         {
            _log.info("Listener " + listener.prototype + " added to stat with ID " + key);
         }
         else
         {
            _log.error("Listener " + listener.prototype + " could NOT added to stat with ID " + key);
         }
         return isListenerAdded;
      }
      
      public function removeListenerFromStat(statId:Number, listener:Function) : Boolean
      {
         var listenerIndex:Number = NaN;
         var key:String = statId.toString();
         var isListenerRemoved:Boolean = false;
         var listeners:Vector.<Function> = this._statListeners[key];
         if(listenerIndex !== -1)
         {
            listenerIndex = this.getFeatureListenerIndex(statId,listener);
            if(listenerIndex !== -1)
            {
               listeners.splice(listenerIndex,1);
               if(listeners.length <= 0)
               {
                  listeners = null;
               }
            }
         }
         if(isListenerRemoved)
         {
            _log.info("Listener " + listener.prototype + " removed from stat with ID " + key);
         }
         else
         {
            _log.error("Listener " + listener.prototype + " could NOT be removed from stat with ID " + key);
         }
         return isListenerRemoved;
      }
      
      public function fireStatUpdate(stat:PresetStat, isBulkUpdate:Boolean = true) : void
      {
         var listeners:Vector.<Function> = this._statListeners[stat.id];
         if(listeners === null)
         {
            return;
         }
         var currentListener:Function = null;
         var index:uint = 0;
         while(index < listeners.length)
         {
            currentListener = listeners[index];
            currentListener.call(null,stat);
            index++;
         }
      }
   }
}
