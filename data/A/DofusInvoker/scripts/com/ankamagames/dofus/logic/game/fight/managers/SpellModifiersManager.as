package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifier;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifierValueTypeEnum;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.network.enums.SpellModifierActionTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.spellmodifier.SpellModifierMessage;
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
      
      public function getSpellsModifiers(entityId:Number) : Dictionary
      {
         var entityKey:String = entityId.toString();
         if(!(entityKey in this._entitiesMap))
         {
            return null;
         }
         return this._entitiesMap[entityKey];
      }
      
      public function getSpellModifiers(entityId:Number, spellId:Number) : SpellModifiers
      {
         var spellsModifierStats:Dictionary = this.getSpellsModifiers(entityId);
         var spellKey:String = spellId.toString();
         if(spellsModifierStats === null || !(spellKey in spellsModifierStats))
         {
            return null;
         }
         return spellsModifierStats[spellKey];
      }
      
      public function setRawSpellsModifiers(entityId:Number, rawSpellsModifiers:Vector.<SpellModifierMessage>) : void
      {
         var rawSpellModifier:SpellModifierMessage = null;
         var entityKey:String = entityId.toString();
         var spellsModifierStats:Dictionary = this._entitiesMap[entityKey] = new Dictionary();
         if(rawSpellsModifiers !== null && rawSpellsModifiers.length > 0)
         {
            for each(rawSpellModifier in rawSpellsModifiers)
            {
               this.internalSetRawSpellModifier(entityId,rawSpellModifier,spellsModifierStats);
            }
         }
      }
      
      public function setRawSpellModifier(entityId:Number, rawSpellModifier:SpellModifierMessage) : void
      {
         if(rawSpellModifier === null)
         {
            _log.error("Tried to set a null raw spell modifier. Ignoring");
            return;
         }
         var entityKey:String = entityId.toString();
         var spellsModifierStats:Dictionary = this._entitiesMap[entityKey];
         if(spellsModifierStats === null)
         {
            spellsModifierStats = this._entitiesMap[entityKey] = new Dictionary();
         }
         this.internalSetRawSpellModifier(entityId,rawSpellModifier,spellsModifierStats);
      }
      
      public function deleteSpellModifierAction(entityId:Number, spellId:Number, modifierType:int, actionType:int) : void
      {
         var spellModifiers:SpellModifiers = this.getSpellModifiers(entityId,spellId);
         if(spellModifiers === null)
         {
            _log.error("Tried to delete spell " + spellId + " modifier " + modifierType + " (action: " + actionType + ")  for entity with ID " + entityId + ", but no spells modifier stats were found. Aborting");
            return;
         }
         spellModifiers.deleteModifierAction(modifierType,actionType);
      }
      
      public function getModifiedBool(entityId:Number, spellId:Number, modifierType:int, baseValue:Boolean = false) : Boolean
      {
         return this.getSpecificModifiedBool(entityId,spellId,modifierType,SpellModifierValueTypeEnum.ALL,baseValue);
      }
      
      public function getSpecificModifiedBool(entityId:Number, spellId:Number, modifierType:int, valueType:int = 1, baseValue:Boolean = false) : Boolean
      {
         var spellModifiers:SpellModifiers = this.getSpellModifiers(entityId,spellId);
         return spellModifiers !== null ? Boolean(spellModifiers.getModifiedBool(modifierType,baseValue,valueType)) : Boolean(baseValue);
      }
      
      public function getModifiedInt(entityId:Number, spellId:Number, modifierType:int, baseValue:int = 0) : int
      {
         return this.getSpecificModifiedInt(entityId,spellId,modifierType,SpellModifierValueTypeEnum.ALL,baseValue);
      }
      
      public function getSpecificModifiedInt(entityId:Number, spellId:Number, modifierType:int, valueType:int = 1, baseValue:int = 0) : int
      {
         var spellModifiers:SpellModifiers = this.getSpellModifiers(entityId,spellId);
         return spellModifiers !== null ? int(spellModifiers.getModifiedInt(modifierType,baseValue,valueType)) : int(baseValue);
      }
      
      public function destroy() : void
      {
         _singleton = null;
      }
      
      private function internalSetRawSpellModifier(entityId:Number, rawSpellModifier:SpellModifierMessage, spellsModifierStats:Dictionary) : void
      {
         if(!this.isValidActionType(rawSpellModifier.actionType))
         {
            _log.error("Tried to set an invalid raw spell modifier. Ignoring");
            return;
         }
         var spellModifiers:SpellModifiers = spellsModifierStats[rawSpellModifier.spellId.toString()];
         if(spellModifiers === null)
         {
            spellModifiers = new SpellModifiers(entityId,rawSpellModifier.spellId);
            this.setSpellModifiers(spellModifiers);
         }
         var spellModifier:SpellModifier = spellModifiers.getModifier(rawSpellModifier.modifierType);
         if(spellModifier === null)
         {
            spellModifier = new SpellModifier(rawSpellModifier.modifierType);
            spellModifiers.setModifier(spellModifier);
         }
         spellModifier.applyAction(rawSpellModifier.actionType,rawSpellModifier.equipment,rawSpellModifier.context);
      }
      
      private function isValidActionType(actionType:int) : Boolean
      {
         switch(actionType)
         {
            case SpellModifierActionTypeEnum.ACTION_SET:
               return true;
            case SpellModifierActionTypeEnum.ACTION_BOOST:
               return true;
            case SpellModifierActionTypeEnum.ACTION_DEBOOST:
               return true;
            default:
               return false;
         }
      }
   }
}
