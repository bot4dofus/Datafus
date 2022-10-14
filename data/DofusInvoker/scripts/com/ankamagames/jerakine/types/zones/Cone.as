package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.utils.getQualifiedClassName;
   import mapTools.MapTools;
   
   public class Cone implements IZone
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cone));
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _nDirection:uint = 1;
      
      private var _dataMapProvider:IDataMapProvider;
      
      public function Cone(nMinRadius:uint, nRadius:uint, dataMapProvider:IDataMapProvider)
      {
         super();
         this.radius = nRadius;
         this.minRadius = nMinRadius;
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
      
      public function get surface() : uint
      {
         return Math.pow(this._radius + 1,2);
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._radius == 0)
         {
            if(this._minRadius == 0)
            {
               aCells.push(cellId);
            }
            return aCells;
         }
         var inc:int = 1;
         var step:uint = 0;
         switch(this._nDirection)
         {
            case DirectionsEnum.UP_LEFT:
               for(i = x; i >= x - this._radius; i--)
               {
                  for(j = -step; j <= step; j++)
                  {
                     if(!this._minRadius || Math.abs(x - i) + Math.abs(j) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(i,j + y))
                        {
                           this.addCell(i,j + y,aCells);
                        }
                     }
                  }
                  step += inc;
               }
               break;
            case DirectionsEnum.DOWN_LEFT:
               for(j = y; j >= y - this._radius; j--)
               {
                  for(i = -step; i <= step; i++)
                  {
                     if(!this._minRadius || Math.abs(i) + Math.abs(y - j) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(i + x,j))
                        {
                           this.addCell(i + x,j,aCells);
                        }
                     }
                  }
                  step += inc;
               }
               break;
            case DirectionsEnum.DOWN_RIGHT:
               for(i = x; i <= x + this._radius; i++)
               {
                  for(j = -step; j <= step; j++)
                  {
                     if(!this._minRadius || Math.abs(x - i) + Math.abs(j) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(i,j + y))
                        {
                           this.addCell(i,j + y,aCells);
                        }
                     }
                  }
                  step += inc;
               }
               break;
            case DirectionsEnum.UP_RIGHT:
               for(j = y; j <= y + this._radius; j++)
               {
                  for(i = -step; i <= step; i++)
                  {
                     if(!this._minRadius || Math.abs(i) + Math.abs(y - j) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(i + x,j))
                        {
                           this.addCell(i + x,j,aCells);
                        }
                     }
                  }
                  step += inc;
               }
         }
         return aCells;
      }
      
      private function addCell(x:int, y:int, cellMap:Vector.<uint>) : void
      {
         if(this._dataMapProvider == null || this._dataMapProvider.pointMov(x,y))
         {
            cellMap.push(MapTools.getCellIdByCoord(x,y));
         }
      }
   }
}
