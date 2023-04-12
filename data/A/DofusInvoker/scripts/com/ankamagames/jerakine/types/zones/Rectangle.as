package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import mapTools.MapDirection;
   
   public class Rectangle extends DisplayZone
   {
       
      
      private var _width:uint = 1;
      
      private var _height:uint = 1;
      
      public function Rectangle(alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider)
      {
         if(alternativeSize < 1)
         {
            alternativeSize = 1;
         }
         if(size < 1)
         {
            size = 1;
         }
         super(SpellShapeEnum.R,alternativeSize,size,dataMapProvider);
         this._width = 1 + size * 2;
         this._height = 1 + alternativeSize;
      }
      
      public function get width() : uint
      {
         return this._width;
      }
      
      public function get height() : uint
      {
         return this._height;
      }
      
      override public function get surface() : uint
      {
         return this._width * this._height;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var j:uint = 0;
         var x:int = 0;
         var y:int = 0;
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var cells:Vector.<uint> = new <uint>[cellId];
         var sign:int = _direction === MapDirection.NORTH_WEST || _direction === MapDirection.SOUTH_WEST ? -1 : 1;
         var axisFlag:Boolean = _direction === MapDirection.NORTH_EAST || _direction === MapDirection.SOUTH_WEST;
         for(var i:uint = 0; i < this._height; i++)
         {
            for(j = 0; j < this._width; j++)
            {
               if(axisFlag)
               {
                  x = origin.x + j - Math.floor(this._width / 2);
                  y = origin.y + i * sign;
               }
               else
               {
                  x = origin.x + i * sign;
                  y = origin.y + j - Math.floor(this._width / 2);
               }
               tryAddCell(x,y,cells);
            }
         }
         return cells;
      }
   }
}
