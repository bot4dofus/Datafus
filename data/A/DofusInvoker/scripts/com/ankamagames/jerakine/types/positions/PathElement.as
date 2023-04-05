package com.ankamagames.jerakine.types.positions
{
   public class PathElement
   {
       
      
      public var step:MapPoint;
      
      private var _nOrientation:uint;
      
      public function PathElement(step:MapPoint = null, orientation:uint = 0)
      {
         super();
         if(!step)
         {
            this.step = new MapPoint();
         }
         else
         {
            this.step = step;
         }
         this._nOrientation = orientation;
      }
      
      public function get orientation() : uint
      {
         return this._nOrientation;
      }
      
      public function set orientation(nValue:uint) : void
      {
         this._nOrientation = nValue;
      }
      
      public function get cellId() : uint
      {
         return this.step.cellId;
      }
      
      public function toString() : String
      {
         return "[PathElement(cellId:" + this.cellId + ", x:" + this.step.x + ", y:" + this.step.y + ", orientation:" + this._nOrientation + ")]";
      }
   }
}
