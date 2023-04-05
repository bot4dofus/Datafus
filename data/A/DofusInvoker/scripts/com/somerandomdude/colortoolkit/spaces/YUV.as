package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class YUV extends CoreColor implements IColorSpace
   {
       
      
      private var _y:Number;
      
      private var _u:Number;
      
      private var _v:Number;
      
      public function YUV(y:Number = 0, u:Number = 0, v:Number = 0)
      {
         super();
         this._y = y;
         this._u = u;
         this._v = v;
         _color = this.generateColorFromYUV(y,u,v);
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(value:int) : void
      {
         this._color = value;
         var yuv:YUV = this.generateYUVFromColor(value);
         this._y = yuv.y;
         this._u = yuv.u;
         this._v = yuv.v;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(value:Number) : void
      {
         this._y = value;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function get u() : Number
      {
         return this._u;
      }
      
      public function set u(value:Number) : void
      {
         this._u = value;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function get v() : Number
      {
         return this._v;
      }
      
      public function set v(value:Number) : void
      {
         this._v = value;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function clone() : IColorSpace
      {
         return new YUV(this._y,this._u,this._v);
      }
      
      private function generateColorFromYUV(y:Number, u:Number, v:Number) : int
      {
         var c:Number = NaN;
         var d:Number = NaN;
         var e:Number = NaN;
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         c = y - 16;
         d = u - 128;
         e = v - 128;
         r = Math.max(0,Math.min(298 * c + 409 * e + 128 >> 8,255));
         g = Math.max(0,Math.min(298 * c - 100 * d - 208 * e + 128 >> 8,255));
         b = Math.max(0,Math.min(298 * c + 516 * d + 128 >> 8,255));
         var cR:* = Math.round(r) << 16;
         var cG:* = Math.round(g) << 8;
         var cB:int = Math.round(b);
         return cR | cG | cB;
      }
      
      private function generateYUVFromColor(color:int) : YUV
      {
         var y:Number = NaN;
         var u:Number = NaN;
         var v:Number = NaN;
         var r:Number = (color >> 16 & 255) / 255;
         var g:Number = (color >> 8 & 255) / 255;
         var b:Number = (color & 255) / 255;
         y = 0.299 * r + 0.114 * g + 0.587 * b;
         u = 0.436 * (b - y) / (1 - 0.114);
         v = 0.615 * (r - y) / (1 - 0.299);
         return new YUV(r * 0.4124 + g * 0.3576 + b * 0.1805,r * 0.2126 + g * 0.7152 + b * 0.0722,r * 0.0193 + g * 0.1192 + b * 0.9505);
      }
   }
}
