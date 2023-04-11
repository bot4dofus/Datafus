package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Triad extends ColorWheelScheme implements IColorScheme
   {
       
      
      private var _angle:Number;
      
      public function Triad(primaryColor:int, angle:Number = 120)
      {
         this._angle = angle;
         super(primaryColor);
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      public function set angle(value:Number) : void
      {
         _colors = new ColorList();
         this._angle = value;
         this.generate();
      }
      
      override protected function generate() : void
      {
         var c1:HSB = new HSB();
         c1.color = ColorUtil.rybRotate(_primaryColor,this._angle);
         c1.brightness += 10;
         _colors.push(c1.color);
         var c2:HSB = new HSB();
         c2.color = ColorUtil.rybRotate(_primaryColor,-this._angle);
         c2.brightness += 10;
         _colors.push(c2.color);
      }
   }
}
