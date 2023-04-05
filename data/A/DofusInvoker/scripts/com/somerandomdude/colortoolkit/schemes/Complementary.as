package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Complementary extends ColorWheelScheme implements IColorScheme
   {
       
      
      public function Complementary(primaryColor:int)
      {
         super(primaryColor);
      }
      
      override protected function generate() : void
      {
         var _primaryHSB:HSB = new HSB();
         _primaryHSB.color = _primaryColor;
         var contrasting:HSB = new HSB();
         contrasting.color = _primaryColor;
         if(_primaryHSB.brightness > 40)
         {
            contrasting.brightness = 10 + _primaryHSB.brightness * 0.25;
         }
         else
         {
            contrasting.brightness = 100 - _primaryHSB.brightness * 0.25;
         }
         _colors.push(contrasting.color);
         var supporting:HSB = new HSB();
         supporting.color = _primaryColor;
         supporting.brightness = 30 + _primaryHSB.brightness;
         supporting.saturation = 10 + _primaryHSB.saturation * 0.3;
         _colors.push(supporting.color);
         var complement:HSB = new HSB();
         complement.color = ColorUtil.rybRotate(_primaryColor,180);
         _colors.push(complement.color);
         var contrastingComplement:HSB = new HSB();
         contrastingComplement.color = complement.color;
         if(complement.brightness > 30)
         {
            contrastingComplement.brightness = 10 + complement.brightness * 0.25;
         }
         else
         {
            contrastingComplement.brightness = 100 - complement.brightness * 0.25;
         }
         _colors.push(contrastingComplement.color);
         var supportingComplement:HSB = new HSB();
         supportingComplement.color = complement.color;
         supportingComplement.brightness = 30 + complement.brightness;
         supportingComplement.saturation = 10 + complement.saturation * 0.3;
         _colors.push(supportingComplement.color);
      }
   }
}
