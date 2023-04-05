package com.somerandomdude.colortoolkit
{
   import com.somerandomdude.colortoolkit.spaces.CMYK;
   import com.somerandomdude.colortoolkit.spaces.Gray;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.spaces.HSL;
   import com.somerandomdude.colortoolkit.spaces.Lab;
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.XYZ;
   import com.somerandomdude.colortoolkit.spaces.YUV;
   
   public class CoreColor
   {
       
      
      protected var _color:int;
      
      public function CoreColor()
      {
         super();
      }
      
      public function toLab() : Lab
      {
         var lab:Lab = new Lab();
         lab.color = this._color;
         return lab;
      }
      
      public function toGrayscale() : Gray
      {
         var g:Gray = new Gray();
         g.convertHexToGrayscale(this._color);
         return g;
      }
      
      public function toRGB() : RGB
      {
         var rgb:RGB = new RGB();
         rgb.color = this._color;
         return rgb;
      }
      
      public function toHSB() : HSB
      {
         var hsb:HSB = new HSB();
         hsb.color = this._color;
         return hsb;
      }
      
      public function toHSL() : HSL
      {
         var h:HSL = new HSL();
         h.color = this._color;
         return h;
      }
      
      public function toCMYK() : CMYK
      {
         var cmyk:CMYK = new CMYK();
         cmyk.color = this._color;
         return cmyk;
      }
      
      public function toXYZ() : XYZ
      {
         var xyz:XYZ = new XYZ();
         xyz.color = this._color;
         return xyz;
      }
      
      public function toYUV() : YUV
      {
         var yuv:YUV = new YUV();
         yuv.color = this._color;
         return yuv;
      }
   }
}
