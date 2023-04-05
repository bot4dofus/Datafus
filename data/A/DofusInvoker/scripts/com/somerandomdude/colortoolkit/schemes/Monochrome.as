package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Monochrome extends ColorWheelScheme implements IColorScheme
   {
       
      
      public function Monochrome(primaryColor:int)
      {
         super(primaryColor);
      }
      
      override protected function generate() : void
      {
         var _primaryHSB:HSB = new HSB();
         _primaryHSB.color = _primaryColor;
         var c1:HSB = new HSB();
         c1.color = _primaryColor;
         c1.brightness = wrap(_primaryHSB.brightness,50,20,30);
         c1.saturation = wrap(_primaryHSB.saturation,30,10,20);
         _colors.push(c1.color);
         var c2:HSB = new HSB();
         c2.color = _primaryColor;
         c2.brightness = wrap(_primaryHSB.brightness,20,20,60);
         _colors.push(c2.color);
         var c3:HSB = new HSB();
         c3.color = _primaryColor;
         c3.brightness = Math.max(20,_primaryHSB.brightness + (100 - _primaryHSB.brightness) * 0.2);
         c3.saturation = wrap(_primaryHSB.saturation,30,10,30);
         _colors.push(c3.color);
         var c4:HSB = new HSB();
         c4.color = _primaryColor;
         c4.brightness = wrap(_primaryHSB.brightness,50,20,30);
         _colors.push(c4.color);
      }
   }
}
