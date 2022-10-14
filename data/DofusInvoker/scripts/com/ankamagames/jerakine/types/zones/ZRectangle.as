package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import mapTools.MapTools;
   
   public class ZRectangle implements IZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _radius2:uint;
      
      private var _minRadius:uint = 2;
      
      private var _dataMapProvider:IDataMapProvider;
      
      private var _diagonalFree:Boolean = false;
      
      public function ZRectangle(nMinRadius:uint, nWidth:uint, nHeight:uint, dataMapProvider:IDataMapProvider)
      {
         super();
         this.radius = nWidth;
         this._radius2 = !!nHeight ? uint(nHeight) : uint(nWidth);
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
      }
      
      public function get direction() : uint
      {
         return null;
      }
      
      public function set diagonalFree(d:Boolean) : void
      {
         this._diagonalFree = d;
      }
      
      public function get diagonalFree() : Boolean
      {
         return this._diagonalFree;
      }
      
      public function get surface() : uint
      {
         return Math.pow(this._radius + this._radius2 + 1,2);
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._radius == 0 || this._radius2 == 0)
         {
            if(this._minRadius == 0 && !this._diagonalFree)
            {
               aCells.push(cellId);
            }
            return aCells;
         }
         for(i = x - this._radius; i <= x + this._radius; i++)
         {
            for(j = y - this._radius2; j <= y + this._radius2; j++)
            {
               if(!this._minRadius || Math.abs(x - i) + Math.abs(y - j) >= this._minRadius)
               {
                  if(!this._diagonalFree || Math.abs(x - i) != Math.abs(y - j))
                  {
                     if(MapPoint.isInMap(i,j))
                     {
                        this.addCell(i,j,aCells);
                     }
                  }
               }
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
