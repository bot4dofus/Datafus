package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.Color;
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Tetrad extends ColorWheelScheme implements IColorScheme
   {
       
      
      private var _angle:Number;
      
      public var alt:Boolean;
      
      public function Tetrad(primaryColor:int, angle:Number = 90)
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
         var multiplier:Number = NaN;
         var _primaryCol:Color = new Color(_primaryColor);
         var c1:HSB = new HSB();
         c1.color = ColorUtil.rybRotate(_primaryColor,this._angle);
         if(!this.alt)
         {
            if(_primaryCol.brightness < 50)
            {
               c1.brightness += 20;
            }
            else
            {
               c1.brightness -= 20;
            }
         }
         else
         {
            multiplier = (50 - _primaryCol.brightness) / 50;
            c1.brightness += Math.min(20,Math.max(-20,20 * multiplier));
         }
         _colors.push(c1.color);
         var c2:HSB = new HSB();
         c2.color = ColorUtil.rybRotate(_primaryColor,this._angle * 2);
         if(!this.alt)
         {
            if(_primaryCol.brightness > 50)
            {
               c2.brightness += 10;
            }
            else
            {
               c2.brightness -= 10;
            }
         }
         else
         {
            multiplier = (50 - _primaryCol.brightness) / 50;
            c2.brightness += Math.min(10,Math.max(-10,10 * multiplier));
         }
         _colors.push(c2.color);
         var c3:HSB = new HSB();
         c3.color = ColorUtil.rybRotate(_primaryColor,this._angle * 3);
         c3.brightness += 10;
         _colors.push(c3.color);
      }
   }
}
