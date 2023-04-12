package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import mapTools.MapDirection;
   
   public class Fork extends DisplayZone
   {
       
      
      private var _length:uint = 0;
      
      public function Fork(size:uint, dataMapProvider:IDataMapProvider)
      {
         super(SpellShapeEnum.F,0,size,dataMapProvider);
         this._length = size + 1;
      }
      
      public function get length() : uint
      {
         return this._length;
      }
      
      override public function get surface() : uint
      {
         return 1 + 3 * this._length;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var j:int = 0;
         var x:int = 0;
         var y:int = 0;
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var cells:Vector.<uint> = new <uint>[cellId];
         var sign:int = _direction === MapDirection.NORTH_WEST || _direction === MapDirection.SOUTH_WEST ? -1 : 1;
         var axisFlag:Boolean = _direction === MapDirection.NORTH_WEST || _direction === MapDirection.SOUTH_EAST;
         for(var i:int = 1; i <= this._length; i++)
         {
            for(j = -1; j <= 1; j++)
            {
               x = 0;
               y = 0;
               if(axisFlag)
               {
                  x = origin.x + i * sign;
                  y = origin.y + j * i;
               }
               else
               {
                  x = origin.x + j * i;
                  y = origin.y + i * sign;
               }
               tryAddCell(x,y,cells);
            }
         }
         return cells;
      }
   }
}
