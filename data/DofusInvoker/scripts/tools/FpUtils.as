package tools
{
   import damageCalculation.damageManagement.DamageRange;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.Mark;
   import flash.geom.Point;
   import haxe.ds.List;
   import haxe.ds._List.ListNode;
   
   public class FpUtils
   {
       
      
      public function FpUtils()
      {
      }
      
      public static function arrayRemove_damageCalculation_fighterManagement_HaxeFighter(param1:Array, param2:HaxeFighter) : void
      {
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ != -1)
         {
            param1.splice(_loc3_,1);
         }
      }
      
      public static function arrayDistinct_damageCalculation_FighterId(param1:Array) : Array
      {
         var _loc4_:Number = NaN;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = Number(param1[_loc3_]);
            _loc3_++;
            if(int(param1.indexOf(_loc4_)) == int(param1.lastIndexOf(_loc4_)))
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public static function arrayMap_damageCalculation_damageManagement_EffectOutput_damageCalculation_FighterId(param1:Array, param2:Function) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc3_[_loc6_] = Number(param2(param1[_loc6_]));
         }
         return _loc3_;
      }
      
      public static function arrayFold_Array_damageCalculation_damageManagement_EffectOutput_Array_damageCalculation_damageManagement_EffectOutput(param1:Array, param2:Function, param3:Array) : Array
      {
         var _loc6_:* = null as Array;
         var _loc4_:Array = param3;
         var _loc5_:int = 0;
         while(_loc5_ < int(param1.length))
         {
            _loc6_ = param1[_loc5_];
            _loc5_++;
            _loc4_ = param2(_loc6_,_loc4_);
         }
         return _loc4_;
      }
      
      public static function arrayMap_damageCalculation_fighterManagement_HaxeFighter_Array_damageCalculation_damageManagement_EffectOutput(param1:Array, param2:Function) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc3_[_loc6_] = param2(param1[_loc6_]);
         }
         return _loc3_;
      }
      
      public static function listConcat_damageCalculation_damageManagement_DamageRange(param1:List, param2:List) : List
      {
         var _loc5_:* = null as DamageRange;
         var _loc6_:* = null as DamageRange;
         var _loc3_:List = new List();
         var _loc4_:ListNode = param1.h;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.item;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc3_.add(_loc6_);
         }
         _loc4_ = param2.h;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.item;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc3_.add(_loc6_);
         }
         return _loc3_;
      }
      
      public static function listCopy_damageCalculation_damageManagement_EffectOutput(param1:List) : List
      {
         var _loc4_:* = null as EffectOutput;
         var _loc5_:* = null as EffectOutput;
         var _loc2_:List = new List();
         var _loc3_:ListNode = param1.h;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.item;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            _loc2_.add(_loc5_);
         }
         return _loc2_;
      }
      
      public static function listConcat_damageCalculation_damageManagement_EffectOutput(param1:List, param2:List) : List
      {
         var _loc5_:* = null as EffectOutput;
         var _loc6_:* = null as EffectOutput;
         var _loc3_:List = new List();
         var _loc4_:ListNode = param1.h;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.item;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc3_.add(_loc6_);
         }
         _loc4_ = param2.h;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.item;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc3_.add(_loc6_);
         }
         return _loc3_;
      }
      
      public static function listAfter_damageCalculation_damageManagement_EffectOutput(param1:List, param2:EffectOutput) : List
      {
         var _loc6_:* = null as EffectOutput;
         var _loc7_:* = null as EffectOutput;
         var _loc3_:List = new List();
         var _loc4_:Boolean = false;
         var _loc5_:ListNode = param1.h;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.item;
            _loc5_ = _loc5_.next;
            _loc7_ = _loc6_;
            if(_loc4_)
            {
               _loc3_.add(_loc7_);
            }
            if(_loc7_ == param2)
            {
               _loc4_ = true;
            }
         }
         return _loc3_;
      }
      
      public static function arrayCopy_damageCalculation_spellManagement_HaxeSpellEffect(param1:Array) : Array
      {
         var _loc4_:* = null as HaxeSpellEffect;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function arrayRemove_damageCalculation_spellManagement_Mark(param1:Array, param2:Mark) : void
      {
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ != -1)
         {
            param1.splice(_loc3_,1);
         }
      }
      
      public static function arrayFind_damageCalculation_spellManagement_Mark(param1:Array, param2:Function) : Mark
      {
         var _loc4_:* = null as Mark;
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            if(param2(_loc4_))
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function arrayFilter_damageCalculation_spellManagement_Mark(param1:Array, param2:Function) : Array
      {
         var _loc5_:* = null as Mark;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            _loc4_++;
            if(param2(_loc5_))
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public static function arrayFilter_damageCalculation_fighterManagement_HaxeFighter(param1:Array, param2:Function) : Array
      {
         var _loc5_:* = null as HaxeFighter;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            _loc4_++;
            if(param2(_loc5_))
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public static function arrayCopy_String(param1:Array) : Array
      {
         var _loc4_:* = null as String;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function arrayContains_Int(param1:Array, param2:int) : Boolean
      {
         return int(param1.indexOf(param2)) != -1;
      }
      
      public static function arrayFilter_String(param1:Array, param2:Function) : Array
      {
         var _loc5_:* = null as String;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            _loc4_++;
            if(param2(_loc5_))
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public static function arrayMap_Int_flash_geom_Point(param1:Array, param2:Function) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc3_[_loc6_] = param2(int(param1[_loc6_]));
         }
         return _loc3_;
      }
   }
}
