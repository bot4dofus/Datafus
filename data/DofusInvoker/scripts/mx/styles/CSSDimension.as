package mx.styles
{
   import mx.utils.ObjectUtil;
   
   public class CSSDimension
   {
      
      public static const NO_UNIT:String = "";
      
      public static const UNIT_INCH:String = "in";
      
      public static const UNIT_CM:String = "cm";
      
      public static const UNIT_PT:String = "pt";
      
      public static const UNIT_DP:String = "dp";
      
      private static const UNIT_PX:String = "px";
      
      private static const INCH_PER_INCH:Number = 1;
      
      private static const CM_PER_INCH:Number = 2.54;
      
      private static const PT_PER_INCH:Number = 72;
      
      private static const DP_PER_INCH:Number = 160;
       
      
      private var _value:Number;
      
      private var _unit:String;
      
      private var _pixelValue:int;
      
      public function CSSDimension(value:Number, refDPI:Number, unit:String = "")
      {
         super();
         this._value = value;
         this._unit = unit;
         this._pixelValue = this.computePixelValue(refDPI);
      }
      
      public function get unit() : String
      {
         return this._unit;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function get pixelValue() : Number
      {
         return this._pixelValue;
      }
      
      public function compareTo(other:CSSDimension) : int
      {
         return ObjectUtil.numericCompare(this._pixelValue,other.pixelValue);
      }
      
      public function toString() : String
      {
         return this._value.toString() + this._unit;
      }
      
      private function computePixelValue(refDPI:Number) : int
      {
         switch(this._unit)
         {
            case UNIT_INCH:
               return this._value * refDPI;
            case UNIT_DP:
               return this._value * refDPI / DP_PER_INCH;
            case UNIT_CM:
               return this._value * refDPI / CM_PER_INCH;
            case UNIT_PT:
               return this._value * refDPI / PT_PER_INCH;
            default:
               return this._value;
         }
      }
   }
}
