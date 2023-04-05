package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class HSB extends CoreColor implements IColorSpace
   {
       
      
      private var _hue:Number;
      
      private var _saturation:Number;
      
      private var _brightness:Number;
      
      public function HSB(hue:Number = 0, saturation:Number = 0, brightness:Number = 0)
      {
         super();
         this._hue = Math.min(360,Math.max(hue,0));
         this._saturation = Math.min(100,Math.max(saturation,0));
         this._brightness = Math.min(100,Math.max(brightness,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get hue() : Number
      {
         return this._hue;
      }
      
      public function set hue(value:Number) : void
      {
         this._hue = Math.min(360,Math.max(value,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set saturation(value:Number) : void
      {
         this._saturation = Math.min(100,Math.max(value,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set brightness(value:Number) : void
      {
         this._brightness = Math.min(100,Math.max(value,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get color() : Number
      {
         return this._color;
      }
      
      public function set color(value:Number) : void
      {
         this._color = value;
         var hsb:HSB = this.generateColorFromHex(value);
         this._hue = hsb.hue;
         this._saturation = hsb.saturation;
         this._brightness = hsb.brightness;
      }
      
      public function clone() : IColorSpace
      {
         return new HSB(this._hue,this._saturation,this._brightness);
      }
      
      private function generateColorFromHex(color:int) : HSB
      {
         var h:Number = NaN;
         var s:Number = NaN;
         var v:Number = NaN;
         var min:Number = NaN;
         var max:Number = NaN;
         var delta:Number = NaN;
         var r:Number = color >> 16 & 255;
         var g:Number = color >> 8 & 255;
         var b:Number = color & 255;
         r /= 255;
         g /= 255;
         b /= 255;
         min = Math.min(r,g,b);
         max = Math.max(r,g,b);
         v = max * 100;
         delta = max - min;
         if(delta == 0)
         {
            delta = 1;
         }
         if(max != 0)
         {
            s = delta / max * 100;
            if(r == max)
            {
               h = (g - b) / delta;
            }
            else if(g == max)
            {
               h = 2 + (b - r) / delta;
            }
            else
            {
               h = 4 + (r - g) / delta;
            }
            h *= 60;
            if(h < 0)
            {
               h += 360;
            }
            return new HSB(h,s,v);
         }
         s = 0;
         h = -1;
         return new HSB(h,s,v);
      }
      
      private function generateColorFromHSB(hue:Number, saturation:Number, brightness:Number) : int
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var i:Number = NaN;
         var f:Number = NaN;
         var p:Number = NaN;
         var q:Number = NaN;
         var t:Number = NaN;
         hue %= 360;
         if(brightness == 0)
         {
            return 0;
         }
         saturation /= 100;
         brightness /= 100;
         hue /= 60;
         i = Math.floor(hue);
         f = hue - i;
         p = brightness * (1 - saturation);
         q = brightness * (1 - saturation * f);
         t = brightness * (1 - saturation * (1 - f));
         if(i == 0)
         {
            r = brightness;
            g = t;
            b = p;
         }
         else if(i == 1)
         {
            r = q;
            g = brightness;
            b = p;
         }
         else if(i == 2)
         {
            r = p;
            g = brightness;
            b = t;
         }
         else if(i == 3)
         {
            r = p;
            g = q;
            b = brightness;
         }
         else if(i == 4)
         {
            r = t;
            g = p;
            b = brightness;
         }
         else if(i == 5)
         {
            r = brightness;
            g = p;
            b = q;
         }
         r = Math.floor(r * 255);
         g = Math.floor(g * 255);
         b = Math.floor(b * 255);
         return r << 16 ^ g << 8 ^ b;
      }
   }
}
