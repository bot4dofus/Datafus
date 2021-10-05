package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class LineZone implements Zone2D
   {
       
      
      private var _point1:Point;
      
      private var _point2:Point;
      
      private var _length:Point;
      
      public function LineZone(point1:Point, point2:Point)
      {
         super();
         this._point1 = point1;
         this._point2 = point2;
         this._length = point2.subtract(point1);
      }
      
      public function get point1() : Point
      {
         return this._point1;
      }
      
      public function set point1(value:Point) : void
      {
         this._point1 = value;
         this._length = this.point2.subtract(this.point1);
      }
      
      public function get point2() : Point
      {
         return this._point2;
      }
      
      public function set point2(value:Point) : void
      {
         this._point2 = value;
         this._length = this.point2.subtract(this.point1);
      }
      
      public function contains(x:Number, y:Number) : Boolean
      {
         if((x - this._point1.x) * this._length.y - (y - this._point1.y) * this._length.x != 0)
         {
            return false;
         }
         return (x - this._point1.x) * (x - this._point2.x) + (y - this._point1.y) * (y - this._point2.y) <= 0;
      }
      
      public function getLocation() : Point
      {
         var ret:Point = this._point1.clone();
         var scale:Number = Math.random();
         ret.x += this._length.x * scale;
         ret.y += this._length.y * scale;
         return ret;
      }
      
      public function getArea() : Number
      {
         return this._length.length;
      }
   }
}
