package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class SplitComplementary extends ColorWheelScheme implements IColorScheme
   {
       
      
      public function SplitComplementary(primaryColor:int)
      {
         super(primaryColor);
      }
      
      override protected function generate() : void
      {
         var c1:HSB = new HSB();
         var c2:HSB = new HSB();
         c1.color = ColorUtil.rybRotate(_primaryColor,150);
         c2.color = ColorUtil.rybRotate(_primaryColor,210);
         c1.brightness += 10;
         c2.brightness += 10;
         _colors.push(c1.color);
         _colors.push(c2.color);
      }
   }
}
