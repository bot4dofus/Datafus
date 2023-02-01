package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class Line extends DisplayZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _fromCaster:Boolean = false;
      
      private var _stopAtTarget:Boolean = false;
      
      private var _casterCellId:uint = 0;
      
      public function Line(shape:uint, alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider, fromCaster:Boolean = false, stopAtTarget:Boolean = false, casterCellId:uint = 0)
      {
         super(shape,alternativeSize,size,dataMapProvider);
         this._radius = size;
         this._minRadius = alternativeSize;
         this._fromCaster = fromCaster;
         this._stopAtTarget = stopAtTarget;
         this._casterCellId = casterCellId;
      }
      
      override public function get surface() : uint
      {
         return this._radius + 1;
      }
      
      public function get minRadius() : uint
      {
         return this._minRadius;
      }
      
      public function get radius() : uint
      {
         return this._radius;
      }
      
      public function get isFromCaster() : Boolean
      {
         return this._fromCaster;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var distance:uint = 0;
         var cells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = !this._fromCaster ? MapPoint.fromCellId(cellId) : MapPoint.fromCellId(this._casterCellId);
         var x:int = origin.x;
         var y:int = origin.y;
         var length:uint = !this._fromCaster ? uint(this._radius) : uint(this._radius + this._minRadius - 1);
         if(this._fromCaster && this._stopAtTarget)
         {
            distance = origin.distanceToCell(MapPoint.fromCellId(cellId));
            length = distance < length ? uint(distance) : uint(length);
         }
         for(var r:int = this._minRadius; r <= length; r++)
         {
            switch(_direction)
            {
               case DirectionsEnum.LEFT:
                  if(MapPoint.isInMap(x - r,y - r))
                  {
                     tryAddCell(x - r,y - r,cells);
                  }
                  break;
               case DirectionsEnum.UP:
                  if(MapPoint.isInMap(x - r,y + r))
                  {
                     tryAddCell(x - r,y + r,cells);
                  }
                  break;
               case DirectionsEnum.RIGHT:
                  if(MapPoint.isInMap(x + r,y + r))
                  {
                     tryAddCell(x + r,y + r,cells);
                  }
                  break;
               case DirectionsEnum.DOWN:
                  if(MapPoint.isInMap(x + r,y - r))
                  {
                     tryAddCell(x + r,y - r,cells);
                  }
                  break;
               case DirectionsEnum.UP_LEFT:
                  if(MapPoint.isInMap(x - r,y))
                  {
                     tryAddCell(x - r,y,cells);
                  }
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  if(MapPoint.isInMap(x,y - r))
                  {
                     tryAddCell(x,y - r,cells);
                  }
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  if(MapPoint.isInMap(x + r,y))
                  {
                     tryAddCell(x + r,y,cells);
                  }
                  break;
               case DirectionsEnum.UP_RIGHT:
                  if(MapPoint.isInMap(x,y + r))
                  {
                     tryAddCell(x,y + r,cells);
                  }
                  break;
            }
         }
         return cells;
      }
   }
}
