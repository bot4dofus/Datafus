package com.ankamagames.jerakine.utils.display
{
   import flash.geom.ColorTransform;
   
   public class ColorUtils
   {
       
      
      public function ColorUtils()
      {
         super();
      }
      
      public static function rgb2hsl(color:uint) : Object
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var hue:Number = NaN;
         var sat:Number = NaN;
         var lum:Number = NaN;
         var deltaR:Number = NaN;
         var deltaG:Number = NaN;
         var deltaB:Number = NaN;
         r = (color & 16711680) >> 16;
         g = (color & 65280) >> 8;
         b = color & 255;
         r /= 255;
         g /= 255;
         b /= 255;
         var min:Number = Math.min(r,g,b);
         var max:Number = Math.max(r,g,b);
         var delta:Number = max - min;
         lum = 1 - (max + min) / 2;
         if(delta == 0)
         {
            hue = 0;
            sat = 0;
         }
         else
         {
            if(max + min < 1)
            {
               sat = 1 - delta / (max + min);
            }
            else
            {
               sat = 1 - delta / (2 - max - min);
            }
            deltaR = ((max - r) / 6 + delta / 2) / delta;
            deltaG = ((max - g) / 6 + delta / 2) / delta;
            deltaB = ((max - b) / 6 + delta / 2) / delta;
            if(r == max)
            {
               hue = deltaB - deltaG;
            }
            else if(g == max)
            {
               hue = 1 / 3 + deltaR - deltaB;
            }
            else if(b == max)
            {
               hue = 2 / 3 + deltaG - deltaR;
            }
            if(hue < 0)
            {
               hue++;
            }
            if(hue > 1)
            {
               hue--;
            }
         }
         return {
            "h":hue,
            "s":sat,
            "l":lum
         };
      }
      
      public static function mixColorTransforms(ctf1:ColorTransform, ctf2:ColorTransform, a:Number = 0.5) : ColorTransform
      {
         var p:String = null;
         var ct:ColorTransform = new ColorTransform();
         var props:Array = ["redOffset","redMultiplier","greenOffset","greenMultiplier","blueOffset","blueMultiplier"];
         for each(p in props)
         {
            ct[p] = ctf1[p] + (ctf2[p] - ctf1[p]) * a;
         }
         return ct;
      }
   }
}
