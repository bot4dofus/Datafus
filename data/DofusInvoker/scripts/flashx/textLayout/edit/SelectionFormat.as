package flashx.textLayout.edit
{
   public class SelectionFormat
   {
       
      
      private var _rangeColor:uint;
      
      private var _rangeAlpha:Number;
      
      private var _rangeBlendMode:String;
      
      private var _pointColor:uint;
      
      private var _pointAlpha:Number;
      
      private var _pointBlendMode:String;
      
      private var _pointBlinkRate:Number;
      
      public function SelectionFormat(rangeColor:uint = 16777215, rangeAlpha:Number = 1.0, rangeBlendMode:String = "difference", pointColor:uint = 16777215, pointAlpha:Number = 1.0, pointBlendMode:String = "difference", pointBlinkRate:Number = 500)
      {
         super();
         this._rangeColor = rangeColor;
         this._rangeAlpha = rangeAlpha;
         this._rangeBlendMode = rangeBlendMode;
         this._pointColor = pointColor;
         this._pointAlpha = pointAlpha;
         this._pointBlendMode = pointBlendMode;
         this._pointBlinkRate = pointBlinkRate;
      }
      
      public function get rangeColor() : uint
      {
         return this._rangeColor;
      }
      
      public function get rangeAlpha() : Number
      {
         return this._rangeAlpha;
      }
      
      public function get rangeBlendMode() : String
      {
         return this._rangeBlendMode;
      }
      
      public function get pointColor() : uint
      {
         return this._pointColor;
      }
      
      public function get pointAlpha() : Number
      {
         return this._pointAlpha;
      }
      
      public function get pointBlinkRate() : Number
      {
         return this._pointBlinkRate;
      }
      
      public function get pointBlendMode() : String
      {
         return this._pointBlendMode;
      }
      
      public function equals(selectionFormat:SelectionFormat) : Boolean
      {
         if(this._rangeBlendMode == selectionFormat.rangeBlendMode && this._rangeAlpha == selectionFormat.rangeAlpha && this._rangeColor == selectionFormat.rangeColor && this._pointColor == selectionFormat.pointColor && this._pointAlpha == selectionFormat.pointAlpha && this._pointBlendMode == selectionFormat.pointBlendMode && this._pointBlinkRate == selectionFormat.pointBlinkRate)
         {
            return true;
         }
         return false;
      }
   }
}
