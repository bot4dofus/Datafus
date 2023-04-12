package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class Cone extends DisplayZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      public function Cone(alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider)
      {
         super(SpellShapeEnum.V,alternativeSize,size,dataMapProvider);
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
         return Math.pow(this._radius + 1,2);
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var i:int = 0;
         var j:int = 0;
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
         var inc:int = 1;
         var step:uint = 0;
         switch(_direction)
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
                           tryAddCell(i,j + y,cells);
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
                           tryAddCell(i + x,j,cells);
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
                           tryAddCell(i,j + y,cells);
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
                           tryAddCell(i + x,j,cells);
                        }
                     }
                  }
                  step += inc;
               }
         }
         return cells;
      }
   }
}
