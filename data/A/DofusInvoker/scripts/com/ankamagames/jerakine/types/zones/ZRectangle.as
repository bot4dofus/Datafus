package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class ZRectangle extends DisplayZone
   {
       
      
      protected var _width:uint = 0;
      
      protected var _height:uint;
      
      protected var _minRadius:uint = 2;
      
      protected var _diagonalFree:Boolean = false;
      
      public function ZRectangle(minRadius:uint, alternativeSize:uint, size:uint, isDiagonalFree:Boolean, dataMapProvider:IDataMapProvider)
      {
         super(SpellShapeEnum.UNKNOWN,alternativeSize,size,dataMapProvider);
         this._diagonalFree = isDiagonalFree;
         this._width = alternativeSize;
         this._height = !!size ? uint(size) : uint(this._width);
         this._minRadius = minRadius;
      }
      
      public function get minRadius() : uint
      {
         return this._minRadius;
      }
      
      public function get isDiagonalFree() : Boolean
      {
         return this._diagonalFree;
      }
      
      override public function get surface() : uint
      {
         return Math.pow(this._width + this._height + 1,2);
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
         var cells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._width == 0 || this._height == 0)
         {
            if(this._minRadius == 0 && !this._diagonalFree)
            {
               cells.push(cellId);
            }
            return cells;
         }
         for(i = x - this._width; i <= x + this._width; i++)
         {
            for(j = y - this._height; j <= y + this._height; j++)
            {
               if(!this._minRadius || Math.abs(x - i) + Math.abs(y - j) >= this._minRadius)
               {
                  if(!this._diagonalFree || Math.abs(x - i) != Math.abs(y - j))
                  {
                     if(MapPoint.isInMap(i,j))
                     {
                        tryAddCell(i,j,cells);
                     }
                  }
               }
            }
         }
         return cells;
      }
   }
}
