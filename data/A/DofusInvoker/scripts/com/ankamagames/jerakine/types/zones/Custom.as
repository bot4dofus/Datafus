package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class Custom extends DisplayZone
   {
       
      
      private var _cells:Vector.<uint>;
      
      public function Custom(cells:Vector.<uint>, dataMapProvider:IDataMapProvider = null)
      {
         super(SpellShapeEnum.UNKNOWN,0,0,dataMapProvider);
         this._cells = cells;
      }
      
      override public function get surface() : uint
      {
         return this._cells.length;
      }
      
      override public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         return this._cells;
      }
   }
}
