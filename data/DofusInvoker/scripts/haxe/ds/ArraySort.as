package haxe.ds
{
   public class ArraySort
   {
       
      
      public function ArraySort()
      {
      }
      
      public static function sort(param1:Array, param2:Function) : void
      {
         ArraySort.rec(param1,param2,0,int(param1.length));
      }
      
      public static function rec(param1:Array, param2:Function, param3:int, param4:int) : void
      {
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:* = param3 + param4 >> 1;
         if(param4 - param3 < 12)
         {
            if(param4 <= param3)
            {
               return;
            }
            _loc6_ = param3 + 1;
            _loc7_ = param4;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _loc9_ = _loc8_;
               while(_loc9_ > param3)
               {
                  if(int(param2(param1[_loc9_],param1[_loc9_ - 1])) >= 0)
                  {
                     break;
                  }
                  ArraySort.swap(param1,_loc9_ - 1,_loc9_);
                  _loc9_--;
               }
            }
            return;
         }
         ArraySort.rec(param1,param2,param3,_loc5_);
         ArraySort.rec(param1,param2,_loc5_,param4);
         ArraySort.doMerge(param1,param2,param3,_loc5_,param4,_loc5_ - param3,param4 - _loc5_);
      }
      
      public static function doMerge(param1:Array, param2:Function, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         if(param6 == 0 || param7 == 0)
         {
            return;
         }
         if(param6 + param7 == 2)
         {
            if(int(param2(param1[param4],param1[param3])) < 0)
            {
               ArraySort.swap(param1,param4,param3);
            }
            return;
         }
         if(param6 > param7)
         {
            _loc10_ = param6 >> 1;
            _loc8_ = param3 + _loc10_;
            _loc9_ = int(ArraySort.lower(param1,param2,param4,param5,_loc8_));
            _loc11_ = _loc9_ - param4;
         }
         else
         {
            _loc11_ = param7 >> 1;
            _loc9_ = param4 + _loc11_;
            _loc8_ = int(ArraySort.upper(param1,param2,param3,param4,_loc9_));
            _loc10_ = _loc8_ - param3;
         }
         ArraySort.rotate(param1,param2,_loc8_,param4,_loc9_);
         var _loc12_:* = _loc8_ + _loc11_;
         ArraySort.doMerge(param1,param2,param3,_loc8_,_loc12_,_loc10_,_loc11_);
         ArraySort.doMerge(param1,param2,_loc12_,_loc9_,param5,param6 - _loc10_,param7 - _loc11_);
      }
      
      public static function rotate(param1:Array, param2:Function, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:* = null as Object;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         if(param3 == param4 || param4 == param5)
         {
            return;
         }
         var _loc6_:int = ArraySort.gcd(param5 - param3,param4 - param3);
         while(_loc6_-- != 0)
         {
            _loc7_ = param1[param3 + _loc6_];
            _loc8_ = param4 - param3;
            _loc9_ = param3 + _loc6_;
            _loc10_ = param3 + _loc6_ + _loc8_;
            while(_loc10_ != param3 + _loc6_)
            {
               param1[_loc9_] = param1[_loc10_];
               _loc9_ = int(_loc10_);
               if(param5 - _loc10_ > _loc8_)
               {
                  _loc10_ += _loc8_;
               }
               else
               {
                  _loc10_ = param3 + (_loc8_ - (param5 - _loc10_));
               }
            }
            param1[_loc9_] = _loc7_;
         }
      }
      
      public static function gcd(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         while(param2 != 0)
         {
            _loc3_ = param1 % param2;
            param1 = param2;
            param2 = _loc3_;
         }
         return param1;
      }
      
      public static function upper(param1:Array, param2:Function, param3:int, param4:int, param5:int) : int
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc6_:* = param4 - param3;
         while(_loc6_ > 0)
         {
            _loc7_ = _loc6_ >> 1;
            _loc8_ = param3 + _loc7_;
            if(int(param2(param1[param5],param1[_loc8_])) < 0)
            {
               _loc6_ = int(_loc7_);
            }
            else
            {
               param3 = _loc8_ + 1;
               _loc6_ = _loc6_ - _loc7_ - 1;
            }
         }
         return param3;
      }
      
      public static function lower(param1:Array, param2:Function, param3:int, param4:int, param5:int) : int
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc6_:* = param4 - param3;
         while(_loc6_ > 0)
         {
            _loc7_ = _loc6_ >> 1;
            _loc8_ = param3 + _loc7_;
            if(int(param2(param1[_loc8_],param1[param5])) < 0)
            {
               param3 = _loc8_ + 1;
               _loc6_ = _loc6_ - _loc7_ - 1;
            }
            else
            {
               _loc6_ = int(_loc7_);
            }
         }
         return param3;
      }
      
      public static function swap(param1:Array, param2:int, param3:int) : void
      {
         var _loc4_:Object = param1[param2];
         param1[param2] = param1[param3];
         param1[param3] = _loc4_;
      }
   }
}
