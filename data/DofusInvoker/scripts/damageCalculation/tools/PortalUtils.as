package damageCalculation.tools
{
   import damageCalculation.spellManagement.Mark;
   import haxe.IMap;
   import haxe.ds.ArraySort;
   import haxe.ds.IntMap;
   import mapTools.MapTools;
   import mapTools.Point;
   
   public class PortalUtils
   {
       
      
      public function PortalUtils()
      {
      }
      
      public static function getNearestPortalCell(param1:int, param2:Array) : int
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = 63;
         var _loc5_:int = 0;
         while(_loc5_ < int(param2.length))
         {
            _loc6_ = param2[_loc5_];
            _loc5_++;
            _loc7_ = MapTools.getDistance(param1,_loc6_);
            if(_loc7_ < _loc4_)
            {
               _loc3_ = [];
               _loc3_.push(_loc6_);
               _loc4_ = _loc7_;
            }
            else if(_loc7_ == _loc4_)
            {
               _loc3_.push(_loc6_);
            }
         }
         if(int(_loc3_.length) <= 0)
         {
            return -1;
         }
         if(int(_loc3_.length) == 1)
         {
            return int(_loc3_[0]);
         }
         return int(PortalUtils.getNextNearestPortalCell(param1,_loc3_));
      }
      
      public static function getNextNearestPortalCell(param1:int, param2:Array) : int
      {
         if(int(param2.length) < 2)
         {
            throw "nearestPortalCells should have a minimum length of 2";
         }
         var targetedPortalCellCoord:Point = MapTools.getCellCoordById(param1);
         var nudgeCoord:Point = new Point(targetedPortalCellCoord.x,targetedPortalCellCoord.y + 1);
         ArraySort.sort(param2,function(param1:int, param2:int):int
         {
            var _loc3_:Point = MapTools.getCellCoordById(param1);
            var _loc4_:Number = Number(MathUtils.getPositiveOrientedAngle(targetedPortalCellCoord,nudgeCoord,_loc3_));
            var _loc5_:Point = MapTools.getCellCoordById(param2);
            var _loc6_:Number = _loc4_ - MathUtils.getPositiveOrientedAngle(targetedPortalCellCoord,nudgeCoord,_loc5_);
            return int(Math.floor(_loc6_));
         });
         var _loc3_:int = PortalUtils.getNextNearestPortalWhenTargetedPortalCellIsNotContained(targetedPortalCellCoord,param2);
         if(_loc3_ != -1)
         {
            return _loc3_;
         }
         return int(PortalUtils.getNextNearestPortalCellWhenTargetedPortalCellIsContained(targetedPortalCellCoord,param2));
      }
      
      public static function getNextNearestPortalWhenTargetedPortalCellIsNotContained(param1:Point, param2:Array) : int
      {
         var _loc5_:int = 0;
         if(int(param2.length) < 2)
         {
            return -1;
         }
         var _loc3_:int = param2[int(param2.length) - 1];
         var _loc4_:int = 0;
         for(; _loc4_ < int(param2.length); _loc3_ = _loc5_)
         {
            _loc5_ = param2[_loc4_];
            _loc4_++;
            switch(MathUtils.compareAngles(param1,MapTools.getCellCoordById(_loc3_),MapTools.getCellCoordById(_loc5_)).index)
            {
               case 1:
                  if(int(param2.length) <= 2)
                  {
                     return -1;
                  }
                  continue;
               case 3:
                  return _loc3_;
            }
         }
         return -1;
      }
      
      public static function getNextNearestPortalCellWhenTargetedPortalCellIsContained(param1:Point, param2:Array) : int
      {
         return int(param2[0]);
      }
      
      public static function getPortalChainFromPortals(param1:Mark, param2:Array, param3:Boolean = false) : Array
      {
         var _loc8_:* = null as Mark;
         var _loc11_:int = 0;
         var _loc4_:int = param1.mainCell;
         var _loc5_:IMap = new IntMap();
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         while(_loc7_ < int(param2.length))
         {
            _loc8_ = param2[_loc7_];
            _loc7_++;
            _loc5_.h[_loc8_.mainCell] = _loc8_;
            _loc6_.push(_loc8_.mainCell);
         }
         var _loc9_:Array = PortalUtils.getPortalChainFromPortalCells(_loc4_,_loc6_);
         var _loc10_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < int(_loc9_.length))
         {
            _loc11_ = _loc9_[_loc7_];
            _loc7_++;
            _loc10_.push(_loc5_.h[_loc11_]);
         }
         return _loc10_;
      }
      
      public static function getPortalChainFromPortalCells(param1:int, param2:Array, param3:Boolean = false) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = param1;
         param2 = param2.copy();
         var _loc6_:int = param2.length;
         if(int(param2.indexOf(_loc5_)) == -1)
         {
            _loc6_++;
         }
         var _loc7_:int = 0;
         var _loc8_:int = _loc6_;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc7_++;
            _loc4_.push(_loc5_);
            param2.remove(_loc5_);
            _loc10_ = PortalUtils.getNearestPortalCell(_loc5_,param2);
            if(_loc10_ == -1)
            {
               break;
            }
            _loc5_ = _loc10_;
         }
         if(int(_loc4_.length) < 2)
         {
            return [];
         }
         _loc4_.remove(param1);
         if(param3)
         {
            _loc4_.reverse();
         }
         return _loc4_;
      }
   }
}
