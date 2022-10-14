package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.utils.getQualifiedClassName;
   import mapTools.MapTools;
   
   public class Lozenge implements IZone
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Lozenge));
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
      private var _dataMapProvider:IDataMapProvider;
      
      public function Lozenge(nMinRadius:uint, nRadius:uint, dataMapProvider:IDataMapProvider)
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
      }
      
      public function get direction() : uint
      {
         return null;
      }
      
      public function get surface() : uint
      {
         return Math.pow(this._radius + 1,2) + Math.pow(this._radius,2);
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
         var radiusStep:int = 0;
         var xResult:int = 0;
         var yResult:int = 0;
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
         for(radiusStep = this.radius; radiusStep >= this._minRadius; radiusStep--)
         {
            for(i = -radiusStep; i <= radiusStep; i++)
            {
               for(j = -radiusStep; j <= radiusStep; j++)
               {
                  if(Math.abs(i) + Math.abs(j) == radiusStep)
                  {
                     xResult = x + i;
                     yResult = y + j;
                     if(MapPoint.isInMap(xResult,yResult))
                     {
                        this.addCell(xResult,yResult,aCells);
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
