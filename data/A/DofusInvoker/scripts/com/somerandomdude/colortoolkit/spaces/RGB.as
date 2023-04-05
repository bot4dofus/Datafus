package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class RGB extends CoreColor implements IColorSpace
   {
       
      
      private var _red:Number;
      
      private var _green:Number;
      
      private var _blue:Number;
      
      public function RGB(r:Number = 0, g:Number = 0, b:Number = 0)
      {
         super();
         this._red = Math.min(255,Math.max(r,0));
         this._green = Math.min(255,Math.max(g,0));
         this._blue = Math.min(255,Math.max(b,0));
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get red() : Number
      {
         return this._red;
      }
      
      public function set red(value:Number) : void
      {
         value = Math.min(255,Math.max(value,0));
         this._red = value;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get green() : Number
      {
         return this._green;
      }
      
      public function set green(value:Number) : void
      {
         value = Math.min(255,Math.max(value,0));
         this._green = value;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get blue() : Number
      {
         return this._blue;
      }
      
      public function set blue(value:Number) : void
      {
         value = Math.min(255,Math.max(value,0));
         this._blue = value;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(value:int) : void
      {
         this._color = value;
         var rgb:RGB = this.hexToRGB(value);
         this._red = rgb.red;
         this._green = rgb.green;
         this._blue = rgb.blue;
      }
      
      public function clone() : IColorSpace
      {
         return new RGB(this._red,this._green,this._blue);
      }
      
      private function hexToRGB(color:int) : RGB
      {
         return new RGB(color >> 16 & 255,color >> 8 & 255,color & 255);
      }
      
      private function RGBToHex(r:int, g:int, b:int) : int
      {
         var cR:* = Math.round(r) << 16;
         var cG:* = Math.round(g) << 8;
         var cB:int = Math.round(b);
         return cR | cG | cB;
      }
   }
}
