package mapTools
{
   import tools.FpUtils;
   
   public class SpellZone
   {
      
      public static var DEFAULT_RADIUS:int = 1;
      
      public static var DEFAULT_MIN_RADIUS:int = 0;
      
      public static var DEFAULT_DEGRESSION:int = 10;
      
      public static var DEFAULT_MAX_DEGRESSION_TICKS:int = 4;
      
      public static var GLOBAL_RADIUS:int = 63;
      
      public static var MAX_RADIUS_DEGRESSION:int = 50;
       
      
      public var shape:String;
      
      public var radius:int;
      
      public var minRadius:int;
      
      public var maxDegressionTicks:int;
      
      public var isCellInZone:Function;
      
      public var getCells:Function;
      
      public var degression:int;
      
      public function SpellZone()
      {
         shape = "P";
         maxDegressionTicks = SpellZone.DEFAULT_MAX_DEGRESSION_TICKS;
         degression = SpellZone.DEFAULT_DEGRESSION;
         minRadius = SpellZone.DEFAULT_MIN_RADIUS;
         radius = SpellZone.DEFAULT_RADIUS;
      }
      
      public static function fromRawZone(param1:String) : SpellZone
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as String;
         var _loc7_:* = null as Object;
         if(param1 == null)
         {
            param1 = "P";
         }
         var _loc2_:SpellZone = new SpellZone();
         _loc2_.shape = param1.charAt(0);
         var _loc3_:Array = FpUtils.arrayFilter_String(param1.substr(1).split(","),function(param1:String):Boolean
         {
            return param1.length > 0;
         });
         var _loc4_:* = false;
         if(_loc2_.shape == ";")
         {
            var cells:Array = [];
            _loc5_ = 0;
            while(_loc5_ < int(_loc3_.length))
            {
               _loc6_ = _loc3_[_loc5_];
               _loc5_++;
               if(_loc6_.length > 0)
               {
                  _loc7_ = Std.parseInt(_loc6_);
                  cells.push(_loc7_);
               }
            }
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return cells;
            };
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return int(cells.indexOf(param1)) != -1;
            };
            return _loc2_;
         }
         if(_loc2_.shape == "l")
         {
            _loc6_ = _loc3_[0];
            _loc3_[0] = _loc3_[1];
            _loc3_[1] = _loc6_;
         }
         if(int(_loc3_.length) > 0)
         {
            _loc2_.radius = Std.parseInt(_loc3_[0]);
         }
         if(SpellZone.hasMinSize(_loc2_.shape))
         {
            if(int(_loc3_.length) > 1)
            {
               _loc2_.minRadius = Std.parseInt(_loc3_[1]);
            }
            if(int(_loc3_.length) > 2)
            {
               _loc2_.degression = Std.parseInt(_loc3_[2]);
            }
         }
         else
         {
            if(int(_loc3_.length) > 1)
            {
               _loc2_.degression = Std.parseInt(_loc3_[1]);
            }
            if(int(_loc3_.length) > 2)
            {
               _loc2_.maxDegressionTicks = Std.parseInt(_loc3_[2]);
            }
         }
         if(int(_loc3_.length) > 3)
         {
            _loc2_.maxDegressionTicks = Std.parseInt(_loc3_[3]);
         }
         if(int(_loc3_.length) > 4)
         {
            _loc4_ = Std.parseInt(_loc3_[4]) != 0;
         }
         _loc6_ = _loc2_.shape;
         if(_loc6_ == " ")
         {
            _loc2_.getCells = SpellZone.fillEmptyCells;
            _loc2_.isCellInZone = SpellZone.isCellInEmptyZone;
         }
         else if(_loc6_ == "#")
         {
            var zone1:SpellZone = _loc2_;
            var directions:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return SpellZone.fillCrossCells(zone1,directions,true,param1,param2);
            };
            var zone2:SpellZone = _loc2_;
            var directions1:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return Boolean(SpellZone.isCellInCrossZone(zone2,directions1,true,param1,param2,param3));
            };
         }
         else if(_loc6_ == "*")
         {
            var zone3:SpellZone = _loc2_;
            var directions2:Array = MapDirection.MAP_DIRECTIONS;
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return SpellZone.fillCrossCells(zone3,directions2,false,param1,param2);
            };
            var zone4:SpellZone = _loc2_;
            var directions3:Array = MapDirection.MAP_DIRECTIONS;
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return Boolean(SpellZone.isCellInCrossZone(zone4,directions3,false,param1,param2,param3));
            };
         }
         else if(_loc6_ == "+")
         {
            var zone5:SpellZone = _loc2_;
            var directions4:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return SpellZone.fillCrossCells(zone5,directions4,false,param1,param2);
            };
            var zone6:SpellZone = _loc2_;
            var directions5:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return Boolean(SpellZone.isCellInCrossZone(zone6,directions5,false,param1,param2,param3));
            };
         }
         else if(_loc6_ == "-")
         {
            var zone7:SpellZone = _loc2_;
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return SpellZone.fillPerpLineCells(zone7,param1,param2);
            };
            var zone8:SpellZone = _loc2_;
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return Boolean(SpellZone.isCellInPerpLineZone(zone8,param1,param2,param3));
            };
         }
         else if(_loc6_ == "/")
         {
            var zone9:SpellZone = _loc2_;
            var stopAtTarget1:Boolean = _loc4_;
            _loc2_.getCells = function(param1:int, param2:int):Array
            {
               return SpellZone.fillLineCells(zone9,stopAtTarget1,false,param1,param2);
            };
            var zone10:SpellZone = _loc2_;
            var stopAtTarget2:Boolean = _loc4_;
            _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
            {
               return Boolean(SpellZone.isCellInLineZone(zone10,stopAtTarget2,false,param1,param2,param3));
            };
         }
         else
         {
            if(_loc6_ != "A")
            {
               if(_loc6_ != "a")
               {
                  if(_loc6_ == "B")
                  {
                     var zone11:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillBoomerang(zone11,param1,param2);
                     };
                     var zone12:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInBoomerangZone(zone12,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "C")
                  {
                     var zone13:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCircleCells(zone13,param1,param2);
                     };
                     var zone14:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCircleZone(zone14,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "D")
                  {
                     var zone15:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCheckerboard(zone15,param1,param2);
                     };
                     var zone16:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCheckerboardZone(zone16,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "G")
                  {
                     var zone17:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillSquareCells(zone17,false,param1,param2);
                     };
                     var zone18:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInSquareZone(zone18,false,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "I")
                  {
                     _loc2_.minRadius = _loc2_.radius;
                     _loc2_.radius = SpellZone.GLOBAL_RADIUS;
                     var zone19:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCircleCells(zone19,param1,param2);
                     };
                     var zone20:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCircleZone(zone20,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "L")
                  {
                     var zone21:SpellZone = _loc2_;
                     var stopAtTarget3:Boolean = _loc4_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillLineCells(zone21,stopAtTarget3,false,param1,param2);
                     };
                     var zone22:SpellZone = _loc2_;
                     var stopAtTarget4:Boolean = _loc4_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInLineZone(zone22,stopAtTarget4,false,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "O")
                  {
                     _loc2_.minRadius = _loc2_.radius;
                     var zone23:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCircleCells(zone23,param1,param2);
                     };
                     var zone24:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCircleZone(zone24,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "P")
                  {
                     _loc2_.radius = 0;
                     _loc2_.getCells = SpellZone.fillPointCells;
                     _loc2_.isCellInZone = SpellZone.isCellInPointZone;
                  }
                  else if(_loc6_ == "Q")
                  {
                     var zone25:SpellZone = _loc2_;
                     var directions6:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCrossCells(zone25,directions6,true,param1,param2);
                     };
                     var zone26:SpellZone = _loc2_;
                     var directions7:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCrossZone(zone26,directions7,true,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "T")
                  {
                     var zone27:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillPerpLineCells(zone27,param1,param2);
                     };
                     var zone28:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInPerpLineZone(zone28,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "U")
                  {
                     var zone29:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillHalfCircle(zone29,param1,param2);
                     };
                     var zone30:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInHalfCircleZone(zone30,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "V")
                  {
                     var zone31:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillConeCells(zone31,param1,param2);
                     };
                     var zone32:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInConeZone(zone32,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "W")
                  {
                     var zone33:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillSquareCells(zone33,true,param1,param2);
                     };
                     var zone34:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInSquareZone(zone34,true,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "X")
                  {
                     var zone35:SpellZone = _loc2_;
                     var directions8:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillCrossCells(zone35,directions8,false,param1,param2);
                     };
                     var zone36:SpellZone = _loc2_;
                     var directions9:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInCrossZone(zone36,directions9,false,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "Z")
                  {
                     var zone37:SpellZone = _loc2_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillReversedTrueCircleCells(zone37,param1,param2);
                     };
                     var zone38:SpellZone = _loc2_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInReversedTrueCircleZone(zone38,param1,param2,param3));
                     };
                  }
                  else if(_loc6_ == "l")
                  {
                     var zone39:SpellZone = _loc2_;
                     var stopAtTarget5:Boolean = _loc4_;
                     _loc2_.getCells = function(param1:int, param2:int):Array
                     {
                        return SpellZone.fillLineCells(zone39,stopAtTarget5,true,param1,param2);
                     };
                     var zone40:SpellZone = _loc2_;
                     var stopAtTarget6:Boolean = _loc4_;
                     _loc2_.isCellInZone = function(param1:int, param2:int, param3:int):Boolean
                     {
                        return Boolean(SpellZone.isCellInLineZone(zone40,stopAtTarget6,true,param1,param2,param3));
                     };
                  }
                  else
                  {
                     _loc2_.shape = "P";
                     _loc2_.radius = 0;
                     _loc2_.getCells = SpellZone.fillPointCells;
                     _loc2_.isCellInZone = SpellZone.isCellInPointZone;
                  }
               }
               §§goto(addr670);
            }
            _loc2_.getCells = SpellZone.fillWholeMap;
            _loc2_.isCellInZone = SpellZone.isCellInWholeMapZone;
         }
         addr670:
         return _loc2_;
      }
      
      public static function fillPointCells(param1:int, param2:int) : Array
      {
         if(!MapTools.isValidCellId(param1))
         {
            return [];
         }
         return [param1];
      }
      
      public static function isCellInPointZone(param1:int, param2:int, param3:int) : Boolean
      {
         return param1 == param2;
      }
      
      public static function fillEmptyCells(param1:int, param2:int) : Array
      {
         return [];
      }
      
      public static function isCellInEmptyZone(param1:int, param2:int, param3:int) : Boolean
      {
         return false;
      }
      
      public static function fillCircleCells(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Point = MapTools.getCellCoordById(param2);
         var _loc6_:int = -param1.radius;
         var _loc7_:* = param1.radius + 1;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc6_++;
            _loc9_ = -param1.radius;
            _loc10_ = param1.radius + 1;
            while(_loc9_ < _loc10_)
            {
               _loc11_ = _loc9_++;
               if(!!MapTools.isValidCoord(_loc5_.x + _loc8_,_loc5_.y + _loc11_) && Number(Number(Math.abs(_loc8_)) + Number(Math.abs(_loc11_))) <= param1.radius && Number(Number(Math.abs(_loc8_)) + Number(Math.abs(_loc11_))) >= param1.minRadius)
               {
                  _loc4_.push(int(MapTools.getCellIdByCoord(_loc5_.x + _loc8_,_loc5_.y + _loc11_)));
               }
            }
         }
         return _loc4_;
      }
      
      public static function isCellInCircleZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = MapTools.getDistance(param2,param3);
         if(_loc5_ <= param1.radius)
         {
            return _loc5_ >= param1.minRadius;
         }
         return false;
      }
      
      public static function fillCheckerboard(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Point = MapTools.getCellCoordById(param2);
         var _loc6_:* = int(param1.radius % 2) == 0;
         var _loc7_:int = -param1.radius;
         var _loc8_:* = param1.radius + 1;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc7_++;
            _loc10_ = -param1.radius;
            _loc11_ = param1.radius + 1;
            while(_loc10_ < _loc11_)
            {
               _loc12_ = _loc10_++;
               if(!!MapTools.isValidCoord(_loc5_.x + _loc9_,_loc5_.y + _loc12_) && Number(Number(Math.abs(_loc9_)) + Number(Math.abs(_loc12_))) <= param1.radius && Number(Number(Math.abs(_loc9_)) + Number(Math.abs(_loc12_))) >= param1.minRadius && (!!_loc6_ && int((_loc9_ + int(_loc12_ % 2)) % 2) == 0 || !_loc6_ && int((_loc9_ + 1 + int(_loc12_ % 2)) % 2) == 0))
               {
                  _loc4_.push(int(MapTools.getCellIdByCoord(_loc5_.x + _loc9_,_loc5_.y + _loc12_)));
               }
            }
         }
         return _loc4_;
      }
      
      public static function isCellInCheckerboardZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = MapTools.getDistance(param2,param3);
         var _loc6_:* = int(param1.radius % 2) == 0;
         var _loc7_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc8_:int = Math.floor((_loc7_ + 1) / 2);
         var _loc9_:* = param2 - _loc7_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:* = _loc8_ + _loc9_;
         var _loc11_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc12_:int = Math.floor((_loc11_ + 1) / 2);
         var _loc13_:* = _loc11_ - _loc12_;
         var _loc14_:* = param2 - _loc11_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:* = _loc14_ - _loc13_;
         if(_loc5_ >= param1.minRadius)
         {
            if(!(!!_loc6_ && int((_loc10_ + int(_loc15_ % 2)) % 2) == 0))
            {
               if(!_loc6_)
               {
                  return int((_loc10_ + 1 + int(_loc15_ % 2)) % 2) == 0;
               }
               return false;
            }
            return true;
         }
         return false;
      }
      
      public static function fillLineCells(param1:SpellZone, param2:Boolean, param3:Boolean, param4:int, param5:int) : Array
      {
         var _loc24_:int = 0;
         var _loc26_:int = 0;
         var _loc6_:Array = [];
         var _loc7_:int = !!param3 ? param5 : param4;
         var _loc8_:int = !!param3 ? param1.radius + param1.minRadius - 1 : param1.radius;
         var _loc9_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc10_:int = Math.floor((_loc9_ + 1) / 2);
         var _loc11_:* = param5 - _loc9_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = _loc12_ - _loc13_;
         var _loc15_:* = param5 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc16_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc17_:int = Math.floor((_loc16_ + 1) / 2);
         var _loc18_:* = param4 - _loc16_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc20_:int = Math.floor((_loc19_ + 1) / 2);
         var _loc21_:* = _loc19_ - _loc20_;
         var _loc22_:* = param4 - _loc19_ * MapTools.MAP_GRID_WIDTH;
         var _loc23_:int = MapTools.getLookDirection8ExactByCoord(_loc10_ + _loc11_,_loc15_ - _loc14_,_loc17_ + _loc18_,_loc22_ - _loc21_);
         if(!!param3 && param2)
         {
            _loc24_ = MapTools.getDistance(param5,param4);
            if(_loc24_ < _loc8_)
            {
               _loc8_ = _loc24_;
            }
         }
         _loc24_ = 0;
         var _loc25_:* = int(param1.minRadius);
         while(_loc24_ < _loc25_)
         {
            _loc26_ = _loc24_++;
            _loc7_ = MapTools.getNextCellByDirection(_loc7_,_loc23_);
         }
         _loc24_ = param1.minRadius;
         _loc25_ = _loc8_ + 1;
         while(_loc24_ < _loc25_)
         {
            _loc26_ = _loc24_++;
            if(MapTools.isValidCellId(_loc7_))
            {
               _loc6_.push(_loc7_);
            }
            _loc7_ = MapTools.getNextCellByDirection(_loc7_,_loc23_);
         }
         return _loc6_;
      }
      
      public static function isCellInLineZone(param1:SpellZone, param2:Boolean, param3:Boolean, param4:int, param5:int, param6:int) : Boolean
      {
         var _loc23_:int = 0;
         var _loc24_:* = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:int = 0;
         var _loc33_:int = 0;
         var _loc34_:* = 0;
         var _loc35_:int = 0;
         var _loc36_:int = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:int = 0;
         if(param6 == param4)
         {
            return false;
         }
         var _loc7_:int = Math.floor(param6 / MapTools.MAP_GRID_WIDTH);
         var _loc8_:int = Math.floor((_loc7_ + 1) / 2);
         var _loc9_:* = param6 - _loc7_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param6 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = _loc10_ - _loc11_;
         var _loc13_:* = param6 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc14_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc15_:int = Math.floor((_loc14_ + 1) / 2);
         var _loc16_:* = param5 - _loc14_ * MapTools.MAP_GRID_WIDTH;
         var _loc17_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc18_:int = Math.floor((_loc17_ + 1) / 2);
         var _loc19_:* = _loc17_ - _loc18_;
         var _loc20_:* = param5 - _loc17_ * MapTools.MAP_GRID_WIDTH;
         var _loc21_:int = MapTools.getLookDirection8ExactByCoord(_loc8_ + _loc9_,_loc13_ - _loc12_,_loc15_ + _loc16_,_loc20_ - _loc19_);
         var _loc22_:int = param1.radius;
         if(param3)
         {
            _loc25_ = Math.floor(param6 / MapTools.MAP_GRID_WIDTH);
            _loc26_ = Math.floor((_loc25_ + 1) / 2);
            _loc27_ = param6 - _loc25_ * MapTools.MAP_GRID_WIDTH;
            _loc28_ = Math.floor(param6 / MapTools.MAP_GRID_WIDTH);
            _loc29_ = Math.floor((_loc28_ + 1) / 2);
            _loc30_ = _loc28_ - _loc29_;
            _loc31_ = param6 - _loc28_ * MapTools.MAP_GRID_WIDTH;
            _loc32_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc33_ = Math.floor((_loc32_ + 1) / 2);
            _loc34_ = param4 - _loc32_ * MapTools.MAP_GRID_WIDTH;
            _loc35_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc36_ = Math.floor((_loc35_ + 1) / 2);
            _loc37_ = _loc35_ - _loc36_;
            _loc38_ = param4 - _loc35_ * MapTools.MAP_GRID_WIDTH;
            _loc23_ = MapTools.getLookDirection8ExactByCoord(_loc26_ + _loc27_,_loc31_ - _loc30_,_loc33_ + _loc34_,_loc38_ - _loc37_);
            _loc24_ = int(MapTools.getDistance(param6,param4));
            if(param2)
            {
               _loc39_ = MapTools.getDistance(param6,param5);
               if(_loc39_ < _loc22_)
               {
                  _loc22_ = _loc39_;
               }
            }
         }
         else
         {
            _loc25_ = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
            _loc26_ = Math.floor((_loc25_ + 1) / 2);
            _loc27_ = param5 - _loc25_ * MapTools.MAP_GRID_WIDTH;
            _loc28_ = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
            _loc29_ = Math.floor((_loc28_ + 1) / 2);
            _loc30_ = _loc28_ - _loc29_;
            _loc31_ = param5 - _loc28_ * MapTools.MAP_GRID_WIDTH;
            _loc32_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc33_ = Math.floor((_loc32_ + 1) / 2);
            _loc34_ = param4 - _loc32_ * MapTools.MAP_GRID_WIDTH;
            _loc35_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc36_ = Math.floor((_loc35_ + 1) / 2);
            _loc37_ = _loc35_ - _loc36_;
            _loc38_ = param4 - _loc35_ * MapTools.MAP_GRID_WIDTH;
            _loc23_ = MapTools.getLookDirection8ExactByCoord(_loc26_ + _loc27_,_loc31_ - _loc30_,_loc33_ + _loc34_,_loc38_ - _loc37_);
            _loc24_ = int(MapTools.getDistance(param5,param4));
         }
         if(!!MapDirection.isCardinal(_loc23_) && _loc24_ > 1)
         {
            _loc24_ >>= 1;
         }
         if((_loc21_ == _loc23_ || _loc24_ == 0) && _loc24_ >= param1.minRadius)
         {
            return _loc24_ <= _loc22_;
         }
         return false;
      }
      
      public static function fillCrossCells(param1:SpellZone, param2:Array, param3:Boolean, param4:int, param5:int) : Array
      {
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc6_:Array = [];
         var _loc7_:int = param1.minRadius;
         if(param1.minRadius == 0)
         {
            _loc7_ = 1;
            if(!param3)
            {
               _loc6_.push(param4);
            }
         }
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         var _loc10_:* = int(param2.length);
         while(_loc9_ < _loc10_)
         {
            _loc11_ = _loc9_++;
            _loc8_.push(param4);
         }
         var _loc12_:Array = _loc8_;
         _loc9_ = 1;
         _loc10_ = param1.radius + 1;
         while(_loc9_ < _loc10_)
         {
            _loc11_ = _loc9_++;
            _loc13_ = 0;
            _loc14_ = param2.length;
            while(_loc13_ < _loc14_)
            {
               _loc15_ = _loc13_++;
               _loc12_[_loc15_] = int(MapTools.getNextCellByDirection(int(_loc12_[_loc15_]),int(param2[_loc15_])));
               if(_loc11_ >= _loc7_ && MapTools.isValidCellId(int(_loc12_[_loc15_])))
               {
                  _loc6_.push(int(_loc12_[_loc15_]));
               }
            }
         }
         return _loc6_;
      }
      
      public static function isCellInCrossZone(param1:SpellZone, param2:Array, param3:Boolean, param4:int, param5:int, param6:int) : Boolean
      {
         var _loc7_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc8_:int = Math.floor((_loc7_ + 1) / 2);
         var _loc9_:* = param5 - _loc7_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param5 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = _loc10_ - _loc11_;
         var _loc13_:* = param5 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc14_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc15_:int = Math.floor((_loc14_ + 1) / 2);
         var _loc16_:* = param4 - _loc14_ * MapTools.MAP_GRID_WIDTH;
         var _loc17_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc18_:int = Math.floor((_loc17_ + 1) / 2);
         var _loc19_:* = _loc17_ - _loc18_;
         var _loc20_:* = param4 - _loc17_ * MapTools.MAP_GRID_WIDTH;
         var _loc21_:int = MapTools.getLookDirection8ExactByCoord(_loc8_ + _loc9_,_loc13_ - _loc12_,_loc15_ + _loc16_,_loc20_ - _loc19_);
         var _loc22_:* = int(MapTools.getDistance(param5,param4));
         if(!!MapDirection.isCardinal(_loc21_) && _loc22_ > 1)
         {
            _loc22_ >>= 1;
         }
         if((int(param2.indexOf(_loc21_)) != -1 || _loc22_ == 0) && _loc22_ >= param1.minRadius + (!!param3 && param1.minRadius == 0 ? 1 : 0))
         {
            return _loc22_ <= param1.radius;
         }
         return false;
      }
      
      public static function fillPerpLineCells(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc27_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 2) % 8;
         var _loc21_:int = (_loc19_ - 2 + 8) % 8;
         var _loc22_:int = param1.minRadius;
         if(param1.minRadius == 0)
         {
            _loc22_ = 1;
            if(MapTools.isValidCellId(param2))
            {
               _loc4_.push(param2);
            }
         }
         var _loc23_:int = param2;
         var _loc24_:int = param2;
         var _loc25_:int = _loc22_;
         var _loc26_:* = param1.radius + 1;
         while(_loc25_ < _loc26_)
         {
            _loc27_ = _loc25_++;
            _loc23_ = MapTools.getNextCellByDirection(_loc23_,_loc20_);
            _loc24_ = MapTools.getNextCellByDirection(_loc24_,_loc21_);
            if(MapTools.isValidCellId(_loc23_))
            {
               _loc4_.push(_loc23_);
            }
            if(MapTools.isValidCellId(_loc24_))
            {
               _loc4_.push(_loc24_);
            }
         }
         return _loc4_;
      }
      
      public static function isCellInPerpLineZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 2) % 8;
         var _loc21_:int = (_loc19_ - 2 + 8) % 8;
         var _loc22_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc23_:int = Math.floor((_loc22_ + 1) / 2);
         var _loc24_:* = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH;
         var _loc25_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc26_:int = Math.floor((_loc25_ + 1) / 2);
         var _loc27_:* = _loc25_ - _loc26_;
         var _loc28_:* = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH;
         var _loc29_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc30_:int = Math.floor((_loc29_ + 1) / 2);
         var _loc31_:* = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH;
         var _loc32_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc33_:int = Math.floor((_loc32_ + 1) / 2);
         var _loc34_:* = _loc32_ - _loc33_;
         var _loc35_:* = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH;
         var _loc36_:int = MapTools.getLookDirection8ExactByCoord(_loc23_ + _loc24_,_loc28_ - _loc27_,_loc30_ + _loc31_,_loc35_ - _loc34_);
         var _loc37_:* = int(MapTools.getDistance(param3,param2));
         if(!!MapDirection.isCardinal(_loc36_) && _loc37_ > 1)
         {
            _loc37_ >>= 1;
         }
         if((_loc36_ == _loc20_ || _loc36_ == _loc21_ || _loc37_ == 0) && _loc37_ >= param1.minRadius)
         {
            return _loc37_ <= param1.radius;
         }
         return false;
      }
      
      public static function fillConeCells(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 2) % 8;
         var _loc21_:int = (_loc19_ - 2 + 8) % 8;
         var _loc22_:int = param2;
         var _loc23_:int = 0;
         var _loc24_:* = param1.radius + 1;
         while(_loc23_ < _loc24_)
         {
            _loc25_ = _loc23_++;
            _loc4_.push(_loc22_);
            _loc26_ = _loc22_;
            _loc27_ = _loc22_;
            _loc28_ = 0;
            _loc29_ = _loc25_;
            while(_loc28_ < _loc29_)
            {
               _loc30_ = _loc28_++;
               _loc26_ = MapTools.getNextCellByDirection(_loc26_,_loc20_);
               _loc27_ = MapTools.getNextCellByDirection(_loc27_,_loc21_);
               if(MapTools.isValidCellId(_loc26_))
               {
                  _loc4_.push(_loc26_);
               }
               if(MapTools.isValidCellId(_loc27_))
               {
                  _loc4_.push(_loc27_);
               }
            }
            _loc22_ = MapTools.getNextCellByDirection(_loc22_,_loc19_);
         }
         return _loc4_;
      }
      
      public static function isCellInConeZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = MapTools.getLookDirection4(param4,param3);
         var _loc6_:Point = MapTools.getCellCoordById(param3);
         var _loc7_:Point = MapTools.getCellCoordById(param2);
         var _loc8_:* = _loc7_.x - _loc6_.x;
         var _loc9_:* = _loc7_.y - _loc6_.y;
         var _loc10_:Function = function(param1:int):int
         {
            if(param1 < 0)
            {
               return -param1;
            }
            return param1;
         };
         switch(_loc5_)
         {
            case 1:
               if(_loc8_ >= 0 && _loc8_ <= param1.radius)
               {
                  return int(_loc10_(_loc9_)) <= _loc8_;
               }
               return false;
               break;
            case 3:
               if(_loc9_ <= 0 && _loc9_ >= -param1.radius)
               {
                  return int(_loc10_(_loc8_)) <= -_loc9_;
               }
               return false;
               break;
            case 5:
               if(_loc8_ <= 0 && _loc8_ >= -param1.radius)
               {
                  return int(_loc10_(_loc9_)) <= -_loc8_;
               }
               return false;
               break;
            case 7:
               if(_loc9_ >= 0 && _loc9_ <= param1.radius)
               {
                  return int(_loc10_(_loc8_)) <= _loc9_;
               }
               return false;
               break;
            default:
               return false;
         }
      }
      
      public static function fillSquareCells(param1:SpellZone, param2:Boolean, param3:int, param4:int) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:Point = MapTools.getCellCoordById(param3);
         var _loc7_:int = -param1.radius;
         var _loc8_:* = param1.radius + 1;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc7_++;
            _loc10_ = -param1.radius;
            _loc11_ = param1.radius + 1;
            while(_loc10_ < _loc11_)
            {
               _loc12_ = _loc10_++;
               if(!!MapTools.isValidCoord(_loc6_.x + _loc9_,_loc6_.y + _loc12_) && (!param2 || Number(Math.abs(_loc9_)) != Number(Math.abs(_loc12_))))
               {
                  _loc5_.push(int(MapTools.getCellIdByCoord(_loc6_.x + _loc9_,_loc6_.y + _loc12_)));
               }
            }
         }
         return _loc5_;
      }
      
      public static function isCellInSquareZone(param1:SpellZone, param2:Boolean, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc6_:Point = MapTools.getCellCoordById(param4);
         var _loc7_:Point = MapTools.getCellCoordById(param3);
         var _loc8_:Function = function(param1:int):int
         {
            if(param1 < 0)
            {
               return -param1;
            }
            return param1;
         };
         var _loc9_:int = _loc8_(_loc7_.x - _loc6_.x);
         var _loc10_:int = _loc8_(_loc7_.y - _loc6_.y);
         if((!param2 || _loc9_ != _loc10_) && _loc9_ <= param1.radius && _loc10_ <= param1.radius && _loc9_ >= param1.minRadius)
         {
            return _loc10_ >= param1.minRadius;
         }
         return false;
      }
      
      public static function fillHalfCircle(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc27_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 3) % 8;
         var _loc21_:int = (_loc19_ - 3 + 8) % 8;
         var _loc22_:int = param1.minRadius;
         if(param1.minRadius == 0)
         {
            _loc22_ = 1;
            _loc4_.push(param2);
         }
         var _loc23_:int = param2;
         var _loc24_:int = param2;
         var _loc25_:int = _loc22_;
         var _loc26_:* = param1.radius + 1;
         while(_loc25_ < _loc26_)
         {
            _loc27_ = _loc25_++;
            _loc23_ = MapTools.getNextCellByDirection(_loc23_,_loc20_);
            _loc24_ = MapTools.getNextCellByDirection(_loc24_,_loc21_);
            if(MapTools.isValidCellId(_loc23_))
            {
               _loc4_.push(_loc23_);
            }
            if(MapTools.isValidCellId(_loc24_))
            {
               _loc4_.push(_loc24_);
            }
         }
         return _loc4_;
      }
      
      public static function isCellInHalfCircleZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ - 3 + 8) % 8;
         var _loc21_:int = (_loc19_ + 3) % 8;
         var _loc22_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc23_:int = Math.floor((_loc22_ + 1) / 2);
         var _loc24_:* = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH;
         var _loc25_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc26_:int = Math.floor((_loc25_ + 1) / 2);
         var _loc27_:* = _loc25_ - _loc26_;
         var _loc28_:* = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH;
         var _loc29_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc30_:int = Math.floor((_loc29_ + 1) / 2);
         var _loc31_:* = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH;
         var _loc32_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc33_:int = Math.floor((_loc32_ + 1) / 2);
         var _loc34_:* = _loc32_ - _loc33_;
         var _loc35_:* = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH;
         var _loc36_:int = MapTools.getLookDirection8ExactByCoord(_loc23_ + _loc24_,_loc28_ - _loc27_,_loc30_ + _loc31_,_loc35_ - _loc34_);
         var _loc37_:* = int(MapTools.getDistance(param3,param2));
         if(!!MapDirection.isCardinal(_loc36_) && _loc37_ > 1)
         {
            _loc37_ >>= 1;
         }
         if((_loc20_ == _loc36_ || _loc21_ == _loc36_ || _loc37_ == 0) && _loc37_ <= param1.radius)
         {
            return _loc37_ >= param1.minRadius;
         }
         return false;
      }
      
      public static function fillBoomerang(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc29_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 2) % 8;
         var _loc21_:int = (_loc19_ + 3) % 8;
         var _loc22_:int = (_loc19_ - 2 + 8) % 8;
         var _loc23_:int = (_loc19_ - 3 + 8) % 8;
         var _loc24_:int = param1.minRadius;
         if(param1.minRadius == 0)
         {
            _loc24_ = 1;
            _loc4_.push(param2);
         }
         var _loc25_:int = param2;
         var _loc26_:int = param2;
         var _loc27_:int = _loc24_;
         var _loc28_:int = param1.radius;
         while(_loc27_ < _loc28_)
         {
            _loc29_ = _loc27_++;
            _loc25_ = MapTools.getNextCellByDirection(_loc25_,_loc20_);
            _loc26_ = MapTools.getNextCellByDirection(_loc26_,_loc22_);
            if(MapTools.isValidCellId(_loc25_))
            {
               _loc4_.push(_loc25_);
            }
            if(MapTools.isValidCellId(_loc26_))
            {
               _loc4_.push(_loc26_);
            }
         }
         if(param1.radius != 0)
         {
            _loc25_ = MapTools.getNextCellByDirection(_loc25_,_loc21_);
            _loc26_ = MapTools.getNextCellByDirection(_loc26_,_loc23_);
            if(MapTools.isValidCellId(_loc25_))
            {
               _loc4_.push(_loc25_);
            }
            if(MapTools.isValidCellId(_loc26_))
            {
               _loc4_.push(_loc26_);
            }
         }
         return _loc4_;
      }
      
      public static function isCellInBoomerangZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc6_:int = Math.floor((_loc5_ + 1) / 2);
         var _loc7_:* = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH;
         var _loc8_:int = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
         var _loc9_:int = Math.floor((_loc8_ + 1) / 2);
         var _loc10_:* = _loc8_ - _loc9_;
         var _loc11_:* = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH;
         var _loc12_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc16_:int = Math.floor((_loc15_ + 1) / 2);
         var _loc17_:* = _loc15_ - _loc16_;
         var _loc18_:* = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH;
         var _loc19_:int = MapTools.getLookDirection8ExactByCoord(_loc6_ + _loc7_,_loc11_ - _loc10_,_loc13_ + _loc14_,_loc18_ - _loc17_);
         var _loc20_:int = (_loc19_ + 2) % 8;
         var _loc21_:int = (_loc19_ - 2 + 8) % 8;
         var _loc22_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc23_:int = Math.floor((_loc22_ + 1) / 2);
         var _loc24_:* = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH;
         var _loc25_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc26_:int = Math.floor((_loc25_ + 1) / 2);
         var _loc27_:* = _loc25_ - _loc26_;
         var _loc28_:* = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH;
         var _loc29_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc30_:int = Math.floor((_loc29_ + 1) / 2);
         var _loc31_:* = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH;
         var _loc32_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc33_:int = Math.floor((_loc32_ + 1) / 2);
         var _loc34_:* = _loc32_ - _loc33_;
         var _loc35_:* = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH;
         var _loc36_:int = MapTools.getLookDirection8ExactByCoord(_loc23_ + _loc24_,_loc28_ - _loc27_,_loc30_ + _loc31_,_loc35_ - _loc34_);
         var _loc37_:* = int(MapTools.getDistance(param3,param2));
         if(!!MapDirection.isCardinal(_loc36_) && _loc37_ > 1)
         {
            _loc37_ >>= 1;
         }
         if((_loc36_ == _loc20_ || _loc36_ == _loc21_ || _loc37_ == 0) && _loc37_ >= param1.minRadius && _loc37_ < param1.radius)
         {
            return true;
         }
         param2 = MapTools.getNextCellByDirection(param2,_loc19_);
         var _loc38_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc39_:int = Math.floor((_loc38_ + 1) / 2);
         var _loc40_:* = param3 - _loc38_ * MapTools.MAP_GRID_WIDTH;
         var _loc41_:int = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
         var _loc42_:int = Math.floor((_loc41_ + 1) / 2);
         var _loc43_:* = _loc41_ - _loc42_;
         var _loc44_:* = param3 - _loc41_ * MapTools.MAP_GRID_WIDTH;
         var _loc45_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc46_:int = Math.floor((_loc45_ + 1) / 2);
         var _loc47_:* = param2 - _loc45_ * MapTools.MAP_GRID_WIDTH;
         var _loc48_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc49_:int = Math.floor((_loc48_ + 1) / 2);
         var _loc50_:* = _loc48_ - _loc49_;
         var _loc51_:* = param2 - _loc48_ * MapTools.MAP_GRID_WIDTH;
         _loc36_ = MapTools.getLookDirection8ExactByCoord(_loc39_ + _loc40_,_loc44_ - _loc43_,_loc46_ + _loc47_,_loc51_ - _loc50_);
         _loc37_ = int(MapTools.getDistance(param3,param2));
         if(!!MapDirection.isCardinal(_loc36_) && _loc37_ > 1)
         {
            _loc37_ >>= 1;
         }
         if((_loc36_ == _loc20_ || _loc36_ == _loc21_) && _loc37_ != 0 && _loc37_ >= param1.minRadius)
         {
            return _loc37_ == param1.radius;
         }
         return false;
      }
      
      public static function fillWholeMap(param1:int, param2:int) : Array
      {
         return MapTools.EVERY_CELL_ID;
      }
      
      public static function isCellInWholeMapZone(param1:int, param2:int, param3:int) : Boolean
      {
         return true;
      }
      
      public static function fillReversedTrueCircleCells(param1:SpellZone, param2:int, param3:int) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:* = null as Point;
         var _loc11_:* = null as Point;
         var _loc4_:Array = [];
         var _loc5_:Point = MapTools.getCellCoordById(param2);
         §§push(param1.radius);
         if(!(param1.radius is Number))
         {
            throw "Class cast error";
         }
         var _loc6_:Number = §§pop();
         var _loc7_:int = 0;
         var _loc8_:int = MapTools.mapCountCell;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc7_++;
            _loc10_ = MapTools.getCellCoordById(_loc9_);
            _loc11_ = new Point(_loc10_.x - _loc5_.x,_loc10_.y - _loc5_.y);
            if(Number(Math.sqrt(_loc11_.x * _loc11_.x + _loc11_.y * _loc11_.y)) >= _loc6_)
            {
               _loc4_.push(_loc9_);
            }
         }
         return _loc4_;
      }
      
      public static function isCellInReversedTrueCircleZone(param1:SpellZone, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:Point = MapTools.getCellCoordById(param3);
         var _loc6_:Point = MapTools.getCellCoordById(param2);
         var _loc7_:Point = new Point(_loc6_.x - _loc5_.x,_loc6_.y - _loc5_.y);
         return Number(Math.sqrt(_loc7_.x * _loc7_.x + _loc7_.y * _loc7_.y)) >= param1.radius;
      }
      
      public static function hasMinSize(param1:String) : Boolean
      {
         var _loc2_:String = param1;
         if(_loc2_ != "#")
         {
            if(_loc2_ != "+")
            {
               if(_loc2_ != "C")
               {
                  if(_loc2_ != "Q")
                  {
                     if(_loc2_ != "X")
                     {
                        if(_loc2_ != "l")
                        {
                           return false;
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public function getAOEMalus(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:* = 0;
         var _loc6_:* = null as Point;
         var _loc7_:* = null as Point;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:int = 0;
         if(radius > SpellZone.MAX_RADIUS_DEGRESSION)
         {
            return 0;
         }
         var _loc5_:String = shape;
         if(_loc5_ != ";")
         {
            if(_loc5_ != "A")
            {
               if(_loc5_ != "I")
               {
                  if(_loc5_ == "a")
                  {
                     addr63:
                     _loc4_ = 0;
                  }
                  else
                  {
                     if(_loc5_ != "G")
                     {
                        if(_loc5_ != "W")
                        {
                           if(_loc5_ != "#")
                           {
                              if(_loc5_ != "+")
                              {
                                 if(_loc5_ != "-")
                                 {
                                    if(_loc5_ != "/")
                                    {
                                       if(_loc5_ != "U")
                                       {
                                          if(_loc5_ == "V")
                                          {
                                             _loc8_ = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
                                             _loc9_ = Math.floor((_loc8_ + 1) / 2);
                                             _loc10_ = param2 - _loc8_ * MapTools.MAP_GRID_WIDTH;
                                             _loc11_ = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
                                             _loc12_ = Math.floor((_loc11_ + 1) / 2);
                                             _loc13_ = _loc11_ - _loc12_;
                                             _loc14_ = param2 - _loc11_ * MapTools.MAP_GRID_WIDTH;
                                             _loc15_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
                                             _loc16_ = Math.floor((_loc15_ + 1) / 2);
                                             _loc17_ = param1 - _loc15_ * MapTools.MAP_GRID_WIDTH;
                                             _loc18_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
                                             _loc19_ = Math.floor((_loc18_ + 1) / 2);
                                             _loc20_ = _loc18_ - _loc19_;
                                             _loc21_ = param1 - _loc18_ * MapTools.MAP_GRID_WIDTH;
                                             _loc22_ = MapTools.getLookDirection8ExactByCoord(_loc9_ + _loc10_,_loc14_ - _loc13_,_loc16_ + _loc17_,_loc21_ - _loc20_);
                                             _loc6_ = MapTools.getCellCoordById(param1);
                                             _loc7_ = MapTools.getCellCoordById(param3);
                                             switch(_loc22_)
                                             {
                                                case 0:
                                                case 4:
                                                   §§push(Number(Math.abs(Number(Number(Math.abs(_loc6_.x - _loc6_.y)) + Number(Math.abs(_loc7_.x - _loc7_.y))))));
                                                   if(!(Number(Math.abs(Number(Number(Math.abs(_loc6_.x - _loc6_.y)) + Number(Math.abs(_loc7_.x - _loc7_.y))))) is Number))
                                                   {
                                                      throw "Class cast error";
                                                   }
                                                   _loc4_ = int(§§pop());
                                                   break;
                                                case 1:
                                                case 5:
                                                   §§push(Number(Math.abs(_loc6_.x - _loc7_.x)));
                                                   if(!(Number(Math.abs(_loc6_.x - _loc7_.x)) is Number))
                                                   {
                                                      throw "Class cast error";
                                                   }
                                                   _loc4_ = int(§§pop());
                                                   break;
                                                case 2:
                                                case 6:
                                                   §§push(Number(Math.abs(Math.abs(_loc6_.x - _loc6_.y) - Math.abs(_loc7_.x - _loc7_.y))));
                                                   if(!(Number(Math.abs(Math.abs(_loc6_.x - _loc6_.y) - Math.abs(_loc7_.x - _loc7_.y))) is Number))
                                                   {
                                                      throw "Class cast error";
                                                   }
                                                   _loc4_ = int(§§pop());
                                                   break;
                                                case 3:
                                                case 7:
                                                   §§push(Number(Math.abs(_loc6_.y - _loc7_.y)));
                                                   if(!(Number(Math.abs(_loc6_.y - _loc7_.y)) is Number))
                                                   {
                                                      throw "Class cast error";
                                                   }
                                                   _loc4_ = int(§§pop());
                                                   break;
                                                default:
                                                   _loc4_ = 0;
                                             }
                                             addr384:
                                             if(_loc4_ < 0)
                                             {
                                                _loc4_ = 0;
                                             }
                                             §§push(Number(Math.min(Math.min(_loc4_ - minRadius,maxDegressionTicks) * degression,100)));
                                             if(!(Number(Math.min(Math.min(_loc4_ - minRadius,maxDegressionTicks) * degression,100)) is Number))
                                             {
                                                throw "Class cast error";
                                             }
                                             return §§pop();
                                          }
                                          _loc4_ = int(MapTools.getDistance(param1,param3));
                                          §§goto(addr384);
                                       }
                                       §§goto(addr384);
                                    }
                                 }
                              }
                           }
                           _loc4_ = int(MapTools.getDistance(param1,param3)) >> 1;
                        }
                        §§goto(addr384);
                     }
                     _loc6_ = MapTools.getCellCoordById(param1);
                     _loc7_ = MapTools.getCellCoordById(param3);
                     §§push(Number(Math.abs(_loc6_.x - _loc7_.x)));
                     if(!(Number(Math.abs(_loc6_.x - _loc7_.x)) is Number))
                     {
                        throw "Class cast error";
                     }
                     _loc8_ = §§pop();
                     §§push(Number(Math.abs(_loc6_.y - _loc7_.y)));
                     if(!(Number(Math.abs(_loc6_.y - _loc7_.y)) is Number))
                     {
                        throw "Class cast error";
                     }
                     _loc9_ = §§pop();
                     _loc4_ = int(_loc8_ > _loc9_ ? _loc8_ : _loc9_);
                  }
                  §§goto(addr384);
               }
            }
         }
         §§goto(addr63);
      }
   }
}
