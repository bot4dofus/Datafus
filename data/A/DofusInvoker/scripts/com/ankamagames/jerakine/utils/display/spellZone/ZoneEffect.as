package com.ankamagames.jerakine.utils.display.spellZone
{
   public class ZoneEffect implements IZoneShape
   {
       
      
      private var _zoneSize:uint;
      
      private var _zoneShape:uint;
      
      public function ZoneEffect(zsize:uint, zshape:uint)
      {
         super();
         this._zoneSize = zsize;
         this._zoneShape = zshape;
      }
      
      public function get zoneSize() : uint
      {
         return this._zoneSize;
      }
      
      public function set zoneSize(pZoneSize:uint) : void
      {
         this._zoneSize = pZoneSize;
      }
      
      public function get zoneShape() : uint
      {
         return this._zoneShape;
      }
      
      public function set zoneShape(pZoneShape:uint) : void
      {
         this._zoneShape = pZoneShape;
      }
   }
}
