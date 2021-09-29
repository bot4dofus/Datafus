package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.utils.getQualifiedClassName;
   import mapTools.MapTools;
   
   public class Line implements IZone
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Line));
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _nDirection:uint = 1;
      
      private var _dataMapProvider:IDataMapProvider;
      
      private var _fromCaster:Boolean;
      
      private var _stopAtTarget:Boolean;
      
      private var _casterCellId:uint;
      
      public function Line(nRadius:uint, dataMapProvider:IDataMapProvider)
      {
         super();
         this.radius = nRadius;
         this._dataMapProvider = dataMapProvider;
      }
      
      public function get radius() : uint
      {
         return this._radius;
      }
      
      public function set radius(n:uint) : void
      {
         this._radius = n;
      }
      
      public function get surface() : uint
      {
         return this._radius + 1;
      }
      
      public function set minRadius(r:uint) : void
      {
         this._minRadius = r;
      }
      
      public function get minRadius() : uint
      {
         return this._minRadius;
      }
      
      public function set direction(d:uint) : void
      {
         this._nDirection = d;
      }
      
      public function get direction() : uint
      {
         return this._nDirection;
      }
      
      public function set fromCaster(b:Boolean) : void
      {
         this._fromCaster = b;
      }
      
      public function get fromCaster() : Boolean
      {
         return this._fromCaster;
      }
      
      public function set stopAtTarget(b:Boolean) : void
      {
         this._stopAtTarget = b;
      }
      
      public function get stopAtTarget() : Boolean
      {
         return this._stopAtTarget;
      }
      
      public function set casterCellId(c:uint) : void
      {
         this._casterCellId = c;
      }
      
      public function get casterCellId() : uint
      {
         return this._casterCellId;
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var added:Boolean = false;
         var distance:uint = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = !this._fromCaster ? MapPoint.fromCellId(cellId) : MapPoint.fromCellId(this.casterCellId);
         var x:int = origin.x;
         var y:int = origin.y;
         var length:uint = !this.fromCaster ? uint(this._radius) : uint(this._radius + this._minRadius - 1);
         if(this.fromCaster && this.stopAtTarget)
         {
            distance = origin.distanceToCell(MapPoint.fromCellId(cellId));
            length = distance < length ? uint(distance) : uint(length);
         }
         for(var r:int = this._minRadius; r <= length; r++)
         {
            switch(this._nDirection)
            {
               case DirectionsEnum.LEFT:
                  if(MapPoint.isInMap(x - r,y - r))
                  {
                     added = this.addCell(x - r,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.UP:
                  if(MapPoint.isInMap(x - r,y + r))
                  {
                     added = this.addCell(x - r,y + r,aCells);
                  }
                  break;
               case DirectionsEnum.RIGHT:
                  if(MapPoint.isInMap(x + r,y + r))
                  {
                     added = this.addCell(x + r,y + r,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN:
                  if(MapPoint.isInMap(x + r,y - r))
                  {
                     added = this.addCell(x + r,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.UP_LEFT:
                  if(MapPoint.isInMap(x - r,y))
                  {
                     added = this.addCell(x - r,y,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  if(MapPoint.isInMap(x,y - r))
                  {
                     added = this.addCell(x,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  if(MapPoint.isInMap(x + r,y))
                  {
                     added = this.addCell(x + r,y,aCells);
                  }
                  break;
               case DirectionsEnum.UP_RIGHT:
                  if(MapPoint.isInMap(x,y + r))
                  {
                     added = this.addCell(x,y + r,aCells);
                  }
                  break;
            }
         }
         return aCells;
      }
      
      private function addCell(x:int, y:int, cellMap:Vector.<uint>) : Boolean
      {
         if(this._dataMapProvider == null || this._dataMapProvider.pointMov(x,y))
         {
            cellMap.push(MapTools.getCellIdByCoord(x,y));
            return true;
         }
         return false;
      }
   }
}
