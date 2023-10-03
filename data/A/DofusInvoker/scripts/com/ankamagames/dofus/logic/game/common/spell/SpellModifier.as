package com.ankamagames.dofus.logic.game.common.spell
{
   import com.ankamagames.dofus.network.enums.SpellModifierActionTypeEnum;
   import com.ankamagames.dofus.network.enums.SpellModifierTypeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public class SpellModifier
   {
      
      public static const UNKNOWN_MODIFIER_NAME:String = "unknown";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellModifier));
       
      
      private var _entityId:Number = NaN;
      
      private var _spellId:Number = NaN;
      
      private var _modifierType:Number = 0;
      
      private var _name:String = null;
      
      private var _actions:Dictionary;
      
      public function SpellModifier(modifierType:Number)
      {
         this._actions = new Dictionary();
         super();
         this._modifierType = modifierType;
         this._name = this.getModifierName();
      }
      
      public function set entityId(entityId:Number) : void
      {
         this._entityId = entityId;
      }
      
      public function set spellId(spellId:Number) : void
      {
         this._spellId = spellId;
      }
      
      public function get modifierType() : Number
      {
         return this._modifierType;
      }
      
      public function get isEmpty() : Boolean
      {
         var action:SpellModifierAction = null;
         var _loc2_:int = 0;
         var _loc3_:* = this._actions;
         for each(action in _loc3_)
         {
            return false;
         }
         return true;
      }
      
      public function hasAction(actionType:int) : Boolean
      {
         return actionType.toString() in this._actions;
      }
      
      public function applyAction(actionType:int, equipment:int, context:int) : void
      {
         var action:SpellModifierAction = new SpellModifierAction(actionType,equipment,context);
         this._actions[action.actionType] = action;
      }
      
      public function removeAction(actionType:int) : void
      {
         var key:String = actionType.toString();
         if(key in this._actions)
         {
            delete this._actions[key];
         }
      }
      
      public function getValueAsInt(valueType:int = 1, baseValue:int = 0) : int
      {
         var setAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_SET];
         if(setAction !== null)
         {
            return setAction.getInt(valueType);
         }
         var boostAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_BOOST];
         var deboostAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_DEBOOST];
         var boostValue:int = boostAction !== null ? int(boostAction.getInt(valueType)) : 0;
         var deboostValue:int = deboostAction !== null ? int(deboostAction.getInt(valueType)) : 0;
         var modifierValue:int = boostValue - deboostValue;
         return baseValue + modifierValue * this.getIntModifierSign();
      }
      
      public function getValueAsBool(valueType:int = 1, baseValue:Boolean = false) : Boolean
      {
         var flag:Boolean = false;
         var setAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_SET];
         if(setAction !== null)
         {
            return setAction.getBool(valueType);
         }
         var boostAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_BOOST];
         var deboostAction:SpellModifierAction = this._actions[SpellModifierActionTypeEnum.ACTION_DEBOOST];
         var boostValue:Boolean = boostAction !== null ? Boolean(boostAction.getBool(valueType)) : false;
         var deboostValue:Boolean = deboostAction !== null ? Boolean(deboostAction.getBool(valueType)) : false;
         if(boostValue && deboostValue)
         {
            flag = baseValue;
         }
         else if(boostValue)
         {
            flag = true;
         }
         else if(deboostValue)
         {
            flag = false;
         }
         else
         {
            flag = baseValue;
         }
         return flag;
      }
      
      private function getIntModifierSign() : int
      {
         switch(this._modifierType)
         {
            case SpellModifierTypeEnum.AP_COST:
               return -1;
            case SpellModifierTypeEnum.CAST_INTERVAL:
               return -1;
            default:
               return 1;
         }
      }
      
      private function getModifierName() : String
      {
         switch(this._modifierType)
         {
            case SpellModifierTypeEnum.INVALID_MODIFICATION:
               return "invalid modification";
            case SpellModifierTypeEnum.RANGEABLE:
               return "rangeable";
            case SpellModifierTypeEnum.DAMAGE:
               return "damage";
            case SpellModifierTypeEnum.BASE_DAMAGE:
               return "base damage";
            case SpellModifierTypeEnum.HEAL_BONUS:
               return "heal bonus";
            case SpellModifierTypeEnum.AP_COST:
               return "ap cost";
            case SpellModifierTypeEnum.CAST_INTERVAL:
               return "cast interval";
            case SpellModifierTypeEnum.CRITICAL_HIT_BONUS:
               return "critical hit bonus";
            case SpellModifierTypeEnum.CAST_LINE:
               return "cast line";
            case SpellModifierTypeEnum.LOS:
               return "los";
            case SpellModifierTypeEnum.MAX_CAST_PER_TURN:
               return "max cast per turn";
            case SpellModifierTypeEnum.MAX_CAST_PER_TARGET:
               return "max cast per target";
            case SpellModifierTypeEnum.RANGE_MAX:
               return "range max";
            case SpellModifierTypeEnum.RANGE_MIN:
               return "range min";
            case SpellModifierTypeEnum.OCCUPIED_CELL:
               return "occupied cell";
            case SpellModifierTypeEnum.FREE_CELL:
               return "free cell";
            case SpellModifierTypeEnum.VISIBLE_TARGET:
               return "visible target";
            case SpellModifierTypeEnum.PORTAL_PROJECTION:
               return "portal projection";
            case SpellModifierTypeEnum.PORTAL_FREE_CELL:
               return "portal free cell";
            default:
               return UNKNOWN_MODIFIER_NAME;
         }
      }
      
      public function dump(indentLevel:uint = 0) : String
      {
         var action:SpellModifierAction = null;
         var actionType:int = 0;
         var indent:* = "\t";
         for(var i:uint = 0; i < indentLevel; i++)
         {
            indent += "\t";
         }
         var toReturn:* = NameUtil.getUnqualifiedClassName(this) + " " + this._name + " (Entity ID: " + this._entityId.toString() + ", Spell ID: " + this._spellId.toString() + ", type: " + this._modifierType.toString() + ")";
         var actionTypes:Vector.<int> = new Vector.<int>(0);
         for each(action in this._actions)
         {
            actionTypes.push(action.actionType);
         }
         actionTypes.sort(Array.NUMERIC);
         for each(actionType in actionTypes)
         {
            action = this._actions[actionType];
            toReturn += "\n" + indent + action.dump(this.isBool());
         }
         return toReturn;
      }
      
      private function isBool() : Boolean
      {
         switch(this._modifierType)
         {
            case SpellModifierTypeEnum.RANGEABLE:
               return true;
            case SpellModifierTypeEnum.CAST_LINE:
               return true;
            case SpellModifierTypeEnum.LOS:
               return true;
            case SpellModifierTypeEnum.OCCUPIED_CELL:
               return true;
            case SpellModifierTypeEnum.FREE_CELL:
               return true;
            case SpellModifierTypeEnum.VISIBLE_TARGET:
               return true;
            case SpellModifierTypeEnum.PORTAL_PROJECTION:
               return true;
            case SpellModifierTypeEnum.PORTAL_FREE_CELL:
               return true;
            default:
               return false;
         }
      }
   }
}

import com.ankamagames.dofus.logic.game.common.spell.SpellModifierValueTypeEnum;
import com.ankamagames.dofus.network.enums.SpellModifierActionTypeEnum;

class SpellModifierAction
{
    
   
   private var _actionType:int = 0;
   
   private var _equipment:int = 0;
   
   private var _context:int = 0;
   
   private var _total:int = 0;
   
   function SpellModifierAction(actionType:int, equipment:int, context:int)
   {
      super();
      this._actionType = actionType;
      this._equipment = equipment;
      this._context = context;
      this._total = this._equipment + this._context;
   }
   
   public function get actionType() : int
   {
      return this._actionType;
   }
   
   public function getEquipmentAsInt() : int
   {
      return this._equipment;
   }
   
   public function getEquipmentAsBool() : Boolean
   {
      return this._equipment > 0;
   }
   
   public function getContextAsInt() : int
   {
      return this._context;
   }
   
   public function getContextAsBool() : Boolean
   {
      return this._context > 0;
   }
   
   public function getTotalAsInt() : int
   {
      return this._total;
   }
   
   public function getTotalAsBool() : Boolean
   {
      return this._total > 0;
   }
   
   public function getInt(valueType:int) : int
   {
      switch(valueType)
      {
         case SpellModifierValueTypeEnum.ALL:
            return this.getTotalAsInt();
         case SpellModifierValueTypeEnum.EQUIPMENT:
            return this.getEquipmentAsInt();
         case SpellModifierValueTypeEnum.CONTEXT:
            return this.getContextAsInt();
         default:
            return 0;
      }
   }
   
   public function getBool(valueType:int) : Boolean
   {
      switch(valueType)
      {
         case SpellModifierValueTypeEnum.ALL:
            return this.getTotalAsBool();
         case SpellModifierValueTypeEnum.EQUIPMENT:
            return this.getEquipmentAsBool();
         case SpellModifierValueTypeEnum.CONTEXT:
            return this.getContextAsBool();
         default:
            return false;
      }
   }
   
   public function dump(asBool:Boolean = false) : String
   {
      var equipmentStr:String = this.getEquipmentAsInt().toString();
      var contextStr:String = this.getContextAsInt().toString();
      var totalStr:String = this.getTotalAsInt().toString();
      if(asBool)
      {
         equipmentStr += " (" + this.getEquipmentAsBool() + ")";
         contextStr += " (" + this.getContextAsBool() + ")";
         totalStr += " (" + this.getTotalAsBool() + ")";
      }
      return this.getActionName() + "[" + "equipment: " + equipmentStr + ", context: " + contextStr + ", total: " + totalStr + "]";
   }
   
   private function getActionName() : String
   {
      switch(this._actionType)
      {
         case SpellModifierActionTypeEnum.ACTION_SET:
            return "Set";
         case SpellModifierActionTypeEnum.ACTION_BOOST:
            return "Boost";
         case SpellModifierActionTypeEnum.ACTION_DEBOOST:
            return "Deboost";
         case SpellModifierActionTypeEnum.ACTION_INVALID:
            return "Invalid";
         default:
            return "???";
      }
   }
}
