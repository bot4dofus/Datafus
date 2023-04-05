package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class Cross extends DisplayZone
   {
       
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _diagonal:Boolean = false;
      
      private var _allDirections:Boolean = false;
      
      private var _disabledDirection:Vector.<int>;
      
      private var _onlyPerpendicular:Boolean = false;
      
      public function Cross(shape:uint, alternativeSize:uint, size:uint, dataMapProvider:IDataMapProvider, diagonal:Boolean = false, allDirections:Boolean = false)
      {
         this._disabledDirection = new Vector.<int>(0);
         super(shape,alternativeSize,size,dataMapProvider);
         this._minRadius = alternativeSize;
         this._radius = size;
         this._onlyPerpendicular = shape === SpellShapeEnum.T || shape === SpellShapeEnum.minus;
         this._diagonal = !allDirections && diagonal;
         this._allDirections = allDirections;
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
         return this._radius * 4 + 1;
      }
      
      public function get diagonal() : Boolean
      {
         return this._diagonal;
      }
      
      public function get allDirections() : Boolean
      {
         return this._allDirections;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         var cells:Vector.<uint> = new Vector.<uint>();
         if(this._minRadius == 0)
         {
            cells.push(cellId);
         }
         if(this._onlyPerpendicular)
         {
            switch(_direction)
            {
               case DirectionsEnum.DOWN_RIGHT:
               case DirectionsEnum.UP_LEFT:
                  this._disabledDirection = new <int>[DirectionsEnum.DOWN_RIGHT,DirectionsEnum.UP_LEFT];
                  break;
               case DirectionsEnum.UP_RIGHT:
               case DirectionsEnum.DOWN_LEFT:
                  this._disabledDirection = new <int>[DirectionsEnum.UP_RIGHT,DirectionsEnum.DOWN_LEFT];
                  break;
               case DirectionsEnum.DOWN:
               case DirectionsEnum.UP:
                  this._disabledDirection = new <int>[DirectionsEnum.DOWN,DirectionsEnum.UP];
                  break;
               case DirectionsEnum.RIGHT:
               case DirectionsEnum.LEFT:
                  this._disabledDirection = new <int>[DirectionsEnum.RIGHT,DirectionsEnum.LEFT];
            }
         }
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         for(var r:int = this._radius; r > 0; r--)
         {
            if(r >= this._minRadius)
            {
               if(!this._diagonal)
               {
                  if(MapPoint.isInMap(x + r,y) && this._disabledDirection.indexOf(DirectionsEnum.DOWN_RIGHT) == -1)
                  {
                     tryAddCell(x + r,y,cells);
                  }
                  if(MapPoint.isInMap(x - r,y) && this._disabledDirection.indexOf(DirectionsEnum.UP_LEFT) == -1)
                  {
                     tryAddCell(x - r,y,cells);
                  }
                  if(MapPoint.isInMap(x,y + r) && this._disabledDirection.indexOf(DirectionsEnum.UP_RIGHT) == -1)
                  {
                     tryAddCell(x,y + r,cells);
                  }
                  if(MapPoint.isInMap(x,y - r) && this._disabledDirection.indexOf(DirectionsEnum.DOWN_LEFT) == -1)
                  {
                     tryAddCell(x,y - r,cells);
                  }
               }
               if(this._diagonal || this._allDirections)
               {
                  if(MapPoint.isInMap(x + r,y - r) && this._disabledDirection.indexOf(DirectionsEnum.DOWN) == -1)
                  {
                     tryAddCell(x + r,y - r,cells);
                  }
                  if(MapPoint.isInMap(x - r,y + r) && this._disabledDirection.indexOf(DirectionsEnum.UP) == -1)
                  {
                     tryAddCell(x - r,y + r,cells);
                  }
                  if(MapPoint.isInMap(x + r,y + r) && this._disabledDirection.indexOf(DirectionsEnum.RIGHT) == -1)
                  {
                     tryAddCell(x + r,y + r,cells);
                  }
                  if(MapPoint.isInMap(x - r,y - r) && this._disabledDirection.indexOf(DirectionsEnum.LEFT) == -1)
                  {
                     tryAddCell(x - r,y - r,cells);
                  }
               }
            }
         }
         return cells;
      }
   }
}
