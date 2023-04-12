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
         this._modifiers[modifier.id.toString()] = modifier;
         if(this.isVerbose)
         {
            _log.info("Set modifier for entity with ID " + this.entityId.toString() + " and spell with ID " + this.spellId.toString() + ": " + modifier.toString());
         }
         var updateSpellModifierAction:UpdateSpellModifierAction = UpdateSpellModifierAction.create(this.entityId,this.spellId,modifier.id);
         Kernel.getWorker().process(updateSpellModifierAction);
      }
      
      public function getModifier(modifierId:Number) : SpellModifier
      {
         if(!(modifierId in this._modifiers))
         {
            return null;
         }
         return this._modifiers[modifierId.toString()];
      }
      
      public function deleteModifier(modifierId:Number) : void
      {
         if(!(modifierId in this._modifiers))
         {
            return;
         }
         var modifierKey:String = modifierId.toString();
         var modifier:SpellModifier = this._modifiers[modifierKey];
         if(this.isVerbose)
         {
            _log.info("Deleted modifier for entity with ID " + this._entityId.toString() + " and spell with ID " + this._spellId.toString() + ": " + modifier.toString());
         }
         delete this._modifiers[modifierKey];
      }
      
      public function resetModifiers() : void
      {
         if(this.isVerbose)
         {
            _log.info("Modifiers reset for entity with ID " + this._entityId.toString() + " and spell with ID " + this._spellId.toString());
         }
         this._modifiers = new Dictionary();
      }
      
      public function getSpellModifiersNumber() : Number
      {
         var modifierKey:* = null;
         var counter:Number = 0;
         for(modifierKey in this._modifiers)
         {
            counter++;
         }
         return counter;
      }
      
      public function hasModifier(modifierId:Number) : Boolean
      {
         return modifierId.toString() in this._modifiers;
      }
      
      public function getModifierValue(modifierId:Number) : Number
      {
         var key:String = modifierId.toString();
         if(!(modifierId in this._modifiers))
         {
            return 0;
         }
         var modifier:SpellModifier = this._modifiers[key];
         return modifier !== null ? Number(modifier.totalValue) : Number(0);
      }
      
      public function getModifierBaseValue(modifierId:Number) : Number
      {
         var key:String = modifierId.toString();
         if(!(modifierId in this._modifiers))
         {
            return 0;
         }
         return this._modifiers[key].baseValue;
      }
      
      public function getModifierContextModifValue(modifierId:Number) : Number
      {
         var key:String = modifierId.toString();
         if(!(modifierId in this._modifiers))
         {
            return 0;
         }
         return this._modifiers[key].contextModifValue;
      }
      
      public function toString() : String
      {
         var spellModifierId:Number = NaN;
         var spellModifiersDump:String = "";
         var spellModifierIds:Vector.<Number> = new Vector.<Number>();
         var spellModifier:SpellModifier = null;
         for each(spellModifier in this._modifiers)
         {
            spellModifierIds.push(spellModifier.id);
         }
         spellModifierIds.sort(Array.NUMERIC);
         for each(spellModifierId in spellModifierIds)
         {
            spellModifier = this._modifiers[spellModifierId.toString()];
            spellModifiersDump += "\n\t" + spellModifier.toString();
         }
         if(!spellModifiersDump)
         {
            spellModifiersDump = "\n\tNo spell modifiers to display.";
         }
         return this.getFormattedMessage(spellModifiersDump);
      }
   }
}
