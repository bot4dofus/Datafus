package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class XYZ extends CoreColor implements IColorSpace
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      public function XYZ(x:Number = 0, y:Number = 0, z:Number = 0)
      {
         super();
         this._x = x;
         this._y = y;
         this._z = z;
         this._color = this.generateColorFromXYZ(x,y,z);
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(value:int) : void
      {
         this._color = value;
         var xyz:XYZ = this.generateXYZFromColor(value);
         this._x = xyz.x;
         this._y = xyz.y;
         this._z = xyz.z;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(value:Number) : void
      {
         this._x = value;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(value:Number) : void
      {
         this._y = value;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function get z() : Number
      {
         return this._z;
      }
      
      public function set z(value:Number) : void
      {
         this._z = value;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function clone() : IColorSpace
      {
         return new XYZ(this._x,this._y,this._z);
      }
      
      private function generateColorFromXYZ(xval:Number, yval:Number, zval:Number) : int
      {
         var x:Number = xval / 100;
         var y:Number = yval / 100;
         var z:Number = zval / 100;
         var r:Number = x * 3.2406 + y * -1.5372 + z * -0.4986;
         var g:Number = x * -0.9689 + y * 1.8758 + z * 0.0415;
         var b:Number = x * 0.0557 + y * -0.204 + z * 1.057;
         if(r > 0.0031308)
         {
            r = 1.055 * Math.pow(r,1 / 2.4) - 0.055;
         }
         else
         {
            r = 12.92 * r;
         }
         if(g > 0.0031308)
         {
            g = 1.055 * Math.pow(g,1 / 2.4) - 0.055;
         }
         else
         {
            g = 12.92 * g;
         }
         if(b > 0.0031308)
         {
            b = 1.055 * Math.pow(b,1 / 2.4) - 0.055;
         }
         else
         {
            b = 12.92 * b;
         }
         var cR:* = Math.round(r) << 16;
         var cG:* = Math.round(g) << 8;
         var cB:int = Math.round(b);
         return cR | cG | cB;
      }
      
      private function generateXYZFromColor(color:int) : XYZ
      {
         var r:Number = (color >> 16 & 255) / 255;
         var g:Number = (color >> 8 & 255) / 255;
         var b:Number = (color & 255) / 255;
         if(r > 0.04045)
         {
            r = Math.pow((r + 0.055) / 1.055,2.4);
         }
         else
         {
            r /= 12.92;
         }
         if(g > 0.04045)
         {
            g = Math.pow((g + 0.055) / 1.055,2.4);
         }
         else
         {
            g /= 12.92;
         }
         if(b > 0.04045)
         {
            b = Math.pow((b + 0.055) / 1.055,2.4);
         }
         else
         {
            b /= 12.92;
         }
         r *= 100;
         g *= 100;
         b *= 100;
         return new XYZ(r * 0.4124 + g * 0.3576 + b * 0.1805,r * 0.2126 + g * 0.7152 + b * 0.0722,r * 0.0193 + g * 0.1192 + b * 0.9505);
      }
   }
}
