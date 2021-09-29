package com.ankamagames.dofus.logic.game.common.spell
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import mx.utils.NameUtil;
   
   public class SpellModifier
   {
      
      public static const UNKNOWN_MODIFIER_NAME:String = "unknown";
       
      
      private var _entityId:Number = NaN;
      
      private var _spellId:Number = NaN;
      
      private var _id:Number = 0;
      
      private var _baseValue:Number = 0;
      
      private var _additionalValue:Number = 0;
      
      private var _objectsAndMountBonusValue:Number = 0;
      
      private var _alignGiftBonusValue:Number = 0;
      
      private var _contextModifValue:Number = 0;
      
      private var _totalValue:Number = 0;
      
      private var _name:String = null;
      
      public function SpellModifier(id:Number, baseValue:Number, additionalValue:Number, objectsAndMountBonusValue:Number, alignGiftBonusValue:Number, contextModifValue:Number)
      {
         super();
         this._id = id;
         this._baseValue = baseValue;
         this._additionalValue = additionalValue;
         this._objectsAndMountBonusValue = objectsAndMountBonusValue;
         this._alignGiftBonusValue = alignGiftBonusValue;
         this._contextModifValue = contextModifValue;
         this._totalValue = this._baseValue + this._additionalValue + this._objectsAndMountBonusValue + this._alignGiftBonusValue + this._contextModifValue;
         this._name = this.getModifierName();
      }
      
      public static function getSpellModifierIdFromActionId(actionId:Number) : Number
      {
         switch(actionId)
         {
            case ActionIds.ACTION_BOOST_SPELL_RANGEABLE:
               return CharacterSpellModificationTypeEnum.RANGEABLE;
            case ActionIds.ACTION_BOOST_SPELL_DMG:
               return CharacterSpellModificationTypeEnum.DAMAGE;
            case ActionIds.ACTION_BOOST_SPELL_BASE_DMG:
               return CharacterSpellModificationTypeEnum.BASE_DAMAGE;
            case ActionIds.ACTION_BOOST_SPELL_HEAL:
               return CharacterSpellModificationTypeEnum.HEAL_BONUS;
            case ActionIds.ACTION_BOOST_SPELL_AP_COST:
               return CharacterSpellModificationTypeEnum.AP_COST;
            case ActionIds.ACTION_DEBOOST_SPELL_AP_COST:
               return CharacterSpellModificationTypeEnum.AP_COST;
            case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL:
               return CharacterSpellModificationTypeEnum.CAST_INTERVAL;
            case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL_SET:
               return CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET;
            case ActionIds.ACTION_BOOST_SPELL_CC:
               return CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS;
            case ActionIds.ACTION_BOOST_SPELL_CASTOUTLINE:
               return CharacterSpellModificationTypeEnum.CAST_LINE;
            case ActionIds.ACTION_BOOST_SPELL_NOLINEOFSIGHT:
               return CharacterSpellModificationTypeEnum.LOS;
            case ActionIds.ACTION_BOOST_SPELL_MAXPERTURN:
               return CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN;
            case ActionIds.ACTION_BOOST_SPELL_MAXPERTARGET:
               return CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET;
            case ActionIds.ACTION_BOOST_SPELL_RANGE_MAX:
               return CharacterSpellModificationTypeEnum.RANGE_MAX;
            case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MAX:
               return CharacterSpellModificationTypeEnum.RANGE_MAX;
            case ActionIds.ACTION_BOOST_SPELL_RANGE_MIN:
               return CharacterSpellModificationTypeEnum.RANGE_MIN;
            case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MIN:
               return CharacterSpellModificationTypeEnum.RANGE_MIN;
            default:
               return CharacterSpellModificationTypeEnum.INVALID_MODIFICATION;
         }
      }
      
      public function set entityId(entityId:Number) : void
      {
         this._entityId = entityId;
      }
      
      public function set spellId(spellId:Number) : void
      {
         this._spellId = spellId;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get baseValue() : Number
      {
         return this._baseValue;
      }
      
      public function get additionalValue() : Number
      {
         return this._additionalValue;
      }
      
      public function get objectsAndMountBonusValue() : Number
      {
         return this._objectsAndMountBonusValue;
      }
      
      public function get alignGiftBonusValue() : Number
      {
         return this._alignGiftBonusValue;
      }
      
      public function get contextModifValue() : Number
      {
         return this._contextModifValue;
      }
      
      public function get totalValue() : Number
      {
         return this._totalValue;
      }
      
      private function getModifierName() : String
      {
         switch(this._id)
         {
            case CharacterSpellModificationTypeEnum.INVALID_MODIFICATION:
               return "invalid modification";
            case CharacterSpellModificationTypeEnum.RANGEABLE:
               return "rangeable";
            case CharacterSpellModificationTypeEnum.DAMAGE:
               return "damage";
            case CharacterSpellModificationTypeEnum.BASE_DAMAGE:
               return "base damage";
            case CharacterSpellModificationTypeEnum.HEAL_BONUS:
               return "heal bonus";
            case CharacterSpellModificationTypeEnum.AP_COST:
               return "ap cost";
            case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
               return "cast interval";
            case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
               return "cast interval set";
            case CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS:
               return "critical hit bonus";
            case CharacterSpellModificationTypeEnum.CAST_LINE:
               return "cast line";
            case CharacterSpellModificationTypeEnum.LOS:
               return "los";
            case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN:
               return "max cast per turn";
            case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET:
               return "max cast per target";
            case CharacterSpellModificationTypeEnum.RANGE_MAX:
               return "range max";
            case CharacterSpellModificationTypeEnum.RANGE_MIN:
               return "range min";
            default:
               return UNKNOWN_MODIFIER_NAME;
         }
      }
      
      public function toString() : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " " + this._name + " (Entity ID: " + this._entityId.toString() + ", Spell ID: " + this._spellId.toString() + ", ID: " + this._id.toString() + "): " + "base: " + this._baseValue.toString() + " additional: " + this._additionalValue.toString() + " objectsAndMountBonus: " + this._objectsAndMountBonusValue.toString() + " alignGiftBonus: " + this._alignGiftBonusValue.toString() + " contextModif: " + this._contextModifValue.toString() + " total: " + this._totalValue.toString();
      }
   }
}
