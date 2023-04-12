package com.somerandomdude.colortoolkit.spaces
{
   public interface IColorSpace
   {
       
      
      function toGrayscale() : Gray;
      
      function toRGB() : RGB;
      
      function toCMYK() : CMYK;
      
      function toHSB() : HSB;
      
      function toLab() : Lab;
      
      function toXYZ() : XYZ;
      
      function toHSL() : HSL;
      
      function clone() : IColorSpace;
   }
}
