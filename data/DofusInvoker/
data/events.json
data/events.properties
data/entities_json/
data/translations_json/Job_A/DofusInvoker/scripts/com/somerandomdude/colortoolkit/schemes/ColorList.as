package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.Color;
   import com.somerandomdude.colortoolkit.spaces.IColorSpace;
   import com.somerandomdude.colortoolkit.spaces.RGB;
   
   public dynamic class ColorList extends Array
   {
       
      
      public function ColorList(numElements:int = 0)
      {
         super(numElements);
      }
      
      public function empty() : void
      {
         while(length)
         {
            this.splice(0,length);
         }
      }
      
      public function toRGB() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toRGB());
         }
         return list;
      }
      
      public function toHSB() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toHSB());
         }
         return list;
      }
      
      public function toCMYK() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toCMYK());
         }
         return list;
      }
      
      public function toColor() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            list.push(new Color(this[i] is IColorSpace ? int(this[i].color) : int(this[i])));
         }
         return list;
      }
      
      public function toHex() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.color);
         }
         return list;
      }
      
      public function toLab() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toLab());
         }
         return list;
      }
      
      public function toXYZ() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toXYZ());
         }
         return list;
      }
      
      public function toHSL() : ColorList
      {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         for(var i:int = 0; i < this.length; i++)
         {
            rgb.color = this[i] is IColorSpace ? int(this[i].color) : int(this[i]);
            list.push(rgb.toHSL()());
         }
         return list;
      }
   }
}
