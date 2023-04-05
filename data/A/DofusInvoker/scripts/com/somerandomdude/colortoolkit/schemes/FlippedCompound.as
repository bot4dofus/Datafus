package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class FlippedCompound extends ColorWheelScheme implements IColorScheme
   {
       
      
      public function FlippedCompound(primaryColor:int)
      {
         super(primaryColor);
      }
      
      override protected function generate() : void
      {
         var _primaryHSB:HSB = new HSB();
         _primaryHSB.color = _primaryColor;
         var d:Number = 1;
         var c1:HSB = new HSB();
         c1.color = ColorUtil.rybRotate(_primaryColor,30 * -1);
         c1.brightness = wrap(_primaryHSB.brightness,25,60,25);
         _colors.push(c1.color);
         var c2:HSB = new HSB();
         c2.color = ColorUtil.rybRotate(_primaryColor,30 * -1);
         c2.brightness = wrap(_primaryHSB.brightness,40,10,40);
         c2.saturation = wrap(_primaryHSB.saturation,40,20,40);
         _colors.push(c2.color);
         var c3:HSB = new HSB();
         c3.color = ColorUtil.rybRotate(_primaryColor,160 * -1);
         c3.brightness = Math.max(20,_primaryHSB.brightness);
         c3.saturation = wrap(_primaryHSB.saturation,25,10,25);
         _colors.push(c3.color);
         var c4:HSB = new HSB();
         c4.color = ColorUtil.rybRotate(_primaryColor,150 * -1);
         c4.brightness = wrap(_primaryHSB.brightness,30,60,30);
         c4.saturation = wrap(_primaryHSB.saturation,10,80,10);
         _colors.push(c4.color);
         var c5:HSB = new HSB();
         c5.color = ColorUtil.rybRotate(_primaryColor,150 * -1);
         c5.brightness = wrap(_primaryHSB.brightness,40,20,40);
         c5.saturation = wrap(_primaryHSB.saturation,10,80,10);
         _colors.push(c5.color);
      }
   }
}
