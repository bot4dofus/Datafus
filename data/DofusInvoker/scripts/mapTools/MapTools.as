package mapTools
{
   import damageCalculation.FightContext;
   import flash.geom.Point;
   import tools.FpUtils;
   
   public class MapTools
   {
      
      public static var MAP_GRID_WIDTH:int;
      
      public static var MAP_GRID_HEIGHT:int;
      
      public static var MIN_X_COORD:int;
      
      public static var MAX_X_COORD:int;
      
      public static var MIN_Y_COORD:int;
      
      public static var MAX_Y_COORD:int;
      
      public static var EVERY_CELL_ID:Array;
      
      public static var mapCountCell:int;
      
      public static var isInit:Boolean = false;
      
      public static var INVALID_CELL_ID:int = -1;
      
      public static var PSEUDO_INFINITE:int = 63;
      
      public static var COEFF_FOR_REBASE_ON_CLOSEST_8_DIRECTION:Number = Number(Math.tan(Math.PI / 8));
      
      public static var COORDINATES_DIRECTION:Array = _loc1_;
       
      
      public function MapTools()
      {
      }
      
      public static function init(param1:MapToolsConfig) : void
      {
         var _loc5_:int = 0;
         MapTools.MAP_GRID_WIDTH = param1.mapGridWidth;
         MapTools.MAP_GRID_HEIGHT = param1.mapGridHeight;
         MapTools.MIN_X_COORD = param1.minXCoord;
         MapTools.MAX_X_COORD = param1.maxXCoord;
         MapTools.MIN_Y_COORD = param1.minYCoord;
         MapTools.MAX_Y_COORD = param1.maxYCoord;
         MapTools.mapCountCell = MapTools.MAP_GRID_WIDTH * MapTools.MAP_GRID_HEIGHT * 2;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         var _loc4_:int = MapTools.mapCountCell;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc2_.push(_loc5_);
         }
         MapTools.EVERY_CELL_ID = _loc2_;
         MapTools.isInit = true;
      }
      
      public static function getCellCoordById(param1:int) : mapTools.Point
      {
         if(!MapTools.isValidCellId(param1))
         {
            return null;
         }
         var _loc2_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc3_:int = Math.floor((_loc2_ + 1) / 2);
         var _loc4_:* = _loc2_ - _loc3_;
         var _loc5_:* = param1 - _loc2_ * MapTools.MAP_GRID_WIDTH;
         return new mapTools.Point(_loc3_ + _loc5_,_loc5_ - _loc4_);
      }
      
      public static function getCellIdXCoord(param1:int) : int
      {
         var _loc2_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc3_:int = Math.floor((_loc2_ + 1) / 2);
         var _loc4_:* = param1 - _loc2_ * MapTools.MAP_GRID_WIDTH;
         return _loc3_ + _loc4_;
      }
      
      public static function getCellIdYCoord(param1:int) : int
      {
         var _loc2_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc3_:int = Math.floor((_loc2_ + 1) / 2);
         var _loc4_:* = _loc2_ - _loc3_;
         var _loc5_:* = param1 - _loc2_ * MapTools.MAP_GRID_WIDTH;
         return _loc5_ - _loc4_;
      }
      
      public static function getCellIdByCoord(param1:int, param2:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2))
         {
            return -1;
         }
         return int(Math.floor(Number((param1 - param2) * MapTools.MAP_GRID_WIDTH + param2 + (param1 - param2) / 2)));
      }
      
      public static function floatAlmostEquals(param1:Number, param2:Number) : Boolean
      {
         if(param1 != param2)
         {
            return Number(Math.abs(param1 - param2)) < 0.0001;
         }
         return true;
      }
      
      public static function getCellsIdBetween(param1:int, param2:int) : Array
      {
         if(param1 == param2)
         {
            return [];
         }
         if(!MapTools.isValidCellId(param1) || !MapTools.isValidCellId(param2))
         {
            return [];
         }
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:* = _loc4_ + _loc5_;
         var _loc7_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc8_:int = Math.floor((_loc7_ + 1) / 2);
         var _loc9_:* = _loc7_ - _loc8_;
         var _loc10_:* = param1 - _loc7_ * MapTools.MAP_GRID_WIDTH;
         var _loc11_:* = _loc10_ - _loc9_;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:* = _loc13_ + _loc14_;
         var _loc16_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc17_:int = Math.floor((_loc16_ + 1) / 2);
         var _loc18_:* = _loc16_ - _loc17_;
         var _loc19_:* = param2 - _loc16_ * MapTools.MAP_GRID_WIDTH;
         var _loc20_:* = _loc19_ - _loc18_;
         var _loc21_:* = _loc15_ - _loc6_;
         var _loc22_:* = _loc20_ - _loc11_;
         var _loc23_:Number = Number(Math.sqrt(_loc21_ * _loc21_ + _loc22_ * _loc22_));
         var _loc24_:Number = _loc21_ / _loc23_;
         var _loc25_:Number = _loc22_ / _loc23_;
         var _loc26_:Number = Number(Math.abs(1 / _loc24_));
         var _loc27_:Number = Number(Math.abs(1 / _loc25_));
         var _loc28_:int = _loc24_ < 0 ? -1 : 1;
         var _loc29_:int = _loc25_ < 0 ? -1 : 1;
         var _loc30_:Number = 0.5 * _loc26_;
         var _loc31_:Number = 0.5 * _loc27_;
         var _loc32_:Array = [];
         while(_loc6_ != _loc15_ || _loc11_ != _loc20_)
         {
            if(MapTools.floatAlmostEquals(_loc30_,_loc31_))
            {
               _loc30_ += _loc26_;
               _loc31_ += _loc27_;
               _loc6_ += _loc28_;
               _loc11_ += _loc29_;
            }
            else if(_loc30_ < _loc31_)
            {
               _loc30_ += _loc26_;
               _loc6_ += _loc28_;
            }
            else
            {
               _loc31_ += _loc27_;
               _loc11_ += _loc29_;
            }
            _loc32_.push(int(MapTools.getCellIdByCoord(_loc6_,_loc11_)));
         }
         return _loc32_;
      }
      
      public static function getCellsIdOnLargeWay(param1:int, param2:int) : Array
      {
         var _loc21_:int = 0;
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         var _loc17_:int = MapTools.getLookDirection8ExactByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_);
         if(!MapDirection.isValidDirection(_loc17_))
         {
            return [];
         }
         var _loc18_:Array = [param1];
         var _loc19_:int = param1;
         var _loc20_:int = 8;
         while(_loc19_ != param2)
         {
            if(MapDirection.isCardinal(_loc17_))
            {
               _loc21_ = MapTools.getNextCellByDirection(_loc19_,int((_loc17_ + 1) % _loc20_));
               if(MapTools.isValidCellId(_loc21_))
               {
                  _loc18_.push(_loc21_);
               }
               _loc21_ = MapTools.getNextCellByDirection(_loc19_,int((_loc17_ + _loc20_ - 1) % _loc20_));
               if(MapTools.isValidCellId(_loc21_))
               {
                  _loc18_.push(_loc21_);
               }
            }
            _loc19_ = MapTools.getNextCellByDirection(_loc19_,_loc17_);
            _loc18_.push(_loc19_);
         }
         return _loc18_;
      }
      
      public static function isValidCellId(param1:int) : Boolean
      {
         if(!MapTools.isInit)
         {
            throw "MapTools must be initiliazed with method .initForDofus2 or .initForDofus3";
         }
         if(param1 >= 0)
         {
            return param1 < MapTools.mapCountCell;
         }
         return false;
      }
      
      public static function isValidCoord(param1:int, param2:int) : Boolean
      {
         if(!MapTools.isInit)
         {
            throw "MapTools must be initiliazed with method .initForDofus2 or .initForDofus3";
         }
         if(param2 >= -param1 && param2 <= param1 && param2 <= MapTools.MAP_GRID_WIDTH + MapTools.MAX_Y_COORD - param1)
         {
            return param2 >= param1 - (MapTools.MAP_GRID_HEIGHT - MapTools.MIN_Y_COORD);
         }
         return false;
      }
      
      public static function isInDiag(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return Boolean(MapTools.isInDiagByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function isInDiagByCoord(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapTools.isValidCoord(param3,param4))
         {
            return false;
         }
         return int(Math.floor(Number(Math.abs(param1 - param3)))) == int(Math.floor(Number(Math.abs(param2 - param4))));
      }
      
      public static function getLookDirection4(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection4ByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection4ByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapTools.isValidCoord(param3,param4))
         {
            return -1;
         }
         var _loc5_:* = param1 - param3;
         var _loc6_:* = param2 - param4;
         if(int(Math.floor(Number(Math.abs(_loc5_)))) > int(Math.floor(Number(Math.abs(_loc6_)))))
         {
            if(_loc5_ < 0)
            {
               return 1;
            }
            return 5;
         }
         if(_loc6_ < 0)
         {
            return 7;
         }
         return 3;
      }
      
      public static function getLookDirection4Exact(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection4ExactByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection4ExactByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapTools.isValidCoord(param3,param4))
         {
            return -1;
         }
         var _loc5_:* = param3 - param1;
         var _loc6_:* = param4 - param2;
         if(_loc6_ == 0)
         {
            if(_loc5_ < 0)
            {
               return 5;
            }
            return 1;
         }
         if(_loc5_ == 0)
         {
            if(_loc6_ < 0)
            {
               return 3;
            }
            return 7;
         }
         return -1;
      }
      
      public static function getLookDirection4Diag(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection4DiagByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection4DiagByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapTools.isValidCoord(param3,param4))
         {
            return -1;
         }
         var _loc5_:* = param3 - param1;
         var _loc6_:* = param4 - param2;
         if(_loc5_ >= 0 && _loc6_ <= 0 || _loc5_ <= 0 && _loc6_ >= 0)
         {
            if(_loc5_ < 0)
            {
               return 6;
            }
            return 2;
         }
         if(_loc5_ < 0)
         {
            return 4;
         }
         return 0;
      }
      
      public static function getLookDirection4DiagExact(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection4DiagExactByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection4DiagExactByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapTools.isValidCoord(param3,param4))
         {
            return -1;
         }
         var _loc5_:* = param3 - param1;
         var _loc6_:* = param4 - param2;
         if(_loc5_ == -_loc6_)
         {
            if(_loc5_ < 0)
            {
               return 6;
            }
            return 2;
         }
         if(_loc5_ == _loc6_)
         {
            if(_loc5_ < 0)
            {
               return 4;
            }
            return 0;
         }
         return -1;
      }
      
      public static function getLookDirection8(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection8ByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection8ByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = MapTools.getLookDirection8ExactByCoord(param1,param2,param3,param4);
         if(!MapDirection.isValidDirection(_loc5_))
         {
            _loc6_ = param3 - param1;
            _loc7_ = param4 - param2;
            _loc8_ = Math.floor(Number(Math.abs(_loc6_)));
            _loc9_ = Math.floor(Number(Math.abs(_loc7_)));
            if(_loc8_ < _loc9_)
            {
               if(_loc7_ > 0)
               {
                  _loc5_ = _loc6_ < 0 ? 6 : 7;
               }
               else
               {
                  _loc5_ = _loc6_ < 0 ? 3 : 2;
               }
            }
            else if(_loc6_ > 0)
            {
               _loc5_ = _loc7_ > 0 ? 0 : 1;
            }
            else
            {
               _loc5_ = _loc7_ < 0 ? 4 : 5;
            }
         }
         return _loc5_;
      }
      
      public static function getLookDirection8Exact(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         var _loc10_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc11_:int = Math.floor((_loc10_ + 1) / 2);
         var _loc12_:* = param2 - _loc10_ * MapTools.MAP_GRID_WIDTH;
         var _loc13_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc14_:int = Math.floor((_loc13_ + 1) / 2);
         var _loc15_:* = _loc13_ - _loc14_;
         var _loc16_:* = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getLookDirection8ExactByCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,_loc11_ + _loc12_,_loc16_ - _loc15_));
      }
      
      public static function getLookDirection8ExactByCoord(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:int = MapTools.getLookDirection4ExactByCoord(param1,param2,param3,param4);
         if(!MapDirection.isValidDirection(_loc5_))
         {
            _loc5_ = MapTools.getLookDirection4DiagExactByCoord(param1,param2,param3,param4);
         }
         return _loc5_;
      }
      
      public static function getNextCellByDirection(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc7_:int = Math.floor((_loc6_ + 1) / 2);
         var _loc8_:* = _loc6_ - _loc7_;
         var _loc9_:* = param1 - _loc6_ * MapTools.MAP_GRID_WIDTH;
         return int(MapTools.getNextCellByDirectionAndCoord(_loc4_ + _loc5_,_loc9_ - _loc8_,param2));
      }
      
      public static function getNextCellByDirectionAndCoord(param1:int, param2:int, param3:int) : int
      {
         if(!MapTools.isValidCoord(param1,param2) || !MapDirection.isValidDirection(param3))
         {
            return -1;
         }
         return int(MapTools.getCellIdByCoord(param1 + MapTools.COORDINATES_DIRECTION[param3].x,param2 + MapTools.COORDINATES_DIRECTION[param3].y));
      }
      
      public static function adjacentCellsAllowAccess(param1:FightContext, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 8;
         var _loc5_:int = MapTools.getNextCellByDirection(param2,int((param3 + 1) % _loc4_));
         var _loc6_:int = MapTools.getNextCellByDirection(param2,int((param3 + _loc4_ - 1) % _loc4_));
         if(MapDirection.isOrthogonal(param3) || !!param1.isCellEmptyForMovement(_loc5_) && param1.isCellEmptyForMovement(_loc6_))
         {
            return true;
         }
         return false;
      }
      
      public static function getDistance(param1:int, param2:int) : int
      {
         if(!MapTools.isValidCellId(param1) || !MapTools.isValidCellId(param2))
         {
            return -1;
         }
         var _loc3_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc4_:int = Math.floor((_loc3_ + 1) / 2);
         var _loc5_:* = param1 - _loc3_ * MapTools.MAP_GRID_WIDTH;
         var _loc6_:* = _loc4_ + _loc5_;
         var _loc7_:int = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
         var _loc8_:int = Math.floor((_loc7_ + 1) / 2);
         var _loc9_:* = _loc7_ - _loc8_;
         var _loc10_:* = param1 - _loc7_ * MapTools.MAP_GRID_WIDTH;
         var _loc11_:* = _loc10_ - _loc9_;
         var _loc12_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc13_:int = Math.floor((_loc12_ + 1) / 2);
         var _loc14_:* = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH;
         var _loc15_:* = _loc13_ + _loc14_;
         var _loc16_:int = Math.floor(param2 / MapTools.MAP_GRID_WIDTH);
         var _loc17_:int = Math.floor((_loc16_ + 1) / 2);
         var _loc18_:* = _loc16_ - _loc17_;
         var _loc19_:* = param2 - _loc16_ * MapTools.MAP_GRID_WIDTH;
         var _loc20_:* = _loc19_ - _loc18_;
         return int(Math.floor(Number(Number(Math.abs(_loc15_ - _loc6_)) + Number(Math.abs(_loc20_ - _loc11_)))));
      }
      
      public static function areCellsAdjacent(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = MapTools.getDistance(param1,param2);
         if(_loc3_ >= 0)
         {
            return _loc3_ <= 1;
         }
         return false;
      }
      
      public static function getCellsCoordBetween(param1:int, param2:int) : Array
      {
         return FpUtils.arrayMap_Int_flash_geom_Point(MapTools.getCellsIdBetween(param1,param2),function(param1:int):Point
         {
            return MapTools.getCellCoordById(param1).toFlashPoint();
         });
      }
   }
}
