package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class Lozenge extends DisplayZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
      public function Lozenge(shape:uint, alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider)
      {
         super(shape,alternativeSize,size,dataMapProvider);
         this._minRadius = alternativeSize;
         this._radius = size;
      }
      
      public function get minRadius() : uint
      {
         return this._minRadius;
      }
      
      public function get radius() : uint
      {
         return this._radius;
      }
      
      override public function get surface() : uint
      {
         return Math.pow(this._radius + 1,2) + Math.pow(this._radius,2);
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
         var radiusStep:int = 0;
         var xResult:int = 0;
         var yResult:int = 0;
         var cells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._radius == 0)
         {
            if(this._minRadius == 0)
            {
               cells.push(cellId);
            }
            return cells;
         }
         for(radiusStep = this._radius; radiusStep >= this._minRadius; radiusStep--)
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
                        tryAddCell(xResult,yResult,cells);
                     }
                  }
               }
            }
         }
         return cells;
      }
   }
}
