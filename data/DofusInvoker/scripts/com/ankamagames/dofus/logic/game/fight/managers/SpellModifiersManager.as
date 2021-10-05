package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifier;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SpellModifiersManager
   {
      
      private static var _singleton:SpellModifiersManager = null;
      
      private static var _dataStoreType:DataStoreType = null;
      
      private static var DATA_STORE_CATEGORY:String = "ComputerModule_spellModifiersManager";
      
      private static var DATA_STORE_KEY_IS_VERBOSE:String = "spellModifiersManagerIsVerbose";
      
      private static var DEFAULT_IS_VERBOSE:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellModifiersManager));
       
      
      private var _entitiesMap:Dictionary;
      
      private var _isVerbose:Boolean;
      
      public function SpellModifiersManager()
      {
         this._entitiesMap = new Dictionary();
         this._isVerbose = DEFAULT_IS_VERBOSE;
         super();
         _log.info("Instantiating spells manager");
         if(_dataStoreType === null)
         {
            _dataStoreType = new DataStoreType(DATA_STORE_CATEGORY,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
         var rawIsVerbose:* = StoreDataManager.getInstance().getData(_dataStoreType,DATA_STORE_KEY_IS_VERBOSE);
         this._isVerbose = rawIsVerbose is Boolean ? Boolean(rawIsVerbose) : Boolean(DEFAULT_IS_VERBOSE);
      }
      
      public static function getInstance() : SpellModifiersManager
      {
         if(_singleton === null)
         {
            _singleton = new SpellModifiersManager();
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
      
      public function setSpellModifiers(spellModifiers:SpellModifiers) : Boolean
      {
         var spellsModifierStats:Dictionary = null;
         if(spellModifiers === null)
         {
            _log.error("Tried to set null spell modifier stats. Aborting");
            return false;
         }
         var entityKey:String = spellModifiers.entityId.toString();
         var spellKey:String = spellModifiers.spellId.toString();
         if(!(entityKey in this._entitiesMap))
         {
            spellsModifierStats = this._entitiesMap[entityKey] = new Dictionary();
         }
         else
         {
            spellsModifierStats = this._entitiesMap[entityKey];
         }
         spellsModifierStats[spellKey] = spellModifiers;
         return true;
      }
      
      public function getSpellModifiers(entityId:Number, spellId:Number) : SpellModifiers
      {
         var entityKey:String = entityId.toString();
         if(!(entityKey in this._entitiesMap))
         {
            return null;
         }
         var spellsModifierStats:Dictionary = this._entitiesMap[entityKey];
         var spellKey:String = spellId.toString();
         if(spellsModifierStats === null || !(spellKey in spellsModifierStats))
         {
            return null;
         }
         return spellsModifierStats[spellKey];
      }
      
      public function getSpellModifier(entityId:Number, spellId:Number, modifierId:Number) : SpellModifier
      {
         var spellModifiers:SpellModifiers = this.getSpellModifiers(entityId,spellId);
         if(spellModifiers !== null)
         {
            return spellModifiers.getModifier(modifierId);
         }
         return null;
      }
      
      public function setRawSpellsModifiers(entityId:Number, rawSpellsModifiers:Vector.<CharacterSpellModification>) : void
      {
         var spellModifiers:SpellModifiers = null;
         var spellModifier:SpellModifier = null;
         var rawSpellModifier:CharacterSpellModification = null;
         var entityKey:String = entityId.toString();
         var spellsModifierStats:Dictionary = this._entitiesMap[entityKey] = new Dictionary();
         if(rawSpellsModifiers !== null && rawSpellsModifiers.length > 0)
         {
            spellModifier = null;
            for each(rawSpellModifier in rawSpellsModifiers)
            {
               spellModifiers = spellsModifierStats[rawSpellModifier.spellId.toString()];
               if(spellModifiers === null)
               {
                  spellModifiers = new SpellModifiers(entityId,rawSpellModifier.spellId);
                  this.setSpellModifiers(spellModifiers);
               }
               spellModifier = new SpellModifier(rawSpellModifier.modificationType,rawSpellModifier.value.base,rawSpellModifier.value.additional,rawSpellModifier.value.objectsAndMountBonus,rawSpellModifier.value.alignGiftBonus,rawSpellModifier.value.contextModif);
               spellModifiers.setModifier(spellModifier);
            }
         }
      }
      
      public function setRawSpellModifier(entityId:Number, rawSpellModifier:CharacterSpellModification) : void
      {
         if(rawSpellModifier === null)
         {
            return;
         }
         var entityKey:String = entityId.toString();
         var spellsModifierStats:Dictionary = this._entitiesMap[entityKey];
         if(spellsModifierStats === null)
         {
            spellsModifierStats = this._entitiesMap[entityKey] = new Dictionary();
         }
         var spellKey:String = rawSpellModifier.spellId.toString();
         var spellModifiers:SpellModifiers = spellsModifierStats[spellKey];
         if(spellModifiers === null)
         {
            spellModifiers = spellsModifierStats[spellKey] = new SpellModifiers(entityId,rawSpellModifier.spellId);
         }
         var spellModifier:SpellModifier = new SpellModifier(rawSpellModifier.modificationType,rawSpellModifier.value.base,rawSpellModifier.value.additional,rawSpellModifier.value.objectsAndMountBonus,rawSpellModifier.value.alignGiftBonus,rawSpellModifier.value.contextModif);
         spellModifiers.setModifier(spellModifier);
      }
      
      public function deleteSpellsModifiers(entityId:Number) : Boolean
      {
         var key:String = entityId.toString();
         if(!(key in this._entitiesMap))
         {
            _log.error("Tried to delete spells modifier stats for entity with ID " + key + ", but none were found. Aborting");
            return false;
         }
         delete this._entitiesMap[key];
         _log.info("Spells modifiers for entity with ID " + key + " deleted");
         return true;
      }
      
      public function deleteSpellModifiers(entityId:Number, spellId:Number) : Boolean
      {
         var entityKey:String = entityId.toString();
         var spellKey:String = spellId.toString();
         if(!(entityKey in this._entitiesMap))
         {
            _log.error("Tried to delete spell " + spellKey + " modifiers for entity with ID " + entityKey + ", but no spells modifier stats were found. Aborting");
            return false;
         }
         var spellModifiers:SpellModifiers = this._entitiesMap[entityKey];
         if(!spellModifiers || !(spellKey in spellModifiers))
         {
            _log.error("Tried to delete spell " + spellKey + " modifiers for entity with ID " + entityKey + ", but none were found. Aborting");
            return false;
         }
         delete spellModifiers[spellKey];
         _log.info("Spell " + spellKey + " modifiers for entity with ID " + entityKey + " deleted");
         return true;
      }
      
      public function destroy() : void
      {
         _singleton = null;
      }
   }
}
