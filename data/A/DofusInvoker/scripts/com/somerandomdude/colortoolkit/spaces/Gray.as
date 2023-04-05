package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class Gray extends CoreColor implements IColorSpace
   {
       
      
      private var _gray:Number;
      
      private var _grayscale:int;
      
      public function Gray(gray:Number = 0)
      {
         super();
         this.gray = gray;
         this._grayscale = this.convertGrayValuetoHex(gray);
      }
      
      public function get gray() : Number
      {
         return this._gray;
      }
      
      public function set gray(value:Number) : void
      {
         value = Math.min(255,Math.max(value,0));
         this._gray = value;
         this._grayscale = this.convertGrayValuetoHex(this._gray);
      }
      
      public function get color() : int
      {
         return this._grayscale;
      }
      
      public function clone() : IColorSpace
      {
         return new Gray(this._gray);
      }
      
      public function convertHexToGrayscale(color:int) : Number
      {
         var r:* = 0;
         var g:* = 0;
         var b:* = 0;
         r = color >> 16 & 255;
         g = color >> 8 & 255;
         b = color & 255;
         var gray:Number = 0.3 * r + 0.59 * g + 0.11 * b;
         this._gray = gray;
         this._grayscale = gray << 16 ^ gray << 8 ^ gray;
         return gray << 16 ^ gray << 8 ^ gray;
      }
      
      private function convertGrayValuetoHex(gray:Number) : int
      {
         return gray << 16 ^ gray << 8 ^ gray;
      }
   }
}
