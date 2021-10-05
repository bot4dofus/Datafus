package org.flintparticles.common.utils
{
   public function interpolateColors(color1:uint, color2:uint, ratio:Number) : uint
   {
      var inv:Number = 1 - ratio;
      var red:uint = Math.round((color1 >>> 16 & 255) * ratio + (color2 >>> 16 & 255) * inv);
      var green:uint = Math.round((color1 >>> 8 & 255) * ratio + (color2 >>> 8 & 255) * inv);
      var blue:uint = Math.round((color1 & 255) * ratio + (color2 & 255) * inv);
      var alpha:uint = Math.round((color1 >>> 24 & 255) * ratio + (color2 >>> 24 & 255) * inv);
      return alpha << 24 | red << 16 | green << 8 | blue;
   }
}
