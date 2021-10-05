package flashx.textLayout.property
{
   [ExcludeClass]
   public class PercentPropertyHandler extends PropertyHandler
   {
       
      
      private var _minValue:Number;
      
      private var _maxValue:Number;
      
      private var _limits:String;
      
      public function PercentPropertyHandler(minValue:String, maxValue:String, limits:String = "allLimits")
      {
         super();
         this._minValue = Property.toNumberIfPercent(minValue);
         this._maxValue = Property.toNumberIfPercent(maxValue);
         this._limits = limits;
      }
      
      public function get minValue() : Number
      {
         return this._minValue;
      }
      
      public function get maxValue() : Number
      {
         return this._maxValue;
      }
      
      public function checkLowerLimit() : Boolean
      {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.LOWER_LIMIT;
      }
      
      public function checkUpperLimit() : Boolean
      {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.UPPER_LIMIT;
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         var newNumber:Number = Property.toNumberIfPercent(newVal);
         if(isNaN(newNumber))
         {
            return undefined;
         }
         if(this.checkLowerLimit() && newNumber < this._minValue)
         {
            return undefined;
         }
         if(this.checkUpperLimit() && newNumber > this._maxValue)
         {
            return undefined;
         }
         return newVal;
      }
   }
}
