package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Analogous extends ColorWheelScheme implements IColorScheme
   {
       
      
      private var _angle:Number;
      
      private var _contrast:Number;
      
      public function Analogous(primaryColor:int, angle:Number = 10, contrast:Number = 25)
      {
         this._angle = angle;
         this._contrast = contrast;
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
      
      public function get contrast() : Number
      {
         return this._contrast;
      }
      
      public function set contrast(value:Number) : void
      {
         _colors = new ColorList();
         this._contrast = value;
         this.generate();
      }
      
      override protected function generate() : void
      {
         var one:Number = NaN;
         var two:Number = NaN;
         var t:Number = NaN;
         var _primaryHSB:HSB = new HSB();
         _primaryHSB.color = _primaryColor;
         var newHSB:HSB = new HSB();
         var array:Array = new Array(new Array(1,2.2),new Array(2,1),new Array(-1,-0.5),new Array(-2,1));
         for(var i:Number = 0; i < array.length; i++)
         {
            one = array[i][0];
            two = array[i][1];
            newHSB.color = ColorUtil.rybRotate(_primaryHSB.color,this._angle * one);
            t = 0.44 - two * 0.1;
            if(_primaryHSB.brightness - this._contrast * two < t)
            {
               newHSB.brightness = t * 100;
            }
            else
            {
               newHSB.brightness = _primaryHSB.brightness - this._contrast * two;
            }
            newHSB.saturation -= 5;
            _colors.push(newHSB.color);
         }
      }
   }
}
