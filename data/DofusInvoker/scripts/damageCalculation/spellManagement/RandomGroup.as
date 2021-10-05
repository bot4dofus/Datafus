package damageCalculation.spellManagement
{
   import haxe.IMap;
   import haxe.ds.IntMap;
   import haxe.ds._IntMap.IntMapValuesIterator;
   
   public class RandomGroup
   {
       
      
      public var weight:Number;
      
      public var effects:Array;
      
      public function RandomGroup(param1:Array)
      {
         var _loc3_:* = null as HaxeSpellEffect;
         effects = param1;
         weight = 0;
         var _loc2_:int = 0;
         while(_loc2_ < int(param1.length))
         {
            _loc3_ = param1[_loc2_];
            _loc2_++;
            weight += _loc3_.randomWeight;
         }
      }
      
      public static function totalWeight(param1:IMap) : Number
      {
         var _loc4_:* = null as RandomGroup;
         var _loc2_:Number = 0;
         var _loc3_:* = new IntMapValuesIterator(param1.h);
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            _loc2_ += _loc4_.weight;
         }
         return _loc2_;
      }
      
      public static function createGroups(param1:Array) : IMap
      {
         var _loc5_:* = null as HaxeSpellEffect;
         var _loc6_:int = 0;
         var _loc7_:* = null as RandomGroup;
         var _loc8_:int = 0;
         var _loc2_:IMap = new IntMap();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            _loc4_++;
            if(_loc5_.randomWeight > 0)
            {
               if(_loc5_.randomGroup == 0)
               {
                  _loc3_--;
                  _loc5_.randomGroup = _loc3_;
               }
               _loc6_ = _loc5_.randomGroup;
               if(_loc6_ in _loc2_.h)
               {
                  _loc7_ = _loc2_.h[_loc5_.randomGroup];
                  _loc7_.effects.push(_loc5_);
                  _loc7_.weight += _loc5_.randomWeight;
               }
               else
               {
                  _loc8_ = _loc5_.randomGroup;
                  _loc7_ = new RandomGroup([_loc5_]);
                  _loc2_.h[_loc8_] = _loc7_;
               }
            }
         }
         return _loc2_;
      }
      
      public static function selectRandomGroup(param1:IMap) : Array
      {
         var _loc5_:* = null as RandomGroup;
         var _loc2_:Number = RandomGroup.totalWeight(param1) * Math.random();
         var _loc3_:RandomGroup = null;
         var _loc4_:* = new IntMapValuesIterator(param1.h);
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc2_ -= _loc5_.weight;
            if(_loc2_ <= 0)
            {
               break;
            }
         }
         return _loc3_.effects;
      }
      
      public function addEffect(param1:HaxeSpellEffect) : void
      {
         effects.push(param1);
         weight += param1.randomWeight;
      }
   }
}
