package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.geom.Point;
   
   public class Rectangle2 implements IRectangle
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _height:Number;
      
      private var _width:Number;
      
      public function Rectangle2(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
      {
         super();
         this._x = x;
         this._y = y;
         this._width = width;
         this._height = height;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(nValue:Number) : void
      {
         this._x = nValue;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(nValue:Number) : void
      {
         this._y = nValue;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(nValue:Number) : void
      {
         this._width = nValue;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(nValue:Number) : void
      {
         this._height = nValue;
      }
      
      public function localToGlobal(point:Point) : Point
      {
         return point;
      }
      
      public function globalToLocal(point:Point) : Point
      {
         return point;
      }
      
      public function toString() : String
      {
         return "x " + this._x + ":, y: " + this._y + ", w: " + this._width + ", h: " + this._height;
      }
   }
}
