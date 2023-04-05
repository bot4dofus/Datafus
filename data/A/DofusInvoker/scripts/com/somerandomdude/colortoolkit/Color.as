package com.somerandomdude.colortoolkit
{
   import com.somerandomdude.colortoolkit.schemes.Analogous;
   import com.somerandomdude.colortoolkit.schemes.ColorList;
   import com.somerandomdude.colortoolkit.schemes.Complementary;
   import com.somerandomdude.colortoolkit.schemes.Compound;
   import com.somerandomdude.colortoolkit.schemes.FlippedCompound;
   import com.somerandomdude.colortoolkit.schemes.Monochrome;
   import com.somerandomdude.colortoolkit.schemes.SplitComplementary;
   import com.somerandomdude.colortoolkit.schemes.Tetrad;
   import com.somerandomdude.colortoolkit.schemes.Triad;
   import com.somerandomdude.colortoolkit.spaces.CMYK;
   import com.somerandomdude.colortoolkit.spaces.Gray;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.spaces.Lab;
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.XYZ;
   
   public class Color extends CoreColor
   {
       
      
      private var _cmyk:CMYK;
      
      private var _rgb:RGB;
      
      private var _hsb:HSB;
      
      private var _gray:Gray;
      
      private var _lab:Lab;
      
      private var _xyz:XYZ;
      
      private var _analogous:Analogous;
      
      private var _analogousAngle:Number = 10;
      
      private var _analogousContrast:Number = 25;
      
      private var _complementary:Complementary;
      
      private var _splitComplementary:SplitComplementary;
      
      private var _compound:Compound;
      
      private var _flippedCompound:FlippedCompound;
      
      private var _monochrome:Monochrome;
      
      private var _tetrad:Tetrad;
      
      private var _tetradAngle:Number = 90;
      
      private var _triad:Triad;
      
      private var _triadAngle:Number = 120;
      
      public function Color(color:int)
      {
         super();
         this._cmyk = new CMYK();
         this._rgb = new RGB();
         this._hsb = new HSB();
         this._gray = new Gray();
         this._lab = new Lab();
         this._xyz = new XYZ();
         this.color = color;
      }
      
      public function get analogousScheme() : ColorList
      {
         if(!this._analogous)
         {
            this._analogous = new Analogous(_color,this._analogousAngle,this._analogousContrast);
         }
         else
         {
            this._analogous.primaryColor = _color;
         }
         return this._analogous.colors;
      }
      
      public function get analogousAngle() : Number
      {
         return this._tetradAngle;
      }
      
      public function set analogousAngle(value:Number) : void
      {
         this._analogousAngle = value;
         if(this._analogous)
         {
            this._analogous.angle = value;
         }
      }
      
      public function get analogousContrast() : Number
      {
         return this._tetradAngle;
      }
      
      public function set analogousContrast(value:Number) : void
      {
         this._analogousContrast = value;
         if(this._analogous)
         {
            this._analogous.contrast = value;
         }
      }
      
      public function get complemenartyScheme() : ColorList
      {
         if(!this._complementary)
         {
            this._complementary = new Complementary(_color);
         }
         else
         {
            this._complementary.primaryColor = _color;
         }
         return this._complementary.colors;
      }
      
      public function get splitComplementaryScheme() : ColorList
      {
         if(!this._splitComplementary)
         {
            this._splitComplementary = new SplitComplementary(_color);
         }
         else
         {
            this._splitComplementary.primaryColor = _color;
         }
         return this._splitComplementary.colors;
      }
      
      public function get compoundScheme() : ColorList
      {
         if(!this._compound)
         {
            this._compound = new Compound(_color);
         }
         else
         {
            this._compound.primaryColor = _color;
         }
         return this._compound.colors;
      }
      
      public function get flippedCompoundScheme() : ColorList
      {
         if(!this._flippedCompound)
         {
            this._flippedCompound = new FlippedCompound(_color);
         }
         else
         {
            this._flippedCompound.primaryColor = _color;
         }
         return this._flippedCompound.colors;
      }
      
      public function get monochromeScheme() : ColorList
      {
         if(!this._monochrome)
         {
            this._monochrome = new Monochrome(_color);
         }
         else
         {
            this._monochrome.primaryColor = _color;
         }
         return this._monochrome.colors;
      }
      
      public function get tetradScheme() : ColorList
      {
         if(!this._tetrad)
         {
            this._tetrad = new Tetrad(_color,this._tetradAngle);
         }
         else
         {
            this._tetrad.primaryColor = _color;
         }
         return this._tetrad.colors;
      }
      
      public function get tetradScheme2() : ColorList
      {
         var tetrad:Tetrad = new Tetrad(_color,this._tetradAngle);
         tetrad.alt = true;
         tetrad.primaryColor = _color;
         return tetrad.colors;
      }
      
      public function get tetradAngle() : Number
      {
         return this._tetradAngle;
      }
      
      public function set tetradAngle(value:Number) : void
      {
         if(!this._tetrad)
         {
            this._tetrad = new Tetrad(_color,this._tetradAngle);
         }
         else
         {
            this._tetrad.angle = value;
         }
      }
      
      public function get triadScheme() : ColorList
      {
         if(!this._triad)
         {
            this._triad = new Triad(_color,this._triadAngle);
         }
         else
         {
            this._triad.primaryColor = _color;
         }
         return this._triad.colors;
      }
      
      public function get triadAngle() : Number
      {
         return this._triadAngle;
      }
      
      public function set triadAngle(value:Number) : void
      {
         if(!this._triad)
         {
            this._triad = new Triad(_color,this._triadAngle);
         }
         else
         {
            this._triad.angle = value;
         }
      }
      
      public function get red() : Number
      {
         return this._rgb.red;
      }
      
      public function set red(value:Number) : void
      {
         this._rgb.red = value;
         this._color = this._rgb.color;
      }
      
      public function get green() : Number
      {
         return this._rgb.green;
      }
      
      public function set green(value:Number) : void
      {
         this._rgb.green = value;
         this._color = this._rgb.color;
      }
      
      public function get blue() : Number
      {
         return this._rgb.blue;
      }
      
      public function set blue(value:Number) : void
      {
         this._rgb.blue = value;
         this._color = this._rgb.color;
      }
      
      public function get cyan() : Number
      {
         return this._cmyk.cyan;
      }
      
      public function set cyan(value:Number) : void
      {
         this._cmyk.cyan = value;
         this.color = this._cmyk.color;
      }
      
      public function get magenta() : Number
      {
         return this._cmyk.magenta;
      }
      
      public function set magenta(value:Number) : void
      {
         this._cmyk.magenta = value;
         this.color = this._cmyk.color;
      }
      
      public function get yellow() : Number
      {
         return this._cmyk.yellow;
      }
      
      public function set yellow(value:Number) : void
      {
         this._cmyk.yellow = value;
         this.color = this._cmyk.color;
      }
      
      public function get black() : Number
      {
         return this._cmyk.black;
      }
      
      public function set black(value:Number) : void
      {
         this._cmyk.black = value;
         this.color = this._cmyk.color;
      }
      
      public function get hue() : Number
      {
         return this._hsb.hue;
      }
      
      public function set hue(value:Number) : void
      {
         this._hsb.hue = value;
         this.color = this._hsb.color;
      }
      
      public function get saturation() : Number
      {
         return this._hsb.saturation;
      }
      
      public function set saturation(value:Number) : void
      {
         this._hsb.saturation = value;
         this.color = this._hsb.color;
      }
      
      public function get brightness() : Number
      {
         return this._hsb.brightness;
      }
      
      public function set brightness(value:Number) : void
      {
         this._hsb.brightness = value;
         this.color = this._hsb.color;
      }
      
      public function get gray() : Number
      {
         return this._gray.gray;
      }
      
      public function get lightness() : Number
      {
         return this._lab.lightness;
      }
      
      public function set lightness(value:Number) : void
      {
         this._lab.lightness = value;
         this.color = this._lab.color;
      }
      
      public function get a() : Number
      {
         return this._lab.a;
      }
      
      public function set a(value:Number) : void
      {
         this._lab.a = value;
         this.color = this._lab.color;
      }
      
      public function get b() : Number
      {
         return this._lab.b;
      }
      
      public function set b(value:Number) : void
      {
         this._lab.b = value;
         this.color = this._lab.color;
      }
      
      public function get x() : Number
      {
         return this._xyz.x;
      }
      
      public function set x(value:Number) : void
      {
         this._xyz.x = value;
         this.color = this._xyz.color;
      }
      
      public function get y() : Number
      {
         return this._xyz.y;
      }
      
      public function set y(value:Number) : void
      {
         this._xyz.y = value;
         this.color = this._xyz.color;
      }
      
      public function get z() : Number
      {
         return this._xyz.z;
      }
      
      public function set z(value:Number) : void
      {
         this._xyz.z = value;
         this.color = this._xyz.color;
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(value:int) : void
      {
         this._color = value;
         this._cmyk.color = value;
         this._hsb.color = value;
         this._rgb.color = value;
         this._lab.color = value;
         this._xyz.color = value;
         this._gray.convertHexToGrayscale(value);
      }
   }
}
