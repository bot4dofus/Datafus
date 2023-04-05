package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class HSL extends CoreColor implements IColorSpace
   {
       
      
      private var _hue:Number;
      
      private var _saturation:Number;
      
      private var _lightness:Number;
      
      public function HSL(hue:Number = 0, saturation:Number = 0, lightness:Number = 0)
      {
         super();
         this._hue = Math.min(360,Math.max(hue,0));
         this._saturation = Math.min(100,Math.max(saturation,0));
         this._lightness = Math.min(100,Math.max(lightness,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get hue() : Number
      {
         return this._hue;
      }
      
      public function set hue(value:Number) : void
      {
         this._hue = Math.min(360,Math.max(value,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set saturation(value:Number) : void
      {
         this._saturation = Math.min(100,Math.max(value,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get lightness() : Number
      {
         return this._lightness;
      }
      
      public function set lightness(value:Number) : void
      {
         this._lightness = Math.min(100,Math.max(value,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get color() : Number
      {
         return this._color;
      }
      
      public function set color(value:Number) : void
      {
         this._color = value;
         var hsl:HSL = this.generateColorFromHex(value);
         this._hue = hsl.hue;
         this._saturation = hsl.saturation;
         this._lightness = hsl.lightness;
      }
      
      public function clone() : IColorSpace
      {
         return new HSL(this._hue,this._saturation,this._lightness);
      }
      
      private function generateColorFromHex(color:int) : HSL
      {
         var h:Number = NaN;
         var s:Number = NaN;
         var l:Number = NaN;
         var d:Number = NaN;
         var r:Number = color >> 16 & 255;
         var g:Number = color >> 8 & 255;
         var b:Number = color & 255;
         r /= 255;
         g /= 255;
         b /= 255;
         var max:Number = Math.max(r,g,b);
         var min:Number = Math.min(r,g,b);
         h = s = l = (max + min) / 2;
         if(max == min)
         {
            h = s = 0;
         }
         else
         {
            d = max - min;
            s = l > 0.5 ? Number(d / (2 - max - min)) : Number(d / (max + min));
            switch(max)
            {
               case r:
                  h = (g - b) / d + (g < b ? 6 : 0);
                  break;
               case g:
                  h = (b - r) / d + 2;
                  break;
               case b:
                  h = (r - g) / d + 4;
            }
            h /= 6;
         }
         h = Math.round(h * 360);
         s = Math.round(s * 100);
         l = Math.round(l * 100);
         return new HSL(h,s,l);
      }
      
      private function generateColorFromHSL(hue:Number, saturation:Number, lightness:Number) : int
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var q:Number = NaN;
         var p:Number = NaN;
         var hue:Number = hue / 360;
         var saturation:Number = saturation / 100;
         var lightness:Number = lightness / 100;
         if(saturation == 0)
         {
            r = g = Number(b = Number(lightness));
         }
         else
         {
            var hue2rgb:Function = function(p:Number, q:Number, t:Number):Number
            {
               if(t < 0)
               {
                  t += 1;
               }
               if(t > 1)
               {
                  t--;
               }
               if(t < 1 / 6)
               {
                  return p + (q - p) * 6 * t;
               }
               if(t < 1 / 2)
               {
                  return q;
               }
               if(t < 2 / 3)
               {
                  return p + (q - p) * (2 / 3 - t) * 6;
               }
               return p;
            };
            q = lightness < 0.5 ? Number(lightness * (1 + saturation)) : Number(lightness + saturation - lightness * saturation);
            p = 2 * lightness - q;
            r = hue2rgb(p,q,hue + 1 / 3);
            g = hue2rgb(p,q,hue);
            b = hue2rgb(p,q,hue - 1 / 3);
         }
         r = Math.floor(r * 255);
         g = Math.floor(g * 255);
         b = Math.floor(b * 255);
         return r << 16 ^ g << 8 ^ b;
      }
   }
}
