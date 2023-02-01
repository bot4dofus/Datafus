package com.ankamagames.jerakine.types.positions
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   public class MapPoint
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapPoint));
      
      private static const VECTOR_RIGHT:Point = new Point(1,1);
      
      private static const VECTOR_DOWN_RIGHT:Point = new Point(1,0);
      
      private static const VECTOR_DOWN:Point = new Point(1,-1);
      
      private static const VECTOR_DOWN_LEFT:Point = new Point(0,-1);
      
      private static const VECTOR_LEFT:Point = new Point(-1,-1);
      
      private static const VECTOR_UP_LEFT:Point = new Point(-1,0);
      
      private static const VECTOR_UP:Point = new Point(-1,1);
      
      private static const VECTOR_UP_RIGHT:Point = new Point(0,1);
      
      public static const MAP_WIDTH:uint = 14;
      
      public static const MAP_HEIGHT:uint = 20;
      
      private static var _bInit:Boolean = false;
      
      public static var CELLPOS:Array = new Array();
       
      
      private var _nCellId:uint;
      
      private var _nX:int;
      
      private var _nY:int;
      
      public function MapPoint()
      {
         super();
      }
      
      public static function fromCellId(cellId:uint) : MapPoint
      {
         var mp:MapPoint = new MapPoint();
         mp._nCellId = cellId;
         mp.setFromCellId();
         return mp;
      }
      
      public static function fromCoords(x:int, y:int) : MapPoint
      {
         var mp:MapPoint = new MapPoint();
         mp._nX = x;
         mp._nY = y;
         mp.setFromCoords();
         return mp;
      }
      
      public static function getOrientationsDistance(currentOrientation:int, defaultOrientation:int) : int
      {
         return int(Math.min(Math.abs(defaultOrientation - currentOrientation),Math.abs(8 - defaultOrientation + currentOrientation)));
      }
      
      public static function isInMap(x:int, y:int) : Boolean
      {
         return x + y >= 0 && x - y >= 0 && x - y < MAP_HEIGHT * 2 && x + y < MAP_WIDTH * 2;
      }
      
      private static function init() : void
      {
         var b:int = 0;
         _bInit = true;
         var startX:int = 0;
         var startY:int = 0;
         var cell:int = 0;
         for(var a:int = 0; a < MAP_HEIGHT; a++)
         {
            for(b = 0; b < MAP_WIDTH; b++)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
            }
            startX++;
            for(b = 0; b < MAP_WIDTH; b++)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
            }
            startY--;
         }
      }
      
      public function get cellId() : uint
      {
         return this._nCellId;
      }
      
      public function set cellId(nValue:uint) : void
      {
         this._nCellId = nValue;
         this.setFromCellId();
      }
      
      public function get x() : int
      {
         return this._nX;
      }
      
      public function set x(nValue:int) : void
      {
         this._nX = nValue;
         this.setFromCoords();
      }
      
      public function get y() : int
      {
         return this._nY;
      }
      
      public function set y(nValue:int) : void
      {
         this._nY = nValue;
         this.setFromCoords();
      }
      
      public function get coordinates() : Point
      {
         return new Point(this._nX,this._nY);
      }
      
      public function distanceTo(mp:MapPoint) : uint
      {
         return Math.sqrt(Math.pow(mp.x - this.x,2) + Math.pow(mp.y - this.y,2));
      }
      
      public function distanceToCell(cell:MapPoint) : int
      {
         return Math.abs(this.x - cell.x) + Math.abs(this.y - cell.y);
      }
      
      public function orientationTo(mp:MapPoint) : uint
      {
         var result:uint = 0;
         if(this.x == mp.x && this.y == mp.y)
         {
            return 1;
         }
         var ptX:int = mp.x > this.x ? 1 : (mp.x < this.x ? -1 : 0);
         var ptY:int = mp.y > this.y ? 1 : (mp.y < this.y ? -1 : 0);
         if(ptX == VECTOR_RIGHT.x && ptY == VECTOR_RIGHT.y)
         {
            result = DirectionsEnum.RIGHT;
         }
         else if(ptX == VECTOR_DOWN_RIGHT.x && ptY == VECTOR_DOWN_RIGHT.y)
         {
            result = DirectionsEnum.DOWN_RIGHT;
         }
         else if(ptX == VECTOR_DOWN.x && ptY == VECTOR_DOWN.y)
         {
            result = DirectionsEnum.DOWN;
         }
         else if(ptX == VECTOR_DOWN_LEFT.x && ptY == VECTOR_DOWN_LEFT.y)
         {
            result = DirectionsEnum.DOWN_LEFT;
         }
         else if(ptX == VECTOR_LEFT.x && ptY == VECTOR_LEFT.y)
         {
            result = DirectionsEnum.LEFT;
         }
         else if(ptX == VECTOR_UP_LEFT.x && ptY == VECTOR_UP_LEFT.y)
         {
            result = DirectionsEnum.UP_LEFT;
         }
         else if(ptX == VECTOR_UP.x && ptY == VECTOR_UP.y)
         {
            result = DirectionsEnum.UP;
         }
         else if(ptX == VECTOR_UP_RIGHT.x && ptY == VECTOR_UP_RIGHT.y)
         {
            result = DirectionsEnum.UP_RIGHT;
         }
         return result;
      }
      
      public function advancedOrientationTo(target:MapPoint, fourDir:Boolean = true) : uint
      {
         if(!target)
         {
            return 0;
         }
         var xDifference:int = target.x - this.x;
         var yDifference:int = this.y - target.y;
         var angle:int = Math.acos(xDifference / Math.sqrt(Math.pow(xDifference,2) + Math.pow(yDifference,2))) * 180 / Math.PI * (target.y > this.y ? -1 : 1);
         if(fourDir)
         {
            angle = Math.round(angle / 90) * 2 + 1;
         }
         else
         {
            angle = Math.round(angle / 45) + 1;
         }
         if(angle < 0)
         {
            angle += 8;
         }
         return angle;
      }
      
      public function getNearestFreeCell(mapProvider:IDataMapProvider, allowThoughEntity:Boolean = true) : MapPoint
      {
         var mp:MapPoint = null;
         for(var i:uint = 0; i < 8; i++)
         {
            mp = this.getNearestFreeCellInDirection(i,mapProvider,false,allowThoughEntity);
            if(mp)
            {
               break;
            }
         }
         return mp;
      }
      
      public function getNearestCellInDirection(orientation:uint) : MapPoint
      {
         var mp:MapPoint = null;
         switch(orientation)
         {
            case 0:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY + 1);
               break;
            case 1:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY);
               break;
            case 2:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY - 1);
               break;
            case 3:
               mp = MapPoint.fromCoords(this._nX,this._nY - 1);
               break;
            case 4:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY - 1);
               break;
            case 5:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY);
               break;
            case 6:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY + 1);
               break;
            case 7:
               mp = MapPoint.fromCoords(this._nX,this._nY + 1);
         }
         if(MapPoint.isInMap(mp._nX,mp._nY))
         {
            return mp;
         }
         return null;
      }
      
      public function getNearestFreeCellInDirection(orientation:uint, mapProvider:IDataMapProvider, allowItself:Boolean = true, allowThoughEntity:Boolean = true, ignoreSpeed:Boolean = false, forbidenCellsId:Array = null) : MapPoint
      {
         var i:int = 0;
         var speed:int = 0;
         var mp:MapPoint = null;
         if(forbidenCellsId == null)
         {
            forbidenCellsId = new Array();
         }
         var cells:Vector.<MapPoint> = new Vector.<MapPoint>(8,true);
         var weights:Vector.<int> = new Vector.<int>(8,true);
         for(i = 0; i < 8; i++)
         {
            mp = this.getNearestCellInDirection(i);
            cells[i] = mp;
            if(mp != null)
            {
               speed = mapProvider.getCellSpeed(mp.cellId);
               if(forbidenCellsId.indexOf(mp.cellId) == -1)
               {
                  if(mapProvider.pointMov(mp._nX,mp._nY,allowThoughEntity,this.cellId))
                  {
                     weights[i] = getOrientationsDistance(i,orientation) + (!ignoreSpeed ? (speed >= 0 ? 5 - speed : 11 + Math.abs(speed)) : 0);
                  }
                  else
                  {
                     forbidenCellsId.push(mp.cellId);
                     weights[i] = -1;
                  }
               }
               else
               {
                  weights[i] = !!mapProvider.pointMov(mp._nX,mp._nY,allowThoughEntity,this.cellId) ? int(100 + getOrientationsDistance(i,orientation) + (!ignoreSpeed ? (speed >= 0 ? 5 - speed : 11 + Math.abs(speed)) : 0)) : -1;
               }
            }
            else
            {
               weights[i] = -1;
            }
         }
         var minWeightOrientation:int = -1;
         var minWeight:int = 10000;
         for(i = 0; i < 8; i++)
         {
            if(weights[i] != -1 && weights[i] < minWeight && cells[i] != null)
            {
               minWeight = weights[i];
               minWeightOrientation = i;
            }
         }
         if(minWeightOrientation != -1)
         {
            mp = cells[minWeightOrientation];
         }
         else
         {
            mp = null;
         }
         if(mp == null && allowItself && mapProvider.pointMov(this._nX,this._nY,allowThoughEntity,this.cellId))
         {
            return this;
         }
         return mp;
      }
      
      public function pointSymetry(pCentralPoint:MapPoint) : MapPoint
      {
         var destX:int = 2 * pCentralPoint.x - this.x;
         var destY:int = 2 * pCentralPoint.y - this.y;
         if(isInMap(destX,destY))
         {
            return MapPoint.fromCoords(destX,destY);
         }
         return null;
      }
      
      public function equals(mp:MapPoint) : Boolean
      {
         return mp.cellId == this.cellId;
      }
      
      public function toString() : String
      {
         return "[MapPoint(x:" + this._nX + ", y:" + this._nY + ", id:" + this._nCellId + ")]";
      }
      
      private function setFromCoords() : void
      {
         if(!_bInit)
         {
            init();
         }
         this._nCellId = (this._nX - this._nY) * MAP_WIDTH + this._nY + (this._nX - this._nY) / 2;
      }
      
      private function setFromCellId() : void
      {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[this._nCellId])
         {
            throw new JerakineError("Cell identifier out of bounds (" + this._nCellId + ").");
         }
         var p:Point = CELLPOS[this._nCellId];
         this._nX = p.x;
         this._nY = p.y;
      }
   }
}
