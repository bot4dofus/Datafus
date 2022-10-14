package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Custom implements IZone
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Custom));
       
      
      private var _aCells:Vector.<uint>;
      
      public function Custom(cells:Vector.<uint>)
      {
         super();
         this._aCells = cells;
      }
      
      public function get radius() : uint
      {
         return null;
      }
      
      public function set radius(n:uint) : void
      {
      }
      
      public function get surface() : uint
      {
         return this._aCells.length;
      }
      
      public function set minRadius(r:uint) : void
      {
      }
      
      public function get minRadius() : uint
      {
         return null;
      }
      
      public function set direction(d:uint) : void
      {
      }
      
      public function get direction() : uint
      {
         return null;
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint>
      {
         return this._aCells;
      }
   }
}
