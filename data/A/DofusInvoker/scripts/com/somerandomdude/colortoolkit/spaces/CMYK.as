package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class CMYK extends CoreColor implements IColorSpace
   {
       
      
      private var _cyan:Number;
      
      private var _yellow:Number;
      
      private var _magenta:Number;
      
      private var _black:Number;
      
      public function CMYK(cyan:Number = 0, magenta:Number = 0, yellow:Number = 0, black:Number = 0)
      {
         super();
         this._cyan = Math.min(100,Math.max(cyan,0));
         this._magenta = Math.min(100,Math.max(magenta,0));
         this._yellow = Math.min(100,Math.max(yellow,0));
         this._black = Math.min(100,Math.max(black,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get cyan() : Number
      {
         return this._cyan;
      }
      
      public function set cyan(value:Number) : void
      {
         this._cyan = Math.min(100,Math.max(value,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get magenta() : Number
      {
         return this._magenta;
      }
      
      public function set magenta(value:Number) : void
      {
         this._magenta = Math.min(100,Math.max(value,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get yellow() : Number
      {
         return this._yellow;
      }
      
      public function set yellow(value:Number) : void
      {
         this._yellow = Math.min(100,Math.max(value,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get black() : Number
      {
         return this._black;
      }
      
      public function set black(value:Number) : void
      {
         this._black = Math.min(100,Math.max(value,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(value:int) : void
      {
         this._color = value;
         var cmyk:CMYK = this.generateColorsFromHex(value);
         this._cyan = cmyk.cyan;
         this._magenta = cmyk.magenta;
         this._yellow = cmyk.yellow;
         this._black = cmyk.black;
      }
      
      public function clone() : IColorSpace
      {
         return new CMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      private function generateColorsFromHex(color:int) : CMYK
      {
         var c:Number = NaN;
         var m:Number = NaN;
         var y:Number = NaN;
         var k:Number = NaN;
         var var_K:Number = NaN;
         var r:Number = color >> 16 & 255;
         var g:Number = color >> 8 & 255;
         var b:Number = color & 255;
         c = 1 - r / 255;
         m = 1 - g / 255;
         y = 1 - b / 255;
         var_K = 1;
         if(c < var_K)
         {
            var_K = c;
         }
         if(m < var_K)
         {
            var_K = m;
         }
         if(y < var_K)
         {
            var_K = y;
         }
         if(var_K == 1)
         {
            c = 0;
            m = 0;
            y = 0;
         }
         else
         {
            c = (c - var_K) / (1 - var_K) * 100;
            m = (m - var_K) / (1 - var_K) * 100;
            y = (y - var_K) / (1 - var_K) * 100;
         }
         k = var_K * 100;
         return new CMYK(c,m,y,k);
      }
      
      private function generateColorsFromCMYK(cyan:Number, magenta:Number, yellow:Number, black:Number) : int
      {
         cyan = Math.min(100,cyan + black);
         magenta = Math.min(100,magenta + black);
         yellow = Math.min(100,yellow + black);
         var r:Number = (100 - cyan) * (255 / 100);
         var g:Number = (100 - magenta) * (255 / 100);
         var b:Number = (100 - yellow) * (255 / 100);
         return r << 16 ^ g << 8 ^ b;
      }
   }
}
