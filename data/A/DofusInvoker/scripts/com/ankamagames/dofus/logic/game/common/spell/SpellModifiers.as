package com.ankamagames.dofus.logic.game.common.spell
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.actions.UpdateSpellModifierAction;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public final class SpellModifiers
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellModifiers));
       
      
      private var _entityId:Number = NaN;
      
      private var _spellId:Number = NaN;
      
      private var _modifiers:Dictionary;
      
      public function SpellModifiers(entityId:Number, spellId:Number)
      {
         super();
         this._entityId = entityId;
         this._spellId = spellId;
         this._modifiers = new Dictionary();
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      public function get spellId() : Number
      {
         return this._spellId;
      }
      
      public function get modifiers() : Dictionary
      {
         return this._modifiers;
      }
      
      protected function get isVerbose() : Boolean
      {
         return SpellModifiersManager.getInstance().isVerbose;
      }
      
      protected function getFormattedMessage(message:String) : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " (Entity ID: " + this._entityId.toString() + ", Spell ID: " + this._spellId.toString() + "): " + message;
      }
      
      public function setModifier(modifier:SpellModifier) : void
      {
         modifier.entityId = this._entityId;
         modifier.spellId = this._spellId;
         this._modifiers[modifier.modifierType.toString()] = modifier;
         if(this.isVerbose)
         {
            _log.info("Set modifier for entity with ID " + this.entityId.toString() + " and spell with ID " + this.spellId.toString() + ": " + modifier.dump());
         }
         var updateSpellModifierAction:UpdateSpellModifierAction = UpdateSpellModifierAction.create(this.entityId,this.spellId,modifier.modifierType);
         Kernel.getWorker().process(updateSpellModifierAction);
      }
      
      public function getModifier(modifierType:int) : SpellModifier
      {
         if(!(modifierType in this._modifiers))
         {
            return null;
         }
         return this._modifiers[modifierType.toString()];
      }
      
      public function deleteModifierAction(modifierType:int, actionType:int) : void
      {
         if(!(modifierType in this._modifiers))
         {
            return;
         }
         var modifierKey:String = modifierType.toString();
         var modifier:SpellModifier = this._modifiers[modifierKey];
         if(modifier === null)
         {
            return;
         }
         modifier.removeAction(actionType);
         if(modifier.isEmpty)
         {
            delete this._modifiers[modifierKey];
         }
         if(this.isVerbose)
         {
            _log.info("Deleted modifier for entity with ID " + this._entityId.toString() + " and spell with ID " + this._spellId.toString() + ": " + modifier.dump());
         }
      }
      
      public function dump(indentLevel:uint = 0) : String
      {
         var spellModifierId:Number = NaN;
         var spellModifiersDump:String = "";
         var spellModifierIds:Vector.<Number> = new Vector.<Number>();
         var spellModifier:SpellModifier = null;
         for each(spellModifier in this._modifiers)
         {
            spellModifierIds.push(spellModifier.modifierType);
         }
         spellModifierIds.sort(Array.NUMERIC);
         for each(spellModifierId in spellModifierIds)
         {
            spellModifier = this._modifiers[spellModifierId.toString()];
            if(spellModifier !== null)
            {
               spellModifiersDump += "\n\t" + spellModifier.dump(indentLevel);
            }
         }
         if(!spellModifiersDump)
         {
            spellModifiersDump = "\n\tNo spell modifiers to display.";
         }
         return this.getFormattedMessage(spellModifiersDump);
      }
      
      public function getModifiedBool(modifierType:int, baseValue:Boolean = false, valueType:int = 1) : Boolean
      {
         var modifier:SpellModifier = this._modifiers[modifierType];
         if(modifier === null)
         {
            return baseValue;
         }
         return modifier.getValueAsBool(valueType,baseValue);
      }
      
      public function getModifiedInt(modifierType:int, baseValue:int = 0, valueType:int = 1) : int
      {
         var modifier:SpellModifier = this._modifiers[modifierType];
         if(modifier === null)
         {
            return baseValue;
         }
         return modifier.getValueAsInt(valueType,baseValue);
      }
      
      public function hasAction(modifierType:int, actionType:int) : Boolean
      {
         var modifier:SpellModifier = this._modifiers[modifierType];
         if(modifier === null)
         {
            return false;
         }
         return modifier.hasAction(actionType);
      }
   }
}
