package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.internalDatacenter.stats.UsableStat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristic;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicValue;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterUsableCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class StatsManager
   {
      
      private static var _singleton:StatsManager = null;
      
      private static var _dataStoreType:DataStoreType = null;
      
      private static var DATA_STORE_CATEGORY:String = "ComputerModule_statsManager";
      
      private static var DATA_STORE_KEY_IS_VERBOSE:String = "statsManagerIsVerbose";
      
      private static var DEFAULT_IS_VERBOSE:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsManager));
       
      
      private var _entityStats:Dictionary;
      
      private var _isVerbose:Boolean;
      
      private var _statListeners:Dictionary;
      
      public function StatsManager()
      {
         this._entityStats = new Dictionary();
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
      
      public static function getInstance() : StatsManager
      {
         if(_singleton === null)
         {
            _singleton = new StatsManager();
         }
         return _singleton;
      }
      
      public static function fireStatBulkUpdate(playerId:Number, isCurLifeStatOnly:Boolean) : void
      {
         var fightContextFrame:FightContextFrame = null;
         if(playerId === CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList,isCurLifeStatOnly);
         }
         if(PlayedCharacterManager.getInstance().isSpectator && OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo"))
         {
            fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(fightContextFrame !== null && fightContextFrame.battleFrame !== null && fightContextFrame.battleFrame.currentPlayerId === playerId)
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,FightEntitiesFrame.getCurrentInstance().getEntityInfos(fightContextFrame.battleFrame.currentPlayerId) as GameFightFighterInformations);
            }
         }
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
      
      public function setStats(stats:EntityStats) : Boolean
      {
         if(stats === null)
         {
            _log.error("Tried to set null stats. Aborting");
            return false;
         }
         this._entityStats[stats.entityId.toString()] = stats;
         return true;
      }
      
      public function getStats(entityId:Number) : EntityStats
      {
         var key:String = entityId.toString();
         if(!(key in this._entityStats))
         {
            return null;
         }
         return this._entityStats[key];
      }
      
      public function addRawStats(entityId:Number, rawStats:Vector.<CharacterCharacteristic>) : void
      {
         var rawStat:CharacterCharacteristic = null;
         var emoticonFrame:EmoticonFrame = null;
         var entityKey:String = entityId.toString();
         var entityStats:EntityStats = this._entityStats[entityKey];
         var isCurLifeStatOnly:Boolean = rawStats.length === 1 && rawStats[0] !== null && rawStats[0].characteristicId === StatIds.CUR_LIFE;
         if(entityStats === null)
         {
            entityStats = new EntityStats(entityId);
            this.setStats(entityStats);
         }
         var rawUsableStat:CharacterUsableCharacteristicDetailed = null;
         var rawDetailedStat:CharacterCharacteristicDetailed = null;
         var entityStat:Stat = null;
         for each(rawStat in rawStats)
         {
            if(rawStat is CharacterUsableCharacteristicDetailed)
            {
               rawUsableStat = rawStat as CharacterUsableCharacteristicDetailed;
               entityStat = new UsableStat(rawUsableStat.characteristicId,rawUsableStat.base,rawUsableStat.additional,rawUsableStat.objectsAndMountBonus,rawUsableStat.alignGiftBonus,rawUsableStat.contextModif,rawUsableStat.used);
            }
            else if(rawStat is CharacterCharacteristicDetailed)
            {
               rawDetailedStat = rawStat as CharacterCharacteristicDetailed;
               entityStat = new DetailedStat(rawDetailedStat.characteristicId,rawDetailedStat.base,rawDetailedStat.additional,rawDetailedStat.objectsAndMountBonus,rawDetailedStat.alignGiftBonus,rawDetailedStat.contextModif);
            }
            else
            {
               if(!(rawStat is CharacterCharacteristicValue))
               {
                  continue;
               }
               entityStat = new Stat(rawStat.characteristicId,(rawStat as CharacterCharacteristicValue).total);
            }
            emoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            if(entityStat.id === StatIds.CUR_LIFE && emoticonFrame !== null && emoticonFrame.isHpRegen)
            {
               if(entityStat is DetailedStat)
               {
                  emoticonFrame.updateHpStartRegenValue((entityStat as DetailedStat).baseValue);
               }
               else if(entityStat is Stat)
               {
                  emoticonFrame.updateHpStartRegenValue(entityStat.totalValue);
               }
            }
            entityStats.setStat(entityStat,false);
         }
         fireStatBulkUpdate(entityId,isCurLifeStatOnly);
      }
      
      public function deleteStats(entityId:Number) : Boolean
      {
         var entityKey:String = entityId.toString();
         if(!(entityKey in this._entityStats))
         {
            _log.error("Tried to delete stats for entity with ID " + entityKey + ", but none were found. Aborting");
            return false;
         }
         delete this._entityStats[entityKey];
         _log.info("Stats for entity with ID " + entityKey + " deleted");
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
      
      public function fireStatUpdate(stat:Stat, isBulkUpdate:Boolean = true) : void
      {
         if(isBulkUpdate)
         {
            fireStatBulkUpdate(stat.id,stat.id === StatIds.CUR_LIFE);
         }
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
