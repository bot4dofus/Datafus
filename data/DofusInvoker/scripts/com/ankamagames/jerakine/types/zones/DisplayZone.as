package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import mapTools.MapTools;
   
   public class DisplayZone
   {
       
      
      protected var _otherSize:uint = 0;
      
      protected var _size:uint = 0;
      
      protected var _shape:uint = 0;
      
      protected var _direction:uint = 1;
      
      protected var _dataMapProvider:IDataMapProvider = null;
      
      public function DisplayZone(shape:uint, otherSize:uint, size:uint, dataMapProvider:IDataMapProvider = null)
      {
         super();
         this._shape = shape;
         this._otherSize = otherSize;
         this._size = size;
         this._dataMapProvider = dataMapProvider;
      }
      
      public function get otherSize() : uint
      {
         return this._otherSize;
      }
      
      public function get size() : uint
      {
         return this._size;
      }
      
      public function get shape() : uint
      {
         return this._shape;
      }
      
      public function get surface() : uint
      {
         return 0;
      }
      
      public function get isInfinite() : Boolean
      {
         return this._size === 63;
      }
      
      public function set direction(direction:int) : void
      {
         this._direction = direction;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         return new Vector.<uint>(0);
      }
      
      protected function tryAddCell(x:int, y:int, cellMap:Vector.<uint>) : void
      {
         if(this._dataMapProvider === null || this._dataMapProvider.pointMov(x,y))
         {
            cellMap.push(MapTools.getCellIdByCoord(x,y));
         }
      }
   }
}
