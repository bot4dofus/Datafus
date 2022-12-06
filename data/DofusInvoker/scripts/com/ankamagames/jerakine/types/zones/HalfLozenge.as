package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class HalfLozenge extends DisplayZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
      public function HalfLozenge(alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider)
      {
         super(SpellShapeEnum.U,alternativeSize,size,dataMapProvider);
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
         return this._radius * 2 + 1;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var cells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._minRadius == 0)
         {
            cells.push(cellId);
         }
         for(i = 1; i <= this._radius; i++)
         {
            switch(_direction)
            {
               case DirectionsEnum.UP_LEFT:
                  tryAddCell(x + i,y + i,cells);
                  tryAddCell(x + i,y - i,cells);
                  break;
               case DirectionsEnum.UP_RIGHT:
                  tryAddCell(x - i,y - i,cells);
                  tryAddCell(x + i,y - i,cells);
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  tryAddCell(x - i,y + i,cells);
                  tryAddCell(x - i,y - i,cells);
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  tryAddCell(x - i,y + i,cells);
                  tryAddCell(x + i,y + i,cells);
                  break;
            }
         }
         return cells;
      }
   }
}
