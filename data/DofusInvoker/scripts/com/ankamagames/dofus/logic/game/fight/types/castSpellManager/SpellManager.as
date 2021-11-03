package com.ankamagames.dofus.logic.game.fight.types.castSpellManager
{
   import com.ankamagames.dofus.datacenter.optionalFeatures.ForgettableSpell;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SpellManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellManager));
       
      
      private var _spellId:uint;
      
      private var _spellLevel:uint;
      
      private var _lastCastTurn:int;
      
      private var _spellHasBeenCast:Boolean;
      
      private var _forcedCooldown:Boolean;
      
      private var _lastInitialCooldownReset:int;
      
      private var _castThisTurn:uint;
      
      private var _targetsThisTurn:Dictionary;
      
      private var _spellCastManager:SpellCastInFightManager;
      
      private var _castIntervalModificator:int;
      
      private var _castIntervalSetModificator:int;
      
      public function SpellManager(spellCastManager:SpellCastInFightManager, pSpellId:uint, pSpellLevel:uint)
      {
         super();
         this._spellCastManager = spellCastManager;
         this._spellId = pSpellId;
         this._spellLevel = pSpellLevel;
         this._targetsThisTurn = new Dictionary();
      }
      
      public static function isForgettableSpell(spellId:int) : Boolean
      {
         return ForgettableSpell.getForgettableSpellById(spellId) !== null;
      }
      
      public function get numberCastThisTurn() : uint
      {
         return this._castThisTurn;
      }
      
      public function set spellLevel(pSpellLevel:uint) : void
      {
         this._spellLevel = pSpellLevel;
      }
      
      public function get spellLevel() : uint
      {
         return this._spellLevel;
      }
      
      public function get spell() : Spell
      {
         return Spell.getSpellById(this._spellId);
      }
      
      public function cast(pTurn:int, pTarget:Array, pCountForCooldown:Boolean = true) : void
      {
         var target:Number = NaN;
         this._castIntervalModificator = this._castIntervalSetModificator = 0;
         this._lastCastTurn = pTurn;
         this._forcedCooldown = false;
         this._spellHasBeenCast = true;
         for each(target in pTarget)
         {
            if(this._targetsThisTurn[target] == null)
            {
               this._targetsThisTurn[target] = 0;
            }
            this._targetsThisTurn[target] += 1;
         }
         if(pCountForCooldown)
         {
            ++this._castThisTurn;
         }
         this.updateSpellWrapper();
      }
      
      public function resetInitialCooldown(pTurn:int) : void
      {
         this._lastInitialCooldownReset = pTurn;
         this.updateSpellWrapper();
      }
      
      public function getCastOnEntity(pEntityId:Number) : uint
      {
         if(this._targetsThisTurn[pEntityId] == null)
         {
            return 0;
         }
         return this._targetsThisTurn[pEntityId];
      }
      
      public function newTurn() : void
      {
         this._castThisTurn = 0;
         this._targetsThisTurn = new Dictionary();
         this.updateSpellWrapper();
      }
      
      public function get cooldown() : Number
      {
         var interval:Number = NaN;
         var cooldown:int = 0;
         var spell:Spell = Spell.getSpellById(this._spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(this._spellLevel);
         var spellModifiers:SpellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(this._spellCastManager.entityId,this._spellId);
         var castIntervalModifier:Number = 0;
         var castIntervalSetModifier:Number = 0;
         if(spellModifiers !== null)
         {
            castIntervalModifier = spellModifiers.getModifierValue(CharacterSpellModificationTypeEnum.CAST_INTERVAL);
            castIntervalSetModifier = spellModifiers.getModifierValue(CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET);
         }
         if(castIntervalModifier)
         {
            this._castIntervalModificator = castIntervalModifier;
         }
         else
         {
            castIntervalModifier = this._castIntervalModificator;
         }
         if(castIntervalSetModifier)
         {
            this._castIntervalSetModificator = castIntervalSetModifier;
         }
         else
         {
            castIntervalSetModifier = this._castIntervalSetModificator;
         }
         if(castIntervalSetModifier)
         {
            interval = -castIntervalModifier + castIntervalSetModifier;
         }
         else
         {
            interval = spellLevel.minCastInterval - (castIntervalModifier < 0 ? 0 : castIntervalModifier);
         }
         if(interval == 63)
         {
            return 63;
         }
         var initialCooldown:int = this._lastInitialCooldownReset + spellLevel.initialCooldown - this._spellCastManager.currentTurn;
         if(this._lastCastTurn >= this._lastInitialCooldownReset + spellLevel.initialCooldown || spellLevel.initialCooldown == 0 || this._forcedCooldown || this._castThisTurn > 0 || this._spellHasBeenCast)
         {
            cooldown = interval + this._lastCastTurn - this._spellCastManager.currentTurn;
         }
         else
         {
            cooldown = initialCooldown;
         }
         if(cooldown <= 0)
         {
            cooldown = 0;
         }
         return cooldown;
      }
      
      public function forceCooldown(cooldown:int, isBonusRefresh:Boolean = false) : void
      {
         var spell:Spell = Spell.getSpellById(this._spellId);
         var spellL:SpellLevel = spell.getSpellLevel(this._spellLevel);
         this._lastCastTurn = cooldown + this._spellCastManager.currentTurn - spellL.minCastInterval;
         this._forcedCooldown = true;
         var spellW:SpellWrapper = SpellWrapper.getSpellWrapperById(this._spellId,this._spellCastManager.entityId);
         if(isBonusRefresh)
         {
            cooldown -= this._castIntervalModificator;
         }
         spellW.actualCooldown = cooldown;
      }
      
      public function forceLastCastTurn(pLastCastTurn:int) : void
      {
         this._lastCastTurn = pLastCastTurn;
         this._forcedCooldown = false;
         this.updateSpellWrapper();
      }
      
      private function updateSpellWrapper() : void
      {
         var spellW:SpellWrapper = SpellWrapper.getSpellWrapperById(this._spellId,this._spellCastManager.entityId);
         if(spellW === null)
         {
            spellW = SpellWrapper.create(this._spellId,this._spellLevel,true,this._spellCastManager.entityId);
         }
         if(spellW && spellW.actualCooldown != 63)
         {
            spellW.actualCooldown = this.cooldown;
         }
      }
   }
}
