package damageCalculation.spellManagement
{
   public class HaxeSpell
   {
       
      
      public var needsTakenCell:Boolean;
      
      public var needsFreeCell:Boolean;
      
      public var minimaleRange:int;
      
      public var maximaleRange:int;
      
      public var maxEffectsStack:int;
      
      public var level:int;
      
      public var isWeapon:Boolean;
      
      public var isTrap:Boolean;
      
      public var isRune:Boolean;
      
      public var isGlyph:Boolean;
      
      public var id:int;
      
      public var criticalHitProbability:int;
      
      public var canBeReflected:Boolean;
      
      public var canAlwaysTriggerSpells:Boolean;
      
      public var _effects:Array;
      
      public var _criticalEffects:Array;
      
      public function HaxeSpell(param1:int, param2:Array, param3:Array, param4:int, param5:Boolean, param6:Boolean, param7:int, param8:int, param9:int, param10:Boolean, param11:Boolean, param12:int = -1)
      {
         canBeReflected = true;
         isRune = false;
         isGlyph = false;
         isTrap = false;
         isWeapon = false;
         _effects = param2;
         _criticalEffects = param3;
         id = param1;
         minimaleRange = 1;
         maximaleRange = 1;
         level = param4;
         canAlwaysTriggerSpells = param5;
         isWeapon = param6;
         minimaleRange = param7;
         maximaleRange = param8;
         criticalHitProbability = param9;
         needsFreeCell = param10;
         needsTakenCell = param11;
         maxEffectsStack = param12;
      }
      
      public function hasAtLeastOneRandomEffect() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:* = null as Array;
         var _loc3_:* = null as HaxeSpellEffect;
         if(_effects != null)
         {
            _loc1_ = 0;
            _loc2_ = _effects;
            while(_loc1_ < int(_loc2_.length))
            {
               _loc3_ = _loc2_[_loc1_];
               _loc1_++;
               if(_loc3_.randomWeight > 0)
               {
                  return true;
               }
            }
         }
         if(_criticalEffects != null)
         {
            _loc1_ = 0;
            _loc2_ = _criticalEffects;
            while(_loc1_ < int(_loc2_.length))
            {
               _loc3_ = _loc2_[_loc1_];
               _loc1_++;
               if(_loc3_.randomWeight > 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getEffects() : Array
      {
         return _effects;
      }
      
      public function getEffectById(param1:uint) : HaxeSpellEffect
      {
         var _loc4_:* = null as HaxeSpellEffect;
         var _loc2_:int = 0;
         var _loc3_:Array = _effects;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.id == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getEffectByActionId(param1:int) : HaxeSpellEffect
      {
         var _loc4_:* = null as HaxeSpellEffect;
         var _loc2_:int = 0;
         var _loc3_:Array = _effects;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.actionId == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getCriticalEffects() : Array
      {
         return _criticalEffects;
      }
      
      public function getCriticalEffectById(param1:uint) : HaxeSpellEffect
      {
         var _loc4_:* = null as HaxeSpellEffect;
         var _loc2_:int = 0;
         var _loc3_:Array = _criticalEffects;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.id == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getCriticalEffectByActionId(param1:int) : HaxeSpellEffect
      {
         var _loc4_:* = null as HaxeSpellEffect;
         var _loc2_:int = 0;
         var _loc3_:Array = _criticalEffects;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.actionId == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}
